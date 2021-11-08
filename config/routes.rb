# frozen_string_literal: true

Rails.application.routes.draw do
  resources :dashboard do
    collection do
      get :cart
      get :search
      post :set_quantity
    end
    member do
      post :add_to_cart
      delete :remove_from_cart
      delete :remove_item_cart
    end
  end

  resources :checkout, only: %i[create] do
    collection do
      get :success
      get :cancel
    end
    member do
      post :add_to_cart
      delete :remove_from_cart
      delete :remove_item_cart
    end
  end

  resources :products do
    resources :comments
  end

  root 'dashboard#index'

  devise_for :users
end
