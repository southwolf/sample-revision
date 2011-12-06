class User
  include Mongoid::Document
  field :name
  field :email
  index :email, unique: true
  field :encrypted_password
  field :salt

  # Ruby method, creates virtual attribute
  attr_accessor :password
  
  # Rails method for mass assignment
  attr_accessible :name, :email, :password, :password_confirmation

  before_save :encrypt_password

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name,     :presence     => true,
                       :length       => { :maximum => 50  }
  validates :email,    :presence     => true,
                       :format       => { :with => email_regex },
                       :uniqueness   => { :case_sensitive => false }
  
  # Automatically create the virtual attribute 'password_confirmation'.                     
  validates :password, :confirmation => true,
                       :presence     => true,
                       :length       => { :within => 6..40 }

  def self.find_by_email(email)
    where(:email => email).first
  end

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end

private

  def encrypt_password
    self.salt = make_salt unless has_password?(password)
    self.encrypted_password = encrypt(password)
  end

  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end

  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end
end
