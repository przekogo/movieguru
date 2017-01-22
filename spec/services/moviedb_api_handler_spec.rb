require 'rails_helper'

describe 'moviedb api handler', type: :service do
  it 'connects to api' do
    expect(MoviedbApiHandler.get_movie_details('Inception', [])[:code]).to eq(200)
  end

  it 'gets info about proper movie' do
    expect(MoviedbApiHandler.get_movie_details('Inception', ['original_title'])[:data][:original_title]).to eq('Inception')
  end

  it 'handles not found movies' do
    expect(MoviedbApiHandler.get_movie_details('there is no movie with this name', ['original_title'])[:data][:original_title]).to eq('not found')
  end
end
