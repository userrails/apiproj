class Api::BaseController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json
  before_filter :authenticate_user
   
  private
  def authenticate_user
    @user = User.find_by_authentication_token(params[:api_key])
    unless @user
      respond_to do |format|
        format.json{ render :json => { :error => "Api key is invalid." }}
      end
    end
  end
  
  def current_user
    @user
  end
end