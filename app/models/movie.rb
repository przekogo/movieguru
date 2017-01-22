# == Schema Information
#
# Table name: movies
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  released_at :datetime
#  avatar      :string
#  genre_id    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Movie < ActiveRecord::Base
  belongs_to :genre

  def self.all_with_genre_details
    find_by_sql(self.movies_with_genre_details_query())
  end
  def self.find_with_genre_details(id)
    find_by_sql(self.movies_with_genre_details_query(id)).first || (raise ActiveRecord::RecordNotFound)
  end

  private

  def self.movies_with_genre_details_query(id=0)
    appendix = id == 0 ? '' : ' where mov.id = ' + id.to_s
    "select mov.id as id, mov.title as title, mov.genre_id as genre_id, g.name as genre_name, (select count(distinct id) from movies submov where submov.genre_id = mov.genre_id) as movies_in_genre from movies mov left join genres g on mov.genre_id = g.id" + appendix
  end
end
