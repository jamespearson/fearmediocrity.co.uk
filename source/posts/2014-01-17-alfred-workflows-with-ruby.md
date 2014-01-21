---
title: Alfred Workflows with Ruby
description: Creating a simple Alfred 2 Workflow to retrive numbers form SayNoTo0780, using Ruby.
tags: ruby, alfred, projects
---

On a whim, I recently decided to learn more about creating workflows for [Alfred](http://www.alfredapp.com/) using Ruby.

At least a couple of times a week I get a conference call request, which involves calling an expensive (from mobile) 0870 or 0845 number. Because of this, I use [SayNoTo0870](http://www.saynoto0870.com) to find cheaper alternate numbers and have decided to make a workflow to display data.
READMORE

![alternate text](/img/2014-01-17-a.png)

## Creating the data source
SayNoTo0870 doesn't have a public api (or a site designed in the last 10 years), so the first step will be converting their HTML into a useable format.

Firstly, I considered using a combination of Nokogiri and HTTParty to scrape the data from the end users machine as part of the workflow. However, Alfred supports OS X back to 10.6 (Snow Leopard) which means supporting Ruby 1.8 and above, ruling out these options.

My backup plan was to create a proxy api, using Sinatra, to scrape the page and convert the data to JSON format. This could then be hosted on Heroku's free tier, and power the workflow for a modest amount of users.

The data source scours SayNoTo0870 for data and returns it in a the following JSON format:

    {
    "verified": [
        {
            "company_name": "BT Yahoo Internet | BT Internet (BT-)",
            "type": "free",
            "number": "0800 6335335",
            "other_information": "BT- Dial-up Support Services"
        },
        {
            "company_name": "BT Yahoo Internet | BT Internet (BT-)",
            "type": "free",
            "number": "0800 0852819",
            "other_information": "Cancellations"
        },
        {
            "company_name": "BT Yahoo Internet | BT Internet (BT-)",
            "type": "normal",
            "number": "+441214789200",
            "other_information": "BT- PAYG Dial-Up;Use FULL International number otherwise ISP exclusion list means you will be charged the 0845 rate"
        },
        {
            "company_name": "BT Yahoo Internet | BT Internet (BT-)",
            "type": "normal",
            "number": "+441214789300",
            "other_information": "BT- PAYG (ISDN) Dial-Up;Use FULL International number otherwise ISP exclusion list means you will be charged the 0845 rate"
        }
    ],
    "unverified": [
        {
            "company_name": "BT INTERNET HELP",
            "type": "free",
            "number": "0800 1114567",
            "other_information": ""
        },
        {
            "company_name": "XPG",
            "type": "normal",
            "number": "07702 949318",
            "other_information": "Entertainment agency\r\nBT Internet line: 05601 129298"
        }
    ]
}

The source code for the api can be found on [Github], (https://github.com/FearMediocrity/saynoto0870-api), or can be accessed via a post request to (http://saynoto0870.fearmediocrity.co.uk) with either a *number* or *company* parameter.

## Downgrading Ruby to 1.8.7

As previously mentioned, Alfred 2 supports from OSX 10.6 and upwards, which means for the workflow to work on all currently supported systems we have to support Ruby 1.8 and up.

As an RVM user the downgrade process was simple enough

    rvm install 1.8.7
    rvm use 1.8.7 --default

By setting 1.8.7 to the system default it will ensure your workflow works on older OSX versions. However, don't forget to switch back to a moderner Ruby later using:

    rvm use system --default

## The Alfred Workflow

Using Zhao Cai's [alfred2-ruby-template](https://github.com/zhaocai/alfred2-ruby-template) as a starting point makes the whole process relatively simple. Download the template then ````rake install to install the workflow or ````rake dbxinstall if you are using Alfred's Dropbox sync.

This will install your workflow into Alfred's Workflow Manager.

![alternate text](/img/2014-01-17-b.jpg)

### Setting the meta data

In the Workflow manager, right click the "Ruby Based Workflow Template" and select "Edit", this will allow you to customise your workflow with your own information.

![alternate text](/img/2014-01-17-c.jpg)

### The workflow

For this workflow, I used the Script Filter, which listens to Alfred for a certain keyword trigger then passes the subsequent query to a Ruby script.

The setup remains very similar to the one provided in alfred2-ruby-template, but with a few minor changes:

1. I changed "Argument Optional" to be "Argument Required" meaning that the script should never be executed without a user query.

2. The script was changed from ````/usr/bin/ruby ./main.rb {query} to ````/usr/bin/ruby ./main.rb "{query}". This was to ensure that a string (even a blank one) always gets passed from Alfred to the ruby script.

3. As the query string is now enclosed in speech marks, the only type of escaping that is required is "Double Quotes"

## Bundler
While the default script in workflow/main.rb reffers to ````require "bundle/bundler/setup" this initially caused errors for me, as the requirement could not be fulfilled.

This is because to distribute the workflow we need to package any gems locally, and not rely on installing them to the system.

If you encounter any problems with this install the gems in standalone mode with the command:

    bundle --standalone

## The Ruby Script

When a user triggers the keyword, the script [workflow/main.rb](https://github.com/FearMediocrity/alfred2-saynoto0870/blob/master/workflow/main.rb) executes.

The scripts functionality can be broken down as follows:

    Alfred.with_friendly_error do |alfred|
  fb = alfred.feedback

  query = ARGV[0]

By wrapping the script in ''''Alfred.with_friendly_error we allow the script to display a message if their is a technical error:

![alternate text](/img/2014-01-17-d.jpg)

It also allows the error to be logged to '''' ~/Library/Logs/Alfred-Workflow.log which will be essential in debugging those Ruby 1.8 problems.

    query = ARGV[0]

    uri = URI.parse("http://saynoto0870.fearmediocrity.co.uk/")

    if (query.gsub(" ","") =~ /[0-9]+/)
        alfred.ui.debug "Searching Numbers: #{query}"
        response = Net::HTTP.post_form(uri, {"number" => query.gsub(" ",""), "workflow_version" => WORKFLOW_VERSION})
    else
        alfred.ui.debug "Searching Companies: #{query}"
        response = Net::HTTP.post_form(uri, {"company" => query, "workflow_version" => WORKFLOW_VERSION})
    end

    json_response = JSON.parse(response.body)

Here we are taking the users query and sending it to the API server as either a company name or expensive number.

The server will return JSON, which is parsed in to a ruby hash, and looped through to add the items alfred will display.

    fb.add_item({
        :uid => uid,
        :title    => result["number"] ,
        :subtitle => result["subtitle"] ,
        :valid    => "yes"
      })

Once every item has been added we return the items as XML for Alfred to process:

    puts fb.to_xml if fb.items.count > 0

While the alfred2-ruby-framework takes care of formatting the XML to Alfred's specifications, you can find specific examples in the Workflow Manager

![alternate text](/img/2014-01-17-d.jpg)

##

Alfred does not currently have the option to wait for the user to finish typing before executing the script.

This means that if the user is searching for "British Gas" the script will trigger as follows:

    /usr/bin/ruby ./main.rb "B"
    /usr/bin/ruby ./main.rb "Br"
    /usr/bin/ruby ./main.rb "Bri"
    /usr/bin/ruby ./main.rb "Brit"
    etc etc

To overcome this I did two things. The first was to not send the search to the API server if the user is searching for a number and hasn't provided enough digits.

The second thing was to return the query string as part of the "no results found message" so the user would see their search may not have finished yet.

## Testing

I use VMWare for cross browser testing, and this is also capable of running Virtual Machines for OSX 10.7 upwards. This provides a vanilla environment to install Alfred 2 and your workflow..

While I haven't done it, it should be possible to create a similar environment using VirtualBox or other software... if all else fails then bug your friends on earlier versions of OSX.

## Exporting the finished product.

Once you've tested, and are happy with the finished workflow you can export it for distribution by right clicking the workflow name in the workflow manager and selecting "Export".

Exporting the workflow creates a self contained version of the script, with gems and all, so be careful to not overwrite your working copy. Export to Desktop or somewhere unrelated to be safe.

## Future Options

### Caching
At the moment neither the server or the workflow cache their results, so each lookup is a new request. If I were going to extend this future I'd look at adding caching on both ends.

### Testing
This little project was only supposed to take a couple of hours, so I decided not to go with my normal Test Driven Development approach.
If I find some time I may go back and add tests to at least the API server.

## The Finished Product

The finished code can be found at:

*   [Exported Workflow](https://github.com/FearMediocrity/alfred2-saynoto0870/raw/master/binary/alfred-2-saynoto0870.alfredworkflow)
*   [Workflow Source Code](https://github.com/FearMediocrity/alfred2-saynoto0870)
*   [API Server](https://github.com/FearMediocrity/saynoto0870-api)
