class SlackController < ApplicationController
  skip_before_action :verify_authenticity_token
  def process
    Rails.logger.info '*' * 100
    Rails.logger.info params.inspect
    Rails.logger.info '*' * 100

  end
end