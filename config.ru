require 'rack'

class RackApplication
  def call(env)
    [200, {'Content-Type' => 'text/plain'},['Hello!']]
  end
end

run RackApplication.new