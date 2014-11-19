class Api::RegistrationsControllerController < ApplicationController
	respond_to :json

	#curl -X POST -d 'user[email]=test1@gmail.com&user[time_zone]= Mexico city&user[password]=123123123' http://localhost:3000/api/users/sign_up.json
	def create
      user = User.new(params[:user])
      if user.save
        render :json=> user.as_json(:auth_token=>user.authentication_token, :email=>user.email), :status=>201
        return
      else
        warden.custom_failure!
        render :json=> user.errors, :status=>422
      end
  end
end