class BooksController < ApplicationController
  respond_to :json

  def show
    @book = Book.find(params[:id])
    if @book
      render json: @book
    else
      book = Book.new(book_params)
      if book.save
        render json: book, location: [:api, book]
      end
    end
  end

  private

  def book_params
    params.require(:book).permit(:email, :id)
  end


end