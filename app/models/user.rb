class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :payments
  has_many :favourites, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :baskets, through: :orders
  has_many :reviews, dependent: :destroy
  has_many_attached :images, dependent: :destroy
  has_many :pharmacies, dependent: :destroy

  has_one :basket, through: :order
  #new lines added below by simson
  has_one_attached :avatar
  belongs_to :payment, optional: true

  has_many :payments, dependent: :destroy
###################################

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :address, presence: true

end
