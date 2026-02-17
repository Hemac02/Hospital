require "savon"

class MySoapClient
  def initialize
    @client = Savon.client(
      wsdl: "http://localhost:3000/soap/wsdl",
      log: true,
      pretty_print_xml: true
    )
  end

  def call(operation, message = {})
    @client.call(operation, message: message)
  end
end
