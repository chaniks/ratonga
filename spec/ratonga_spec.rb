require 'ratonga'

describe Ratonga::Server do

  its(:uri) { should be_a String }
  its(:uri) { should_not be_empty }
  its(:port) { should be 3931 }

  it "should start a drb service" do
    DRb.fetch_server(subject.uri).should_not be nil
  end
end

describe Ratonga::Client do
  its(:uri) { should be_a String }
  its(:uri) { should_not be_empty }
  its(:port) { should be_an Integer }
  its(:server) { should_not be nil }

  it "should start a drb service" do
    DRb.fetch_server(subject.uri).should_not be nil
  end
end
