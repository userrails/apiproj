class Api::SessionsController < Devise::SessionsController
	skip_before_filter :verify_authenticity_token
	skip_before_filter :verify_signed_out_user, :only => [:destroy]
  respond_to :json

 #curl -X POST -d 'user[email]=test1@gmail.com&user[password]=123123123' http://localhost:3000/api/users/sign_in.json
def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#new")
    sign_in(resource_name, resource)
    respond_to do |format|
      format.json {
        return render :json => { :authentication_token => resource.authentication_token, :user_id => resource.id, :success => true, :status => :created}
      }
   end
end
  
  #should log out the user, changing the authentication token.
  #curl -X DELETE -d 'api_key=KJymebg-HT' http://localhost:3000/api/users/sign_out.json
def destroy
    # expire auth token   
	    @user=User.where(:authentication_token=>params[:api_key]).first
	    if @user.present?
	    #@user.reset_authentication_token!
      token = Devise.friendly_token[0,20]
      unless @user.authentication_token == token
        @user.update_attributes(:authentication_token => token)
      end
	    render :json => { :message => ["Session deleted."], :success => true, :status => :ok}
	   else
		    respond_to do |format|
          format.json{ render :json => { :error => "Api key is invalid." }}
        end
	   end
  end
end