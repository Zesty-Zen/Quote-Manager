class QuotesController < ApplicationController
  before_action :set_quote, only: [:show, :edit, :update, :destroy]

  def index
    @q = current_user.quotes.ordered.ransack(params[:q])
    # @quotes = @q.result

    @pagy, @quotes = pagy(@q.result, items: 10)


    # @quotes = current_user.quotes.ordered
  end
  
  def show
    @line_item_dates = @quote.line_item_dates.ordered
  end

  def new
    @quote = Quote.new
  end

  def create
      @quote = Quote.new(quote_params)
      @quote.user_id = current_user.id
    if @quote.save
      current_user.send_quote_created_notification(@quote)

      respond_to do |format|
        format.html { redirect_to quotes_path, notice: "Quote was successfully created." }
        format.turbo_stream { flash.now[:notice] = "Quote was successfully created." }

      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @quote.update(quote_params)
      respond_to do |format|
        format.html { redirect_to quotes_path, notice: "Quote was successfully updated." }
        format.turbo_stream { flash.now[:notice] = "Quote was successfully updated." }
      end

    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @quote.destroy
  
    respond_to do |format|
      format.html { redirect_to quotes_path, notice: "Quote was successfully destroyed." }
      format.turbo_stream { flash.now[:notice] = "Quote was successfully destroyed." }

    end
  end

private

  def set_quote
    @quote = Quote.find(params[:id])
  end

  def quote_params
    params.require(:quote).permit(:name)
  end

end
