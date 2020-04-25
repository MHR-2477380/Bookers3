class BooksController < ApplicationController

	def index
		@book = Book.new
		@books = Book.all
		@user = current_user
	end

	def show
		@newbook = Book.new
		@book = Book.find(params[:id])
		@user = current_user
		@post_comment = PostComment.new
	end

	def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id

		if @book.save
			flash[:notice] = 'Book was successfully created.'
			redirect_to book_path(@book)
		else
			@books = Book.all.order(id: "asc")
			@user = User.find(current_user.id)

			render :index
		end

	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
			flash[:notice] = 'You have updated book successfully.'
			redirect_to book_path(@book)
		else
			@books = Book.all.order(id: "asc")
			@user = current_user
			render :edit
		end
	end

	def destroy
		book = Book.find(params[:id])
		book.destroy
		redirect_to books_path
	end

	private

	def book_params
		params.require(:book).permit(:title, :body, :image)
	end

end
