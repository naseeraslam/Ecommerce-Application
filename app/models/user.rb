# frozen_string_literal: true

# This shiny device polishes bared foos
class User < ApplicationRecord
  validate :correct_document_picture_type

  after_commit :add_default_avatar, on: %i[create update]

  has_one_attached :avatar

  has_many :products, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :orders, dependent: :destroy

  after_commit :add_default_avatar, on: %i[create update]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize: '50x50!').processed
    else
      '/default.jpg'
    end
  end

  private

  def add_default_avatar
    unless avatar.attached?
      avatar.attach(
        io: File.open(
          Rails.root.join(
            'app/assets/images/default.jpg'
          )
        ), filename: 'default.jpg',
        content_type: 'image/jpg'
      )
    end
  end

  def correct_document_picture_type
    errors.add(:avatar, 'are missing') if avatar.attached? == false
    unless avatar.content_type.in?(%('image/jpg image/png image/jpeg'))
      errors.add(:avatar, 'needs to be in png,jpg or jpeg')
    end
  end
end
