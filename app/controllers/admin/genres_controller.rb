class Admin::GenresController < ApplicationController
	def index
		@genres = Genre.all
		@genre = Genre.new
	end
	def create
		@genre = Genre.new(genre_params)
#		if 
		@genre.save
#			flash[:success] = ''
		redirect_to admin_genres_path
#		else
#		end
	end
	def edit
		@genre = Genre.find(params[:id])
	end
	def update
		@genre = Genre.find(params[:id])
#		if 
		@genre.update(genre_params)
#			flash[:notice] = ''
      	redirect_to admin_genres_path
#       else
#       end
	end
	private
	def genre_params
		params.require(:genre).permit(:name, :is_valid)
	end
end