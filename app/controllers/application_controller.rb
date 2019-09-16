# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authorized_to_edit?, only: :edit

  private

  def authorized_to_edit?
    model = params[:controller].classify.safe_constantize
    if (resource = model.find_by(id: params[:id]))
      return if resource.can_edit?(current_user)

      flash[:post_notice] = 'You are not authorized to edit!'
    else
      flash[:post_notice] = "The #{model.to_s.downcase} you wish to to interact with has been removed or never existed!"
    end
    redirect_to root_path
  end

  def save_referrer
    session[:edit_ref] = request.referrer
  end

  def back_with_anchor(anchor: '')
    dest = request[:action] == 'update' ? session[:edit_ref] : request.referrer
    "#{dest}##{anchor}"
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email first_name last_name sex dob])
  end
end
