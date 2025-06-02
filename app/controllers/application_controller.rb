# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller? 

  def after_sign_in_path_for(resource)
    dashboard_path # <--- Isso redireciona para o dashboard após o login
  end

  def after_sign_out_path_for(resource)
    root_path # <--- Redireciona para a rota raiz (welcome#index, no seu caso) após o logout
  end

  protected 

  def configure_permitted_parameters
    # Permite o parâmetro :name durante o registro (sign_up)
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # Permite o parâmetro :name durante a atualização do perfil (account_update)
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end