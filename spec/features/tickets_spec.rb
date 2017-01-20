require "rails_helper"

RSpec.feature "Tickets", :type => :feature do

  before(:all) do
    create_list(:ticket, 5)
  end

  scenario "user visits the homepage" do
    visit tickets_path
    expect(page).to have_text("Tickets")
  end

  scenario 'user creates a new ticket' do
    visit new_ticket_path
    expect(page).to have_field("Severity")
    expect(page).to have_button("Create Ticket")
  end

  scenario 'user edits a ticket' do
    visit edit_ticket_path(Ticket.last)
    expect(page).to have_field("Status")
    expect(page).to have_button("Update Ticket")
  end
end
