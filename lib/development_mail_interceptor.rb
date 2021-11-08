# frozen_string_literal: true

class DevelopmentMailInterceptor
  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to = 'naseer.aslam@devsinc.com'
  end
end
