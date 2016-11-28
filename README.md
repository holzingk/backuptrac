#backuptrac

This Bash-Script will
- Perform a trac-hotcopy and archive it with tar and a datestamp
- Login into a [Trac](https://trac.edgewall.org/)-Installation with [AccountsManagerPlugin](https://trac-hacks.org/wiki/AccountManagerPlugin)
- Crawl the whole Trac project, archive it and save it with a datestamp
- Also save the raw version of the crawl (without an archive) so you can browse your entire trac even when it is down just with static HTML files

Tested with Trac 1.0.1

It was some work to get the login done right, maybe someone finds this useful.

You can find it on [Github](https://github.com/nextl00p/backuptrac)
## Warning
Run the script on trac with an unprivileged user, so wget does not delete or alter pages!

##License GNU GPL 3
see [LICENSE.md](LICENSE.md)
