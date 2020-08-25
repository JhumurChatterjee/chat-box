class HomeController < ApplicationController
  before_action :authenticate_user, only: [:authenticate]

  def index
    render_success(:ok, meta: { message: "Api is working. Wuhoo..!!" })
  end

  def authenticate
    jwt_token = Auth.issue(user: current_user.id)
    render_success(:ok, current_user, meta: { jwt_token: jwt_token, message: "User has been successfully authenticated." })
  end
end
