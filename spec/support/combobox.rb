class Combobox < SimpleDelegator
  def initialize(node, label:)
    super(node)
    @label = label
  end

  def click_and_select_option(option)
    click
    select_option(option)
  end

  def select_option(option)
    options = find(:xpath, "//body").find("ul[role=\"listbox\"]")
    options.find("li[role=\"option\"]", text: option).click
  end

  def fill_in(value)
    super(@label, with: value)
  end
end

def find_combobox(label)
  combobox_container = find("[role=\"combobox\"]", text: label)
  Combobox.new(combobox_container, label:)
end