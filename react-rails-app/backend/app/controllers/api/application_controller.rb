class Api::ApplicationController < ApplicationController
  def health
    render json: {
      message: 'Rails API server is running!',
      timestamp: Time.current.iso8601,
      rails_version: Rails.version,
      ruby_version: RUBY_VERSION
    }
  end
end
