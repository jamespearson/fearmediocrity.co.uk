---
title: "Tips for creating HTML Emails"
description: "How we made an interactive store front with real time touch voting for French Connection."
tags: client work, responsive, campaign
layout: article
---

Programming HTML for email is just like programming for the web, in 1994. All email clients have different quicks, and varying levels of support for CSS and web standards.
READMORE

For example, since Outlook 2007, Word has been the rendering engine for HTML emails in Outlook, instead of Internet Explorer which was in Outlook 2003.

## Code like it's 1998, a brief history of HTML emails

Before the web standards movement, sites used HTML tables for everything.

As the web developed, and support for web standards grew, we moved to using the box model and a combination of float and position to line up elements.

Unfortunately HTML email didn't follow suite, and is still in a state where tables are still the primary layout mechanism.

In some cases support for web standards decreased. For example, Outlook switched from Internet Explorer's rendering engine to Word's since Outlook 2007.

## What clients should I care about?

This depends on the client. In the past I've had clients who used Lotus Note 7 as their main coperate email client, and some who get 90% of their reads on newer mobile devices.

As a general rule I code to support the following:

### Desktop clients
-  Apple Mail 6, 7 and 8
-  Live Mail
-  Lotus Notes 8 and 8.5
-  Outlook 2003, 2007, 2010, 2013
-  Thunderbird 12
-  Windows Mail

### Web based clients (in IE9+, Firefox, Chrome)
-  AOL
-  Gmail
-  Office 365
-  Outlook.com
-  Yahoo

### Mobile Clients
-  Android 2.3 - Phone
-  Android 4 - Phone and Tablet
-  iPhone 4 (iOS7)
-  iPhone 5 (iOS8)
-  Kindle Fire 2.3

The collection spans over 11 years from the oldest, Outlook 2003, to web based clients, that may continuously update.

## What you can't use.

Let's take a quick look at what techniques we can't use if we want our email to render as intended. This list isn't exhaustive, but should be enough to set you on the correct course.

##External Style Sheets
Security prevents external CSS files from loading. If you want to use CSS attribues then you need to include them in a style tag in the head. This isn't supported in Gmail.

###Floats
Using floats to position elements is common for regular sites, but support is lacking in the Outlook range.

### HTML Video, Audio or Canvas
Only the iPhone seems to have made strides in to supporting new HTML media elements, so it's better to avoid them for nod.

### Self closing tags
Although HTML5 specifications state that self closing tags are optional, a lot of developers still use them out of habit. For example when I add am image to page I use:

	<img src="myimage.jpg" alt="Sample" />

Lotus Notes renders this badly, so it's better to forget the /.

### Background Images
Support is growing for background images, but not in Outlook, which will completely ignore them.

### Position
Apple Mail is the only client that seems to support position correctly. Avoiding it will make things easier.


## Summary

Hopefully these top will I plan to make a follow up to this email detailing how I create HTML emails. In the mean time, if you need any help, give me a shout view any of the contact buttons above.
