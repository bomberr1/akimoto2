class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      # Success => Signup
      user.activate
      log_in user
      flash[:success] = "アカウント有効化!"
      redirect_to user
    else
      # Failure
      flash[:danger] = "アカウントを有効化してください。"
      redirect_to root_url
    end
  end
end
