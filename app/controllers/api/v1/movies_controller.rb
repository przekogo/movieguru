class API::V1::MoviesController < ApplicationController

  expose(:movies) { Movie.select(:id, :title).all }
  expose(:movie) { Movie.select(:id, :title).find(params[:id]) }

  def index
    render json: movies
  end

  def show
    render json: movie
    rescue ActiveRecord::RecordNotFound
      render json: {error: "record not found"}.to_json, :status => 404
  end
end