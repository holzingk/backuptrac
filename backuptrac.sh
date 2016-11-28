#!/bin/sh

####config
backuppath='/home/backupfolder'
tracurl='https://10.155.xx.xx/trac'
backupuser='backupuser'
password='bkp'
#somehow we need that:
header='Accept-Language: de,en-US;q=0.7,en;q=0.3'
#######################
now=$(date --iso-8601)
#set -e

##backuptrac with trac hotcopy
echo "Trac hotcopy"
rm -f "${backuppath}"/trac-hotcopy/trachotcopy-${now}.tar.gz
rm -fR /tmp/hotcopy
trac-admin /var/www/trac hotcopy /tmp/hotcopy
tar -czf "${backuppath}"/trac-hotcopy/trachotcopy-${now}.tar.gz -C /tmp/hotcopy .


#hidden form data:
echo "Login..."
wget --no-check-certificate --header="${header}" -a log.txt -O loginpage.html --keep-session-cookies --save-cookies cookies.txt "${tracurl}"/login 
hiddendata=`grep value < loginpage.html | grep __FORM_TOKEN | tr '=' ' ' | awk '{print $13}' | sed s/\"//g`
rm loginpage.html
#let's login
echo "Sending Login Data..."
postData=user="${backupuser}"'&'password="${password}"'&'__FORM_TOKEN=${hiddendata}'&'referer="${tracurl}"/
wget --no-check-certificate --header="${header}" -a log.txt -O /dev/null --post-data ${postData} --load-cookies cookies.txt --keep-session-cookies --save-cookies cookies.txt "${tracurl}"/login
#now the actual deal:
echo "Crawl entire trac"
wget --load-cookies cookies.txt --header="${header}" --no-check-certificate -a log.txt --reject logout --reject-regex '(.*)\?(.*)'  --mirror --wait=0 -erobots=off --no-parent --page-requisites --convert-links --adjust-extension --no-host-directories "${tracurl}"/
rm -f cookies.txt

#let's create an archive
echo "Create archive for tracstatic"

rm -f "${backuppath}"/trac-static-html/tracstatic-${now}.tar.gz
tar -czf "${backuppath}"/trac-static-html/tracstatic-${now}.tar.gz trac/

#also save it as pure html directory structure
echo "Move whole direcotry structure into backup"
rm -fR "${backuppath}"/trac-static-html/tracstatic/*
mv trac/ "${backuppath}"/trac-static-html/tracstatic/

#cleanup
echo "Cleanup"
rm -f log.txt
rm -fR trac/

echo "Done!"
