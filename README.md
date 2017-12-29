# text_gif - Send GIFs via SMS

This is a simple webapp developed for PatientsLikeMe's interview process.

Here's their prompt:

> Create an application that allows users to enter search text and a phone number. Your application will send a text message to that number with a related gif. We recommend using the Sinatra web application framework, the Twilio API for texting and the Giphy API. Please use our paid Twilio account, which will allow you to send messages to arbitrary numbers.
>
> TWILIO\_ACCOUNT\_SID=`<redacted>`
>
> TWILIO\_AUTH\_TOKEN=`<redacted>`
>
> TWILIO\_FROM\_NUMBER=`<redacted>`
>
> We don't expect perfection. We use this code sample to understand how you solve problems. Describe any notable software design decisions and next steps you would take if you were to develop this application further.

For the project to work, you need to export these environment variables with appropriate values.

To run the app, open a terminal, navigate to the directory, export these environment variables, and run:

`> bundle exec ruby app.rb`

The server will listen on localhost:4567 by default.

I had not used Sinatra, Twilio, Giphy, or Heroku prior to doing this project. They all seem very minimalist, so I think I'm using them correctly, but without feedback my code may not be idiomatic.

I originally started this project during the summer of 2016, but decided not to actually apply until winter of 2017 (hence the long pause in commit history).

I left myself a number of TODOs to indicate areas which I think could be improved "if I were to develop this application further".
