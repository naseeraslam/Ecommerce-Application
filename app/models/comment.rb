# frozen_string_literal: true

class Comment < ApplicationRecord
  validates :feedback, presence: true

  belongs_to :user
  belongs_to :product
  validates :feedback, presence: true
end
