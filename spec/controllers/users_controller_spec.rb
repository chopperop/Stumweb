require 'spec_helper'

describe UsersController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

  describe "GET 'likes'" do
    it "returns http success" do
      get 'likes'
      response.should be_success
    end
  end

  describe "GET 'dislikes'" do
    it "returns http success" do
      get 'dislikes'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      response.should be_success
    end
  end

  describe "GET 'new_message'" do
    it "returns http success" do
      get 'new_message'
      response.should be_success
    end
  end

  describe "GET 'destroy_message'" do
    it "returns http success" do
      get 'destroy_message'
      response.should be_success
    end
  end

  describe "GET 'messages'" do
    it "returns http success" do
      get 'messages'
      response.should be_success
    end
  end

  describe "GET 'inbox'" do
    it "returns http success" do
      get 'inbox'
      response.should be_success
    end
  end

  describe "GET 'outbox'" do
    it "returns http success" do
      get 'outbox'
      response.should be_success
    end
  end

  describe "GET 'show_message'" do
    it "returns http success" do
      get 'show_message'
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit'
      response.should be_success
    end
  end

  describe "GET 'update'" do
    it "returns http success" do
      get 'update'
      response.should be_success
    end
  end

  describe "GET 'destroy'" do
    it "returns http success" do
      get 'destroy'
      response.should be_success
    end
  end

end
