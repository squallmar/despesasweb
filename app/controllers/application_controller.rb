class ApplicationController < ActionController::Base
   before_action :authenticate_user!

   def after_sign_in_path_for(resource)
    dashboard_path # <--- Isso redireciona para o dashboard após o login
  end

  def after_sign_out_path_for(resource)
    root_path # <--- Redireciona para a rota raiz (welcome#index, no seu caso) após o logout
  end
end
