require 'httparty'
require 'json'
require_relative 'roadmap'

class Kele
  include HTTParty
  include Roadmap
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

  def get_me
    response = self.class.get('/users/me', headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

  def get_mentor_availability(id)
  ## chain_id = 7094
  ##  mentor_id = get_me["current_enrollment"]["mentor_id"] 529277
    response = self.class.get("/mentors/#{id}/student_availability", headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

  def get_messages(page = nil)
    if !page
      response = self.class.get("/message_threads", headers: { "authorization" => @auth_token })
    else
      response = self.class.get("/message_threads", headers: { "authorization" => @auth_token }, body: { page: page})
    end
  end

  def create_message(sender, recipient_id, token = nil, subject = nil, stripped_text)
    options = {
      body: {
        sender: sender,
        recipient_id: recipient_id,
        token: token,
        subject: subject,
        "stripped-text": stripped_text
      }
    }
    response = self.class.post("/messages",  options)
  end
end
