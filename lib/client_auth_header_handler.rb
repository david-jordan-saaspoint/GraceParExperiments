require 'soap/header/simplehandler'

class ClientAuthHeaderHandler < SOAP::Header::SimpleHandler
  SessionHeader = XSD::QName.new("rn:enterprise.soap.sforce.com", "SessionHeader") 

  attr_accessor :sessionid
  def initialize
    super(SessionHeader)
    @sessionid = nil
  end 

  def on_simple_outbound
    if @sessionid
      {"sessionId" => @sessionid}
    end
  end

  def on_simple_inbound(my_header, mustunderstand)
    @sessionid = my_header["sessionid"]
  end
end