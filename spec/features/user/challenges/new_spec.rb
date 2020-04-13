require 'rails_helper'

describe 'User ' do
  before(:each) do
    @bob = User.create(name: "Bob", email: "bob@sample.com", google_token: "12345", role: 0)
    @chocolate = @bob.ingredients.create(name: "Chocolate")
    @squid = @bob.ingredients.create(name: "Squid")
    @blueberries = @bob.ingredients.create(name: "Blueberries")
    @cinnamon = @bob.ingredients.create(name: "Cinnamon")
    @eggs = @bob.ingredients.create(name: "Eggs")
    @toast = @bob.ingredients.create(name: "Toast")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@bob)
  end

  it 'can create a new game' do
    visit "/users/#{@bob.id}/dashboard"

    click_on 'Start New Game'

    expect(current_path).to eq("/users/#{@bob.id}/challenges/new")

    fill_in 'time_limit', with: '20'
    fill_in 'basket_size', with: '3'
    fill_in 'meal_type', with: 'dinner'
    click_on "Start New Game"

    game = Challenge.last

    expect(game.game_status).to eq("before")
  end

  # probably won't need this with drop down boxes in the new form
  it "can't create a new game with an empty field" do
    visit "/users/#{@bob.id}/dashboard"

    click_on 'Start New Game'

    expect(current_path).to eq("/users/#{@bob.id}/challenges/new")

    fill_in 'time_limit', with: ''
    fill_in 'basket_size', with: '3'
    fill_in 'meal_type', with: 'dinner'
    click_on "Start New Game"

    expect(current_path).to eq("/users/#{@bob.id}/challenges/new")
    expect(page).to have_content("Time limit can't be blank")
  end
end