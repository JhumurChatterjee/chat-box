class UsersController < ApplicationController
  def create
    user = User.new(user_params)

    if user.save
      jwt_token = Auth.issue(user: user.id)
      render_success(:created, user, meta: { jwt_token: jwt_token, message: "User has been successfully created." })
    else
      render_error(:unprocessable_entity, user.errors)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
