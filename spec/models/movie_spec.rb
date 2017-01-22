require 'rails_helper'

describe Movie do
  let!(:genres) { create_list(:genre, 5, :with_movies) }

  it 'finds all movies with genre details' do
    expect(Movie.all_with_genre_details.count).to eq(25)
    expect(eval(Movie.all_with_genre_details.first.to_json).keys).to eq([:id, :title, :genre_id, :genre_name, :movies_in_genre])
  end

  it 'finds specific movie with genre details' do
    expect(eval(Movie.find_with_genre_details(Movie.first.id).to_json).keys).to eq([:id, :title, :genre_id, :genre_name, :movies_in_genre])
  end
end
