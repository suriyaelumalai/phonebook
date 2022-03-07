require "rails_helper"

RSpec.describe 'Users controller', type: :request do
  let(:user1) do
    {
    	name: "Peter parker",
    	age: 27,
    	email: "peter@test.com",
    	phone: "+9212334"
    }
  end

  before(:all) do
    User.create({
    	name: "Dany Targ",
    	age: 25,
    	email: "dany@test.com",
    	phone: "+9212334"
    })
    User.create({
    	name: "Jon Snow",
    	age: 25,
    	email: "jon@test.com",
    	phone: "+912334"
    })
  end

  it "Indexes all user" do
    get "/users"
    expect(response).to have_http_status(:success)
    expect(json_body.length).to eql(User.count)
  end

  it "Creates a new user" do
    old_count = User.count
    post "/users", params: user1, as: :json
    expect_status(:created)
    expect(User.count).to eql(old_count + 1)
  end

  it "Gets a user with id" do
    first_user = User.first
    get "/users/#{first_user.id}"
    expect(response).to have_http_status(:success)
    expect(json_body[:name]).to eq(first_user.name)
    expect(json_body[:email]).to eq(first_user.email)
    expect(json_body[:age]).to eq(first_user.age)
  end

  it "Updates an user" do
    user = User.last
    user.email = "updatedvalue@test.com"
    put "/users/#{user.id}", params: user, as: :json
    expect(response).to have_http_status(:success)
    user = User.find(user.id)
    expect(user.email).to eql("updatedvalue@test.com")
  end
end
