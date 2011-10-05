require 'rest-client'

RestClient.get 'http://example.com/resource'

RestClient.get 'http://example.com/resource', {:params => {:id => 50, 'foo' => 'bar'}}

RestClient.get 'https://user:password@example.com/private/resource', {:accept => :json}

RestClient.post 'http://example.com/resource', :param1 => 'one', :nested => { :param2 => 'two' }

RestClient.post "http://example.com/resource", { 'x' => 1 }.to_json, :content_type => :json, :accept => :json

RestClient.delete 'http://example.com/res
ource'

response = RestClient.get 'http://example.com/resource'

RestClient.post( url,
  {
    :transfer => {
      :path => '/foo/bar',
      :owner => 'that_guy',
      :group => 'those_guys'
    },
     :upload => {
      :file => File.new(path, 'rb')
    }
  })