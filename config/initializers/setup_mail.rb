# frozen_string_literal: true

ActionMailer::Base.smtp_settings = {
  address: 'smtp.gmail.com',
  port: 587,
  domain: 'gmail.com',
  user_name: 'naseer.aslam@devsinc.com',
  password: 'mna00420',
  authentication: 'plain',
  enable_starttls_auto: true
}

ActionMailer::Base.default_url_options[:host] = 'localhost:3000'
