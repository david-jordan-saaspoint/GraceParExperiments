#!/usr/local/bin/ruby -w

require 'erb'
require 'webrick'
require 'search'

# The Search Web Application
class SearchServer < WEBrick::HTTPServer

  def initialize(config = {})
    super(config)

    # HTML template
    @html = ERB.new <<-xXx
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns='http://www.w3.org/1999/xhtml'>
  <head>
    <meta http-equiv="Content-Type" content='text/html; charset=UTF-8' />
    <link rel="stylesheet" href="/styles/search.css" type="text/css" media="screen" charset="utf-8" />
    <script src="/scripts/prototype.js" type="text/javascript" charset="utf-8"></script>
    <script src="/scripts/effects.js" type="text/javascript" charset="utf-8"></script>
    <script src="/scripts/controls.js" type="text/javascript" charset="utf-8"></script>
    <script src="/scripts/search.js" type="text/javascript" charset="utf-8"></script>
    <title>LUG Programming Course, Lesson 7</title>
  </head>
  <body>
    <p class='title'>Example of Ruby and Ajax</p>
    <form id='searchForm' action='/search'>
      <p class='search'>
        <label for="search">Search word:</label>
        <input type="text" id="search" name="search" maxlength='20' value='<%= word %>' />
      </p>
      <div id="results" class="autocomplete" style="display: block;">
        <p>Results:</p>
        <%= links %>
      </div>
    </form>
  </body>
</html>
xXx

    # HTML/Ajax template
    @ajax = ERB.new <<-xXx
<ul>
<% results.each do |r| %>
  <li><a href='<%= r.url %>' type='text/plain'><%= r.title %> (<%= r.count %>)</a></li>
<% end %>
<% if results.length == 0 && is_html %>
  <li>No matches found, sorry.</li>
<% end %>
</ul>
xXx

    # Search engine initialisation
    @engine = SearchEngine.new('../public/text', '../public', '')
    @engine.files.each { |file| logger.info "Loaded #{file.to_s} URL: #{file.url}" }

    # Define the server mount points
    mount('/', WEBrick::HTTPServlet::FileHandler, '../public')
    mount_proc('/search') { |req, resp| search(req, resp, true) }
    mount_proc('/word')   { |req, resp| search(req, resp, false) }
  end

  # Define the dynamic (HTML form or Ajax) word search response
  def search(request, response, is_html)
    word = request.query['search'] || ''
    word.strip!
    results = @engine.search(word)
    response['Content-Type'] = 'text/html'
    links = @ajax.result(binding)
    if is_html
      response.body = @html.result(binding)
      logger.info "HTML Word: '#{word}' Results: #{results.inspect}"
    else
      response.body = links
      logger.info "Ajax Word: '#{word}' Results: #{results.inspect}"
    end
  end
end

# Create the server
server = SearchServer.new(:Port => 8086)

# trap signals to invoke the shutdown procedure cleanly
['INT', 'TERM'].each do |signal|
  trap(signal) { server.shutdown } 
end

# Start the server
server.start