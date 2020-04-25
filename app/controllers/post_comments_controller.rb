class PostCommentsController < ApplicationController

def create

	@book = Book.find(params[:book_id])
	@post_comment = PostComment.new(post_comment_params)
	@post_comment.user_id = current_user.id
	@post_comment.book_id = @book.id

	if  @post_comment.save
		@post_comment_new = PostComment.new
	else
		flash[:notice] = 'コメントを入力して下さい。'
	end
end

def destroy

	@book = Book.find(params[:book_id])
	@post_comment = @book.post_comments.find(params[:id])
	@post_comment.destroy

end

private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end