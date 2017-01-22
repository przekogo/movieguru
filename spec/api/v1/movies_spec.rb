require 'rails_helper'

describe "Movies API v1", type: :request do
  
  let!(:genres) { create_list(:genre, 5, :with_movies) }
  
  it 'gets a list of movies' do
    api_path 'v1/movies'

    json = JSON.parse(response.body)

    # test for the 200 status-code
    expect(response).to be_success

    # check to make sure the right amount of movies are returned
    expect(json.count).to eq(25)
    expect(json.first.keys).to eq(%w[id title])
  end

  it 'gets movie info' do
    api_path 'v1/movies/' + Movie.first.id.to_s

    json = JSON.parse(response.body)

    # test for the 200 status-code
    expect(response).to be_success

    expect(json.count).to eq(2)
  end

  it 'handles request for non-existent movie' do
    api_path 'v1/movies/0'

    # test for the 404 status-code
    expect(response.status).to eq(404)
  end
end