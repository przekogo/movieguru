require 'rails_helper'

describe "Movies API v2", type: :request do
  
  let!(:genres) { create_list(:genre, 5, :with_movies) }
  
  it 'gets a list of movies with genre info' do
    api_path 'v2/movies'

    json = JSON.parse(response.body)

    # test for the 200 status-code
    expect(response).to be_success

    # check to make sure the right amount of movies are returned
    expect(json.count).to eq(25)
    expect(json.first.keys).to eq(%w[id title genre_id genre_name movies_in_genre])
  end

  it 'gets movie info with genre details' do
    api_path 'v2/movies/' + Movie.first.id.to_s

    json = JSON.parse(response.body)

    # test for the 200 status-code
    expect(response).to be_success

    expect(json.count).to eq(5)
  end

  it 'handles request for non-existent movie' do
    api_path 'v2/movies/0'

    # test for the 404 status-code
    expect(response.status).to eq(404)
  end
end