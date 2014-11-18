class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  def after_sign_in_path_for(resource_or_scope)
		if resource_or_scope.is_a?(User)
			root_path
		end
	end

	def after_sign_up_path_for(resource_or_scope)
		root_path
	end

 def is_login?
    unless current_user
      flash[:error] = "Please login"
      redirect_to '/'
    end
  end

end