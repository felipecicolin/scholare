RSpec.describe "Home" do
  it do
    visit root_path

    expect(page).to have_link("Scholare", href: root_path)
    expect(page).to have_link("Comece a usar agora", href: root_path)
    expect(page).to have_link("Saiba mais", href: root_path)
  end
end
