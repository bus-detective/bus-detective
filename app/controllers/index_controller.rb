class IndexController < ApplicationController
  def show
    render text: redis.get(index_key)
  end

  private

  def index_key
    redis.get('realtime-metro-web-client:current')
  end

  def redis
    @redis ||= Redis.new(url: ENV.fetch('REDISTOGO_URL', nil))
  end
end