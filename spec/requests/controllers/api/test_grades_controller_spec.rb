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
    post api_test_grades_path, params: { grade: "abc", test_id: test.id, student_id: student.id }

    expect(response).to have_http_status(:unprocessable_entity)
    expect(response.body).to eq({ errors: ["Nota não é um número"] }.to_json)
  end

  context "with missing params" do
    it "renders bad request" do
      post api_test_grades_path, params: { test_id: test.id }

      expect(response).to have_http_status(:bad_request)
      expect(response.body).to eq(
        { errors: "Parâmteros faltando. Os parâmetros obrigatórios são: grade, test_id e student_id" }.to_json
      )
    end
  end
end
