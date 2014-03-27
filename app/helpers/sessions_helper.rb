module SessionsHelper

	def sign_in(user)
		remember_token = User.new_remember_token
		cookies.permanent[:remember_token] = remember_token
		user.update_attribute(:remember_token, User.encrypt(remember_token))
		self.current_user = user
	end

	def signed_in?
		!current_user.nil?
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		remember_token = User.encrypt(cookies[:remember_token])
		@current_user ||= User.find_by(remember_token: remember_token)
	end

	def current_user?(user)
		user == current_user
	end

	def sign_out
		current_user.update_attribute(:remember_token, User.encrypt(User.new_remember_token))
		cookies.delete(:remember_token)
		self.current_user = nil
	end

	def signed_in_user
		unless signed_in?
			store_location
			redirect_to logowanie_url, notice: "Jesteś niezalogowany"
		end
	end

	def admin_user
		redirect_to root_url, notice: "Nie masz wystarczających uprawnień" unless current_user.admin?
	end

	def correct_user
		@user = User.where('lower(username) = ?', params[:id].downcase).first
		redirect_to root_url, notice: "brak uprawnień" unless current_user?(@user) || current_user.admin?
	end

	def owner_or_moderator(object)
		@user = User.find_by(id: object.user_id)
		redirect_to root_url, notice: "brak uprawnień" unless current_user?(@user) || current_user.admin? || current_user.moderator?
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default )
		session.delete(:return_to)
	end

	def store_location
		session[:return_to] = request.url if request.get? if session[:return_to].blank?
	end

	def store_referer
		session[:return_to] = request.referer
	end

	def administrator
		current_user && current_user.admin?
	end

	def owner(object)
		current_user && current_user.id == object
	end

	def moderator_user
		redirect_to root_url, notice: "Nie masz wystarczających uprawnień" unless current_user.moderator? || current_user.admin?
	end

	def editor_user
		redirect_to root_url, notice: "Nie masz wystarczających uprawnień" unless current_user.editor? || current_user.admin?
	end

end
