---
title: "Technology behind #CANTHELPMYSELFIE"
description: "How we made an interactive store front with real time touch voting for French Connection."
tags: client work, responsive, campaign
layout: article
---

Recently we completed an ambitious project for French Connection, titled #CANTHELPMYSELFIE. The campaign utilised a range of  technologies, to create a memorable impression of the Spring / Summer 2014 range.
READMORE

<iframe src="//player.vimeo.com/video/94516759?title=0&amp;byline=0&amp;portrait=0"  frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>

## How it worked
Throughout the summer the campaign toured French Connection stores around the country. Each selected store would host a “selfie” party, with bookable appointments,   and a drop in day.

## The models
Whilst in-store, participants modeled the latest fashion, then visited the specifically constructed "selfie booth". Once in the both the user would take several self portraits, via a custom made Android app, and submit the best 3 to the contest.

## The contest
Once submitted the participants entry was show:


<img src="/img/work/cant-help-my-selfie/desktop.jpg" class="desktop" />
####In the store window
Each store window held 4 large displays, which would display participant images and the current vote count. The participants on display rotated every few minutes to ensure an equal amount of screen time for all entries.

#### On the campaigns homepage
The participants on display on the homepage matched those on the screens in store, and rotated similarly.

#### On a generated social media "share" page
Each participant received an email with their photos, and a unique URL to share on social media. This page allowed voting and liking of the image, and generated traffic from social media linking.

## Voting
Once on display the participant could received votes virtually via the web, or physically via the store window.

#### Voting via the web
We were keen not to limit access to voting by requiring a sign up / login mechanism, while limiting vote fraud.

To compromise between the two concerns we implemented the following:

* a browser fingerprint system to limit votes for a single participant from an individual browser.
* limited the number of votes per IP address per hour.
* Provided visual false positives to a user who was trying to game the system.

## Voting via the store
The store front held 4 large screen displays, and in front of each screen was a webcam hooked up to a Mac Mini. A bespoke app monitored the each webcam, waiting for a passer by to place there hand in front of the camera to case their vote.

Votes from the web cam system were cast in 2 places, one to the Ruby on Rails application that powered the majority of system. The second vote was cast to a local node.js server, that triggered a visual sign on the appropriate screen.

## The website

The website had three separate states:

* The pre-launch that promoted the campaign and offered bookable appointments.
* The live site was similar to the pre-launch site, but featured participants and voting.
* The post-live site, which displayed the winners for each event and various sub-categories.

The post live site is still available at: http://selfie.frenchconnection.com


