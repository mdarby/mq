#mq

A Rails gem that generates an MVC stack that does email queuing

What it does
------------
mq is a generator that generates an MVC stack for queuing emails. It has a UI too.
I got tired of dealing with crappy email queuing systems in Rails, so I wrote my own.

###Requirements

None.

###How to Install
<pre><code>sudo gem install mq -s http://gemcutter.com</code></pre>

###How to Use

Assuming you'd like to name your mq table `Email`, and your Mailer model is named `Notifier`

Generate the files necessary for your app:
<pre><code>./script/generate mq Email Notifier</code></pre>

mq requires your Mailer methods accept an email address as its first parameter, so a Mailer method should look like:
<pre><code>Notifier.send_email_method(email_address)</code></pre>

Of course, you can pass as many parameters as you'd like:
<pre><code>Notifier.send_email_method(email_address, some_object, some_other_object, ...)</code></pre>

Queue an email by calling `Email.queue` with the name of your Notifier method as the first parameter, and the recipient email address as the second parameter, followed by anything else you'd like to pass.
<pre><code>Email.queue(:send_email_method, "matt@matt-darby.com")</code></pre>

You can pass multiple email addresses to the `Email.queue` method and mq will automatically generate individual emails for the recipients.
<pre><code>Email.queue(:send_email_method, ["matt@matt-darby.com", "foo@bar.com"], ...)</code></pre>

###Delivery of queued email

You can create a cronjob (this on runs every five minutes)
<pre><code>*/5 * * * * cd /path/to/your/app && ./script/runner/Email.deliver_all</code></pre>

###How to Test

Complete Rspec specs are included automatically. Well, complete aside from view specs as you'll just change the damned things anyway.

About the Author
----------------
My name is [Matt Darby.](http://blog.matt-darby.com) I’m an IT Manager and pro-web-dev at for [Dynamix Engineering](http://dynamix-ltd.com) and hold a Master’s Degree in Computer Science from [Franklin University](http://www.franklin.edu) in sunny [Columbus, OH.](http://en.wikipedia.org/wiki/Columbus,_Ohio)

Feel free to check out my [site](http://matt-darby.com) or [recommend me](http://www.workingwithrails.com/person/10908-matt-darby)
