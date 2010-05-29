# rakegrowl

Do you recognize this situation? You run a `rake` task (for example, `rake spec`), which you know it's going to take some time (e.g. 3 or 4 minutes). You say _"Great moment to check what's going on on Twitter"_. 10 minutes and 3 tabs with blog posts later, you realize you were actually waiting for a task to finish, a task which finished long before. Bye, bye, productivity!!

**rakegrowl** tells you when your rake tasks end via [Growl](http://growl.info/).

_Fork:_
Forked to add support for rake abort and display different growl images based on the rake outcome

## Installation

You need to have [Growl](http://growl.info/) and `growlnotify` installed to get the notifications. Anyway, **rakegrowl** is harmless if there is no Growl.

To install this fork of **rakegrowl**, you need to run:

    git clone git://github.com/o-sam-o/rakegrowl.git
	cd rakegrowl/
	rake gem
	cd pkg/
	gem install rakegrowl
  
## Usage

In order to get your notifications, you have to run `rake` this way:

    $ rake -rubygems -r rakegrowl this:task that:another:task

You can even setup your system so you can run `rake` as usual and still get your notifications, by adding this into your `.bashrc` file:

    alias rake='rake -rubygems -r rakegrowl'
    
From now on, whenever you run a `rake` task, you'll get a notification when it finishes.

## Copyright & Licensing

Copyright (c) 2010 Sergio Gil. MIT license, see LICENSE for details.
