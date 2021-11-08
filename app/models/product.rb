# frozen_string_literal: true

# This shiny device polishes bared foos
class Product < ApplicationRecord
  validates :product_name, :product_price, :quantity, presence: true
  validates :product_price, :quantity, numericality: true
  validates :product_name, :product_serial_number, uniqueness: true
  validate :correct_document_mime_type

  belongs_to :user

  has_many_attached :images
  has_many :comments, dependent: :destroy

  private

  def correct_document_mime_type
    errors.add(:images, 'are missing') if images.attached? == false
    images.each do |image|
      unless image.content_type.in?(%('image/jpg image/png image/jpeg'))
        errors.add(:images, 'needs to be in png,jpg or jpeg')
      end
    end
  end

  def search_data
    {
      product_name: product_name,
      product_description: product_description
    }
  end
end
