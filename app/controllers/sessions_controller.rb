class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:success] = 'Bon retour parmis nous!'
      session[:user_id] = user.id
      redirect_to user_path(user), status: :see_other
    else
      flash.now[:danger] = 'Identifiants incorrects'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:sucess] = 'A bientot!'
    redirect_to root_path, status: :see_other
  end
end
