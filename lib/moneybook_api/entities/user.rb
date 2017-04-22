require "bcrypt"

class User < Hanami::Entity
  def show_info
    self.to_h.tap { |attributes| attributes.delete(:password_digest) }
  end

  def valid_password?(password)
    BCrypt::Password.new(self.password_digest) == password
  end
end
