require 'httparty'
require 'json'

class Kele
  include HTTParty
  default_options.update(verify: false)
  base_uri "https://www.bloc.io/api/v1"

  def initialize(email, password)
    options = {
      body: {
        email: email,
        password: password
      }
    }
    response = self.class.post('/sessions', options)
    raise ArgumentError, 'Invalid credentials' if response.code == 401
    @auth_token = response['auth_token']
  end
end
