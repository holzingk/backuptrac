#backuptrac

This Bash-Script will
- Perform a trac-hotcopy and archive it with tar and a datestamp
- Login into a [Trac](https://trac.edgewall.com)-Installation with [AccountsManagerPlugin](https://trac-hacks.org/wiki/AccountManagerPlugin)
- Crawl the whole Trac project, archive it and save it with a datestamp
- Also save the raw version of the crawl (without an archive)

It was some work to get the login done right, maybe someone finds this useful.

##License GNU GPL 3
see [LICENSE.md](LICENSE.md)
