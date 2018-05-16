require 'httparty'

class Kele
  include HTTParty
  default_options.update(verify: false)
  base_uri "bloc.io/api/v1"

  def initialize(email, password)
    options = {
      body: {
        email: email,
        password: password
      }
    }

    response = HTTParty.post('/sessions', options)
    p response
  end
end
