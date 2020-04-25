class ApplicationController < ActionController::Base

	# devise利用の機能（ユーザ登録、ログイン認証など）が使われる場合、その前にconfigure_permitted_parametersが実行される。
	before_action :configure_permitted_parameters, if: :devise_controller?

	# 下記のconfigure_permitted_parametersは、nameのデータ操作を許可するアクションメソッド
	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
	end

	def after_sign_in_path_for(resource)
		if current_user
			flash[:notice] = "ログインに成功しました。"
			user_path(current_user)
		end
	end

end
