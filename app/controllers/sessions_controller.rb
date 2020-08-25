class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:session][:email]&.downcase)

    if user&.authenticate(params[:session][:password])
      jwt_token = Auth.issue(user: user.id)
      render_success(:ok, user, meta: { jwt_token: jwt_token, message: "User has been successfully logged in." })
    else
      render_error(:unauthorized, ["Invalid email or password."])
    end
  end
end
