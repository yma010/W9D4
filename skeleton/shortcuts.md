def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
end

def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
end

def reset_session_token!
    self.update!(session_token: self.class.generate_session_token)
    self.session_token
end

def is_password?(password)
    bcrypt_password = BCrypt::Password.new(self.password_digest) 
    bcrypt_password.is_password?(password) 
end

def self.find_by_credentials(email, password)
    user = User.find_by(param: param) # could be a user, could be nil
    return nil unless {user} && {user}.is_password?(password) # is_password? only executes if user is a User object, not nil
    user
end



