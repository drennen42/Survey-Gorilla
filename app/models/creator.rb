class Creator < ActiveRecord::Base
  validates :username, uniqueness: true
	has_many :surveys
	has_many :questions, through: :surveys

  def connection
    self.connection
  end

  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password
  end

  def authenticate(password)
    self.password == password
  end

end
