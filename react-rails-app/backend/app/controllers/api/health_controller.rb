class Api::HealthController < ApplicationController
  def check
    render json: {
      status: 'OK',
      message: 'Rails server is running!',
      timestamp: Time.current.iso8601,
      ruby_version: RUBY_VERSION,
      rails_version: Rails.version
    }
  end
end
