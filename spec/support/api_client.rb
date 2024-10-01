require 'httparty'

class ReqresAPI
  include HTTParty
  base_uri 'https://reqres.in/api'

  def get_users(page = 1)
    self.class.get("/users?page=#{page}")
  end

  def get_user(user_id)
    self.class.get("/users/#{user_id}")
  end

  def create_user(user_data)
    self.class.post("/users", body: user_data.to_json, headers: { 'Content-Type' => 'application/json' })
  end

  def update_user(user_id)
    self.class.put("/users/#{user_id}")
  end

  def delete_user(user_id)
    self.class.delete("/users/#{user_id}")
  end
end
