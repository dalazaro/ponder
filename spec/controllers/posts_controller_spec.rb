require 'spec_helper'
require 'rspec-rails'

describe "PostsController" do
  describe "GET #index" do
    it "renders the :index view"
    get :index
    response.should render_template :index
  end
  
  describe "GET #show" do
    it "assigns the requested contact to @contact"
    it "renders the :show template"
    get :show
    response.should render_template :show
  end
  
  describe "GET #new" do
    it "assigns a new Contact to @contact"
    it "renders the :new template"
  end
  
  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new contact in the database"
      it "redirects to the home page"
    end
    
    context "with invalid attributes" do
      it "does not save the new contact in the database"
      it "re-renders the :new template"
    end
  end
end
