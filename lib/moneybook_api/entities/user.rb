class User < Hanami::Entity
  def show_info
    self.to_h.tap { |attributes| attributes.delete(:password_digest) }
  end
end
