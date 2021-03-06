require 'spec_helper'

describe Vero::Api::Workers::Users::TrackAPI do
  subject { Vero::Api::Workers::Users::TrackAPI.new('https://api.getvero.com', {}) }
  it "should inherit from Vero::Api::Workers::BaseCaller" do
    subject.should be_a(Vero::Api::Workers::BaseAPI)
  end

  it "should map to current version of Vero API" do
    subject.send(:url).should == "https://api.getvero.com/api/v2/users/track.json"
  end

  subject { Vero::Api::Workers::Users::TrackAPI.new('https://api.getvero.com', {:auth_token => 'abcd', :identity => {:email => 'test@test.com'}, :email => 'test@test.com'}) }
  describe :validate! do
    it "should raise an error if email and id are are blank String" do
      options = {:auth_token => 'abcd', :identity => {:email => 'test@test.com'}, :id => nil, :email => nil}
      subject.options = options
      expect { subject.send(:validate!) }.to raise_error

      options = {:auth_token => 'abcd', :identity => {:email => 'test@test.com'}, :id => nil, :email => 'test@test.com'}
      subject.options = options
      expect { subject.send(:validate!) }.to_not raise_error

      options = {:auth_token => 'abcd', :identity => {:email => 'test@test.com'}, :id => "", :email => nil}
      subject.options = options
      expect { subject.send(:validate!) }.to raise_error

      options = {:auth_token => 'abcd', :identity => {:email => 'test@test.com'}, :id => "user123", :email => nil}
      subject.options = options
      expect { subject.send(:validate!) }.to_not raise_error
    end

    it "should raise an error if data is not either nil or a Hash" do
      options = {:auth_token => 'abcd', :identity => {:email => 'test@test.com'}, :email => 'test@test.com', :data => []}
      subject.options = options
      expect { subject.send(:validate!) }.to raise_error

      options = {:auth_token => 'abcd', :identity => {:email => 'test@test.com'}, :email => 'test@test.com', :data => nil}
      subject.options = options
      expect { subject.send(:validate!) }.to_not raise_error

      options = {:auth_token => 'abcd', :identity => {:email => 'test@test.com'}, :email => 'test@test.com', :data => {}}
      subject.options = options
      expect { subject.send(:validate!) }.to_not raise_error
    end

    it "should not raise an error when the keys are Strings" do
      options = {"auth_token" => 'abcd', "identity" => {"email" => 'test@test.com'}, "email" => 'test@test.com', "data" => {}}
      subject.options = options
      expect { subject.send(:validate!) }.to_not raise_error
    end
  end

  describe :request do
    it "should send a request to the Vero API" do
      RestClient.should_receive(:post).with("https://api.getvero.com/api/v2/users/track.json", {:auth_token => 'abcd', :identity => {:email => 'test@test.com'}, :email => 'test@test.com'}.to_json, {:content_type => :json, :accept => :json})
      RestClient.stub(:post).and_return(200)
      subject.send(:request)
    end
  end

  describe "integration test" do
    it "should not raise any errors" do
      RestClient.stub(:post).and_return(200)
      expect { subject.perform }.to_not raise_error
    end
  end
end