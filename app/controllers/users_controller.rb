class UsersController < ApplicationController
  before_action :authenticate_user, only: :index

  def index
    users = User.other_users(current_user.id)
    render_success(:ok, users, meta: { message: "User list has been successfully fetched." })
  end

  def create
    user = User.new(user_params)

    if user.save
      jwt_token = Auth.issue(user: user.id)
      render_success(:created, user, meta: { jwt_token: jwt_token, message: "User has been successfully created." })
    else
      render_error(:unprocessable_entity, user.errors.full_messages)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
