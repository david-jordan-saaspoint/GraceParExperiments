#!/usr/bin/env ruby

require 'rubygems'
require 'oauth'

consumer = OAuth::Consumer.new "Dg8BCI3ACmYU1gm66QtO5w",
                      "7hkFjS0t7PI4yGW1UCkVTiGdwwD6Gqm4OR3izkVs0",
                      { :site => 'http://twitter.com/',
                        :request_token_path => '/oauth/request_token',
                        :access_token_path => '/oauth/access_token',
                        :authorize_path => '/oauth/authorize'}

request_token = consumer.get_request_token
puts "Place \"#{request_token.authorize_url}\" in your browser"
print "Enter the number they give you: "
pin = STDIN.readline.chomp

access_token = request_token.get_access_token(:oauth_verifier => pin)

puts access_token.get('/account/verify_credentials.json')