module Roadmap
    def get_roadmap(chain_id)
      checkpoints = Hash.new
      count = 0
      response = self.class.get("/roadmaps/#{chain_id}", headers: { "authorization" => @auth_token })
      JSON.parse(response.body)
      @sections = response["sections"]
      @section_checkpoint = @sections.each do |x|
        x.each do |key, value|
          if key == "checkpoints"
            checkpoints[count] = value
          end
        end
        count += 1
      end
    end

    def get_checkpoint(checkpoint_id)
      x = []
      response = self.class.get("/checkpoints/#{checkpoint_id}", headers: { "authorization" => @auth_token })
      JSON.parse(response.body)
      response.each do |key,value|
        if key == "body"
          x[0] = value
        elsif key == "assignment"
          x[1] = value
        end
      end
      @checkpoint_body = x[0]
      @checkpoint_assignment = x[1]
    end
end
