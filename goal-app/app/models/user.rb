# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord

    validates :username, :password_digest, :session_token, presence: true 
    validates :username, :session_token, uniqueness: true 
    validates :password, length: { minimum: 6 }, allow_nil: true 

    attr_reader :password
    after_initialize :ensure_session_token

    def self.find_by_credentials(username, password) 
      
        user = User.find_by(username: username)

        if user && user.is_password?(password)
            user
        else
            nil
        end

    end 

    def is_password?(password) 
        BCrypt::Password.new(self.password_digest).is_password?(password)     
    end 


    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
        @password = password
    end

    def generate_unique_session_token
        loop do
            session_token = SecureRandom::urlsafe_base64(16)
            return session_token unless User.exists?(session_token)
        end
    end

    def ensure_session_token
        self.session_token ||= generate_unique_session_token 
    end

    def reset_session_token! 
        self.session_token  = generate_unique_session_token 
        self.save! 
        self.session_token 
    end 

    has_many :goals,
    foreign_key: :user_id, 
    class_name: :Goal,
    dependent: :destroy

end
