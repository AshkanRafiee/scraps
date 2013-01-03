#!/usr/bin/ruby

require "forgery"

firstname = Forgery::Name.first_name
lastname  = Forgery::Name.last_name
username  = Forgery::Internet.user_name
password  = Forgery::Basic.password

email     = username + "@mailinator.com"
webmail   = "http://www.mailinator.com/maildir.jsp?email=" + username

puts "First Name:     " + firstname
puts "Last Name:      " + lastname
puts "Username:       " + username
puts "Email address:  " + email
puts "Email web page: " + webmail
puts "Password:       " + password