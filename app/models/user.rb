class User
  include Mongoid::Document
  field :name
  field :email
  index :email, unique: true

  attr_accessible :name, :email # Rails method for mass assignment

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name,  :presence   => true,
                    :length     => { :maximum => 50  }
  validates :email, :presence   => true,
                    :format     => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false } 
end
