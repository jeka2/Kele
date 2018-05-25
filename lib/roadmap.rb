module Roadmap
    def get_roadmap(chain_id)
      checkpoints = Hash.new
      arr = []
      response = self.class.get("/roadmaps/#{chain_id}", headers: { "authorization" => @auth_token })
      JSON.parse(response.body)
      @sections = response["sections"]
      @sections.each do |x|
        x.each do |key, value|
          if key == "checkpoints"
            arr << value
          end
        end
      end
      @section_checkpoints = arr
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
