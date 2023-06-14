RSpec.describe Api::TestGradesController do
  let(:test) { create(:school_test) }
  let(:student) { create(:student) }

  context "with valid params" do
    before { post api_test_grades_path, params: { grade: 10, test_id: test.id, student_id: student.id } }

    it { expect(response).to have_http_status(:created) }
    it { expect(response.body).to eq({ test_grade: 10.0 }.to_json) }
    it { expect(TestGrade.count).to eq(1) }
  end

  it "renders unprocessable entity" do
    post api_test_grades_path, params: { test_id: test.id, student_id: student.id }

    expect(response).to have_http_status(:unprocessable_entity)
    expect(response.body).to eq({ errors: ["Nota não pode ficar em branco"] }.to_json)
  end
end
