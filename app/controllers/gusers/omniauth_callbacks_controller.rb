# frozen_string_literal: true

class Gusers::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google
    @user = Guser.find_for_google(request.env['omniauth.auth'])
     #ユーザーがいたらそれを返し、いなければ作る。

    if @user.persisted?
      session[:guser_id] = ("#{@user.id}n")
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect @user, event: :authentication
    else
      session['devise.google_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

end
