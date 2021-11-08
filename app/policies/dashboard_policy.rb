# frozen_string_literal: true

class DasboardPolicy < ApplicationPolicy
  def index?
    true
  end

  private

  def product
    record
  end
end
