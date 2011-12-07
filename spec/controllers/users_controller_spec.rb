require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'show'" do
    
    before(:each) do
      @user = Factory(:user)
    end
    
    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end

    it "should find the right user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end

    it "should have the right title" do
      get :show, :id => @user
      response.body.should have_selector("title", :content => @user.name)
    end

    it "should include the user's name" do
      get :show, :id => @user
      response.body.should have_selector("h1", :content => @user.name)
    end

    it "should have a profile image" do
      get :show, :id => @user
      response.body.should have_selector("h1>img", :class => "gravatar")
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end

    it "should have the right title" do
      get 'new'
      response.body.should have_selector("title", :text => "Sign up")
    end

    it "should have input fields" do
      get 'new'
      response.body.should have_selector("input[name='user[name]'][type='text']")
      response.body.should have_selector("input[name='user[email]'][type='text']")
      response.body.should have_selector("input[name='user[password]'][type='password']")
      response.body.should have_selector("input[name='user[password_confirmation]'][type='password']")
    end
  end

  describe "POST 'create'" do
    describe "failure" do
      before(:each) do
        @attr = { :name => "", :email => "", :password => "", 
                  :password_confirmation => "" }
      end

      it "should create a user" do
        lambda do
          post :create, :user => @attr 
        end.should_not change(User, :count)
      end

      it "should have the right title" do
          post :create, :user => @attr
          response.body.should have_selector("title", :content => "Sign up")
      end
            
      it "should render the 'new' page" do
        post :create, :user => @attr
        response.body.should render_template('new')
      end

      it "should have a warning message" do
        post :create, :user => @attr
        response.body.should have_selector("p.error_notification", 
          :content => "Some errors were found, please take a look")
      end
    end

    describe "success" do
      before(:each) do
        @attr = { :name => "New User", :email => "user@example.com",
                  :password => "foobar", :password_confirmation => "foobar" }
      end

      it "should create a user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end
            
      it "should redirect to the user show page" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end

      it "should have a welcome message" do
        post :create, :user => @attr
        flash[:success].should =~ /welcome to the sample app/i
      end
    end
  end
end
