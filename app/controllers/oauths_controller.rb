class OauthsController < ApplicationController

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if auth_params[:denied].present?
      redirect_to root_path, notice: "#{provider.titleize}でログインしました"
      return
    end
    create_user_from(provider) unless (@user = login_from(provider))
    redirect_to root_path, notice: "#{provider.titleize}でログインしました"
  end

  private

    def auth_params
        params.permit(:code, :provider, :error, :state)
    end
end
