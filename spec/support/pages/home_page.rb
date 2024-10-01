class HomePage
  include Capybara::DSL
  include RSpec::Matchers

  def visit_page
    visit('/')
  end

  def select_language(language:)
    find('button[data-se-id="site-edition-btn-link"]').click
    language_combobox = find_combobox('Select language')
    expect(language_combobox).to have_content 'English'
    language_combobox.click_and_select_option(language)
    click_button 'Confirm'
    expect(page).to have_no_selector('#acEditionSelectorDialogBody')
  end

  def search_flight(origin:, destination:, departure_date:, return_date:)
    find('#flightsOriginLocationbkmgLocationContainer').click
    fill_in 'From', with: origin

    find('#flightsOriginDestinationbkmgLocationContainer').click
    fill_in 'To', with: destination

    fill_in 'Departure date', with: departure_date.strftime('%d/%m')
    return_date_field = have_field('Return date')
    fill_in 'Return date', with: return_date.strftime('%d/%m')
    find_field('Return date').send_keys(:tab)

    find("button[type=\"submit\"]").click
  end

  def flight_search_results
    find('.flight-block-list')
  end

  def open_sign_in_form
    click_button "Sign in"
  end

  def click_footer_link(label:)
    scroll_to find('.footer')
    find('a', text: label).click
  end
end