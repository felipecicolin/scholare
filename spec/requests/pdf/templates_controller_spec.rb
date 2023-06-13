RSpec.describe Pdf::TemplatesController do
  before do
    test = create(:school_test, questions: create_list(:question, 1))

    sign_in test.user
    get pdf_templates_path(test_id: test.id)
  end

  it { expect(response).to have_http_status(:ok) }
  it { expect(response.content_type).to eq("application/pdf") }

  it "renders the PDF" do
    expect(response.body).to start_with("%PDF-1.3")
  end
end
