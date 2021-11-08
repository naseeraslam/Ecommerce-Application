# frozen_string_literal: true

class ProductPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user
  end

  def update?
    user.present? && user == product.user
  end

  def destroy?
    user.present? && user == product.user
  end

  private

  def product
    record
  end
end
