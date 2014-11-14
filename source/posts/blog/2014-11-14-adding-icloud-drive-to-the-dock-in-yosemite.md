---
title: "Adding iCloud Drive to the Dock on Yosemite"
description: "Tutorial on how to add iCloud Drive to the Dock in OS-X 10.10, Yosemite"
tags: osx, yosemite, icloud, icloud drive, tips
layout: article
---

OS X 10.10, Yosemite, added iCloud drive, but it only appears in Finders sidebar, and cannot be easily added to the Dock.
READMORE

##TL;DR; In terminal run:

~~~shell
    ln -s  ~/Library/Mobile\ Documents/com~apple~CloudDocs ~/iCloud\ Shortcut; open ~/;
    # Then drag "iCloud Shortcut" to the right side of the Dock.
~~~
 
##Full story

Recently on Twitter, James Robinson asked if there was anyway to add iCloud Drive to the Dock on OS-X 10.10

<blockquote class="twitter-tweet" lang="en"><p>I want to create a shortcut to iCloud Drive on my dock. Dragging to create doesn’t work. How do you achieve it pls?</p>&mdash; Rob (James Robinson) (@jamesbrobinson) <a href="https://twitter.com/jamesbrobinson/status/533209843814129666">November 14, 2014</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>


I want to create a shortcut to iCloud Drive on my dock. Dragging to create doesn’t work. How do you achieve it pls?

I tried dragging it from sidebar on to the desktop, holding a variety of different keys, with no success.

I was on the verge of giving up, when I decided to try and locate the iCloud Drive folder in the file system, eventually finding it at:

~~~shell
~/Library/Mobile Documents/com~apple~CloudDocs
~~~

Now we know the location on the file system we can create a symbolic link (alias) to it in the root of our home directory

~~~shell
ln -s  ~/Library/Mobile\ Documents/com~apple~CloudDocs ~/iCloud\ Shortcut; open ~/;
~~~

Now we can drag "iCloud Shortcut" on to the right side of the dock, where it should become a stack by default. 

Job done.




