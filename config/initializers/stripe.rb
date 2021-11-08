# frozen_string_literal: true

require 'stripe'
Stripe.api_key = ENV['stripe_secret']
