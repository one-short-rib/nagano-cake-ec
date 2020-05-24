class Admin::GenresController < ApplicationController
	before_action :authenticate_admin!

	def index
		@genres = Genre.all
		@genre = Genre.new
	end
	def create
		@genre = Genre.new(genre_params)
		if @genre.save
			flash[:success] = 'Genre was successfully create'
			redirect_to admin_genres_path
		else
			@genres = Genre.all
			flash[:danger] = 'errors prohibited this genre from being saved'
			render :index
		end
	end
	def edit
		@genre = Genre.find(params[:id])
	end
	def update
		@genre = Genre.find(params[:id])
		if @genre.update(genre_params)
			flash[:notice] = 'You have updated Genre successfully.'
    	redirect_to admin_genres_path
    else
    	flash[:danger] = 'errors prohibited this genre from being updated'
     	render :edit
    end
	end

	private
	def genre_params
		params.require(:genre).permit(:name, :is_valid)
	end
end