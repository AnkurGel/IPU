%w(sinatra ./run).each {|x| require x}
run Sinatra::Application
