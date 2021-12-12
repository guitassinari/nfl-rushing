require 'rails_helper'

RSpec.shared_examples 'paginatable' do |route, model_klass|
  describe "pagination" do
    let!(:player_rushings) { create_list(:player_rushing, 100) }

    it "returns pagination metadata" do
      get route, params: {format: :json}

        expect(response).to have_http_status(:ok)
        expect(pagination_data["current_page"]).to eq(1)
        expect(pagination_data["total_pages"]).to eq(5)
        expect(pagination_data["total_hits"]).to eq(100)
    end

    context "when receives no page parameter" do
      it "returns the first page" do
        get route, params: {format: :json}

        expect(response).to have_http_status(:ok)
        expect(response_rushings).to eq(model_klass.limit(20).to_json)
      end
    end

    context "when receives a valid page parameter" do
      let(:page) { 3 }
      it "offsets the records accordingly" do
        get "#{route}?page=#{page}", params: {format: :json}

        expect(response).to have_http_status(:ok)
        expect(response_rushings).to eq(model_klass.offset(20*(page-1)).limit(20).to_json)
      end
    end

    context "when receives an invalid page parameter" do
      let(:page) { "!abc" }
      it "returns the first page" do
        get "#{route}?page=#{page}", params: {format: :json}

        expect(response).to have_http_status(:ok)
        expect(response_rushings).to eq(model_klass.limit(20).to_json)
      end
    end
  end
end