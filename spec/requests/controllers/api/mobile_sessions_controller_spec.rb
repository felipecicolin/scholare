RSpec.describe Api::MobileSessionsController do
  let(:user) { create(:user) }

  describe "post #create" do
    context "with valid credentials" do
      it do
        post api_mobile_login_path, params: { email: user.email, password: user.password }

        expect(response).to be_successful
        expect(response.body).to eq({ auth_token: user.reload.auth_token }.to_json)
      end
    end

    context "with invalid credentials" do
      it "returns an unauthorized response" do
        post api_mobile_login_path, params: { email: user.email, password: "wrong_password" }

        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to eq({ error: "Invalid email or password" }.to_json)
      end
    end

    context "without all required params" do
      it "returns a bad request response" do
        post api_mobile_login_path, params: { email: user.email }

        expect(response).to have_http_status(:bad_request)
        expect(response.body).to eq({ error: "E-mail and password are required" }.to_json)
      end
    end
  end

  describe "get #show" do
    context "with valid auth token" do
      it do
        get api_is_user_logged_in_path, params: { auth_token: user.auth_token }

        expect(response).to be_successful
        expect(response.body).to eq({ message: "User is logged in" }.to_json)
      end
    end

    context "with invalid auth token" do
      it "returns an unauthorized response" do
        get api_is_user_logged_in_path, params: { auth_token: "wrong_auth_token" }

        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to eq({ error: "Invalid auth token" }.to_json)
      end
    end

    context "without all required params" do
      it "returns a bad request response" do
        get api_is_user_logged_in_path

        expect(response).to have_http_status(:bad_request)
        expect(response.body).to eq({ error: "Token is required" }.to_json)
      end
    end
  end

  describe "delete #destroy" do
    context "with valid auth token" do
      it do
        delete api_mobile_logout_path, params: { auth_token: user.auth_token }

        expect(response).to be_successful
        expect(response.body).to eq({ message: "Logout successful" }.to_json)
      end
    end

    context "with invalid auth token" do
      it "returns an unauthorized response" do
        delete api_mobile_logout_path, params: { auth_token: "wrong_auth_token" }

        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to eq({ error: "Invalid auth token" }.to_json)
      end
    end

    context "without all required params" do
      it "returns a bad request response" do
        delete api_mobile_logout_path

        expect(response).to have_http_status(:bad_request)
        expect(response.body).to eq({ error: "Token is required" }.to_json)
      end
    end
  end
end
