---
title: Customizing the Strong Parameters Missing Parameter Response
tags: example, programming
---


It turns out it's actually somewhat simple to change the response format. In the strong parameters gem, the following lines catch the `ActionController::ParameterMissing` error raised when a parameter is missing, and setup the aforementioned response:

READMORE

By default, the Rails Strong Parameter gem will render a text string with a 400 Bad Request status when a required parameter is ommitted:

``` text
Required parameter missing: first_name
```

This may not always be the desired result if, for example, you're developing an API and developers consuming your API expect a certain response format. This was actually the issue that I ran into, so I decided to dig into the strong parameters source and figure out how to adjust the repsonse.

It turns out it's actually somewhat simple to change the response format. In the strong parameters gem, the following lines catch the `ActionController::ParameterMissing` error raised when a parameter is missing, and setup the aforementioned response:

``` ruby
rescue_from(ActionController::ParameterMissing) do |parameter_missing_exception|
  render :text => "Required parameter missing: #{parameter_missing_exception.param}", :status => :bad_request
end
```

Now that we know what's producing that response, updating it is pretty straight forward. In a controller, in my case I'm using my base API controller, implement a new `rescue_from` block to handle the `ActionController::ParameterMissing` error as desired. Since I'm writing a JSON API, I've updated the response to return parameter errors in the same way ActiveRecord would return validation errors:

``` ruby
class API::V1::BaseController < ApplicationController

  rescue_from(ActionController::ParameterMissing) do |parameter_missing_exception|
    error = {}
    error[parameter_missing_exception.param] = ['parameter is required']
    response = { errors: [error] }
    respond_to do |format|
      format.json { render response, status: :unprocessable_entity }
    end
  end

end
```

With these changes in place, when a require parameter is not present, my API will now return a JSON object, instead of a string, that looks something like:

``` json
{
  "errors": [
    {
      "first_name": [
        "parameter is required"
      ]
    }
  ]
}
```

It's also worth noting that I changed the status code in the error response from 400 (Bad Request), to 422 (Unprocessable Entity). You can read about the differences between these two status codes [here](http://www.bennadel.com/blog/2434-HTTP-Status-Codes-For-Invalid-Data-400-vs-422.htm).