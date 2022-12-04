RSpec.describe Api::TestGradesController do
  let(:test) { create(:school_test) }
  let(:student) { create(:student) }
  let(:test_grade_params) { { grade: 10, test_id: test.id, student_id: student.id } }

  context "with valid params" do
    before { post api_test_grades_path, params: { test_grade: test_grade_params } }

    it { expect(response).to have_http_status(:created) }
    it { expect(response.body).to eq(TestGrade.first.to_json) }
    it { expect(TestGrade.count).to eq(1) }
  end

  it "renders unprocessable entity" do
    test_grade_params[:grade] = nil

    post api_test_grades_path, params: { test_grade: test_grade_params }

    expect(response).to have_http_status(:unprocessable_entity)
  end
end
