class User
  module Authenticatable

    module ClassMethods
      def from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
          user_names = auth.info.name.split
          user.first_name = user_names.first
          user.last_name = user_names.last
          user.email = auth.info.email
          user.sex = 'Custom'
          user.dob = 20.years.ago
          user.password = Devise.friendly_token[0, 20]
          user.image = auth.info.image
        end
      end
  
      def new_with_session(params, session)
        super.tap do |user|
          if (data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info'])
            user.email = data['email'] if user.email.blank?
          end
        end
      end
    end
  end
end