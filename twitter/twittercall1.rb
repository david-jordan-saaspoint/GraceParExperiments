# TwitterTrends1.rb
    
    require 'oauth'
    
    twitteroauth = OAuth::Consumer.new("aSlCzmFgfK0X0n0dp5oWQ", "WgQmTJNFNh1MZ5InwF28UkhVVfFrD288GSEOdyk4SY")
    twitteroauth.authorize_from_access("78850640-DdoCHVfOLWD0M2OEEAuoshh1pLuKWfDIz9GUiirmQ", "A9Cc640zOMxxAoLxQKuvprtKtODch2g44rxckqYSMI")
    client = Twitter::Base.new(twitteroauth)
    message = Time.now.to_s
    client.update(message)