class Api::V1::BooksController < ApplicationController
  respond_to :json

  def show
    @book = Book.find_by id: (params[:id])
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
