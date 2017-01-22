class MoviedbApiHandler
  # queries moviedb api for details about a movie
  def self.get_movie_details(title, details)
    Rails.logger.info('querying moviedb api for info about ' + title)
    response = RestClient.get(self.construct_query(title))
    returnValue = {code: response.code}
    if response.code == 200
      returnValue[:data] = self.construct_data(JSON.parse(response.body), details)
    end
    Rails.logger.info('response: ' + returnValue.to_s)
    returnValue
  end

  private

  # creates a moviedb api query url
  def self.construct_query(query)
    ENV['themoviedb_v3_movie_search'] + ENV['themoviedb_v3_api_key'] + '&query=' + query
  end

  # fetch keys from response data and return a front-end usable, formatted hash
  def self.construct_data(data, keys)
    returnValue = {}
    keys.each do |key|
      returnValue[key.to_sym] = data['results'].first.try(:[], key).try(:to_s) || 'not found'
    end
    returnValue
  end
end
