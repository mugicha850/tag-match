class Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController

    private def sign_up_params
        params.require(:registration)
        .permit(user: [
            :email,
            :password,
            :password_confirmation,
            :family_name,
            :given_name,
            :family_name_kana,
            :given_name_kana,
            :suspended,
            :created_at,
            :updated_at,
            :birthday,
            :sex,
            :role
        ])[:user]
    end
end
