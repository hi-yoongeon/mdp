require 'spec_helper'

describe PostsController do
  render_views

  describe "GET 'show_post'" do
    it "should be successful" do
      get 'show_post'
      response.should be_success
    end
  end
end
