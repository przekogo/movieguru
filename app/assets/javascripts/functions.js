function getMoviedbData(title) {
  $.ajax({
    url: '/movies/get_moviedb_data',
    method: 'post',
    data: {'title' : title}
  })
}