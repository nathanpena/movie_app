class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    @back_link = request.referer
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.ratings
    @selected_ratings = (@all_ratings)
    if params[:sort].present?
      by_sort_type = params[:sort]
      sort_movies(by_sort_type)
    elsif params[:ratings].present?
      selected_filters = params[:ratings].keys
      @movies = Movie.filter_ratings(selected_filters)
      @selected_ratings = params[:ratings]
    else
      @movies = Movie.all
      @sort_type = ''
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  def sort_movies(sort_type)
    @movies = Movie.order(sort_type)
    instance_variable_set("@#{sort_type}", "hilite")
  end
end
