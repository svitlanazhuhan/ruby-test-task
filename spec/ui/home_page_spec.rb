RSpec.describe 'Air Canada Homepage', type: :feature do
  before(:each) do
    @home_page = HomePage.new 
    @home_page.visit_page
    # Block alert pop-ups
    page.execute_script('window.alert = function() {};')
    page.execute_script('window.confirm = function() { return true; };')
  end

  it 'can switch language to French' do
    expect(page).to have_content 'Where can we take you?'
    @home_page.select_language(language: 'Français')
    expect(page).to have_content 'Où pouvons-nous vous emmener?'
  end

  it 'can open sign in form' do
    @home_page.open_sign_in_form
    expect(page).to have_selector '#ac-sso-login-form', wait: 20
    expect(page).to have_field 'Aeroplan number or email'
    expect(page).to have_field 'Password'
  end

  it 'searches for flight' do
    departure_date = Date.today + 7
    return_date = Date.today + 8
    @home_page.search_flight(
      origin: 'Toronto-Pearson Int.',
      destination: 'Vancouver Int.',
      departure_date:, 
      return_date:
    )
    expect(page).to have_content 'Searching for your flights'
    expect(page).to have_no_content 'Searching for your flights', wait: 20
    expect(@home_page.flight_search_results).to be_visible
  end

  it 'opens Help and contact page' do
    contact_window = window_opened_by { @home_page.click_footer_link(label: 'Help And Contact') }

    within_window contact_window do
      expect(page).to have_content 'Have a question?'
    end
  end
end