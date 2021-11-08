# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def update?
    comment_helper?
  end

  def create?
    user.present?
  end

  def destroy?
    user && user.id == comment.user.id
  end

  private

  def comment
    record
  end

  def comment_helper?
    user && user.id == comment.user.id
  end
end
