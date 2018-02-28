class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  attr_accessor :login
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]

  has_many :my_lists, dependent: :destroy

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(name) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:name) || conditions.has_key?(:email)
      where(conditions.to_hash).first
    end
  end


  validates :name, presence: true, uniqueness: true, length: { in: 2..20 }
  def validate_username
    if User.where(email: name).exists?
      errors.add(:name, :invalid)
    end
  end



end
