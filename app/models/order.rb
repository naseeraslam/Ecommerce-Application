# frozen_string_literal: true

# This shiny device polishes bared foos
class Order < ApplicationRecord
  belongs_to :user
end
