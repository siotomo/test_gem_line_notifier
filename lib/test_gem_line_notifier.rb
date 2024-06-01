# frozen_string_literal: true

require_relative "test_gem_line_notifier/version"
require 'faraday'
require "json"
module TestGemLineNotifier
  class Error < StandardError; end
  # Your code goes here...
  API_TOKEN = ENV['LINE_NOTIFY_API_TOKEN'] || (raise('.envにLINE_NOTIFY_API_TOKENを設定してください'))

  def self.send_notification(message)
    conn = Faraday.new(url: 'https://notify-api.line.me/api/notify')
    response = conn.post do |req|
      req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
      req.headers['Authorization'] = "Bearer #{API_TOKEN}"
      req.params['message'] = message
    end

    # レスポンスの処理
    if response.success?
      data = JSON.parse(response.body)
      puts data
    else
      puts "Error: #{response.status}"
    end
  end
end
