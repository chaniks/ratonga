require 'ratonga'
require 'ratonga/login'

describe Ratonga::Server do
  describe "#login" do
    it "should do something" do
      puts "#{subject}"
      sleep 1
      client = Ratonga::Client.new('test');
      client.password = 'test123'
      subject.login('test', 'test123').should be_true
    end
  end
end
