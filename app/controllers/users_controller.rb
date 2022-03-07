class UsersController < ApplicationController
  before_action :load_user, only: %i[show update]
  TONES = ['humorous', 'ironic', 'cynical']
  def index
    render status: 200, json: User.all
  end

  def show
    render status: 200, json: @user
  end

  def update
    if @user.update_attributes(user_params)
      render status: 204, json: { success: true, info: 'Updated' }
    else
      render status: 422, json: { errors: @user.errors }
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      render status: 201, json: user
    else
      render status: 422, json: { errors: user.errors }
    end
  end

  def tone
    render status: 200, json: {tone: TONES[rand(3)]}
  end

  private

  def user_params
    allowed_params = [:name, :age, :phone, :email]
    params.require(:user).permit(allowed_params)
  end

  def load_user
    @user = User.find(params[:id])
  end
end
