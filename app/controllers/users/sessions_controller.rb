# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    # before_action :configure_sign_in_params, only: [:create]

    before_action :clean, only: [:destroy]
    skip_before_action :verify_authenticity_token, only: %i[update create]

    # GET /resource/sign_in
    # def new
    #   super
    # end

    # POST /resource/sign_in
    def create
      super
      current_or_guest_user
    end

    # DELETE /resource/sign_out
    def destroy
      super
      if guest_user.type == 'Guest'
        test = User.find(guest_user.id)
        test.clean_up
        User.find(guest_user.id).destroy
      end
    end

    # def clean
    #   puts "this is happening"
    #   if current_user.type == "Guest"
    #     puts "this aint happening"
    #     current_user.clean_up
    #   end
    # end
    # protected

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_in_params
    #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    # end
  end
end
