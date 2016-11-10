require "rails_helper"

RSpec.feature "visitor visits homepage" do
  scenario "and sees all existing photos" do
    visit root_path
    expect(page).to have_css("img", count: 285)
  end
end
