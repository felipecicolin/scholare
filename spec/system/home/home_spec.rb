RSpec.describe "Home" do
  it do
    visit root_path

    expect(page).to have_content("Hello World")
  end
end
