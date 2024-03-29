class WordsController < ApplicationController
  before_action :set_word, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :current, :show]

  # GET /words or /words.json
  def index
    @words = Word.all
    @word = Word.new
  end

  def current
    @word = Word.current
    render :show
  end

  # GET /words/1 or /words/1.json
  def show
  end

  # GET /words/new
  def new
    @word = Word.new
  end

  # GET /words/1/edit
  def edit
  end

  # POST /words or /words.json
  def create
    @word = Word.new(word_params)

    respond_to do |format|
      if @word.save
        format.html { redirect_to word_url(@word), notice: "Word was successfully created." }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /words/1 or /words/1.json
  def update
    respond_to do |format|
      if @word.update(word_params)
        format.html { redirect_to word_url(@word), notice: "Word was successfully updated." }
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /words/1 or /words/1.json
  def destroy
    @word.destroy
    respond_to do |format|
      format.html { redirect_to words_url, notice: "Word was successfully destroyed." }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@word) }
      # format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_word
      @word = Word.friendly.find(params[:id].downcase)
    end

    # Only allow a list of trusted parameters through.
    def word_params
      params.require(:word).permit(:prefix, :word, :definition, :phonetic, :syllables, :slug, :also_matches, :audio)
    end
end
