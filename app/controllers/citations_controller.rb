class CitationsController < ApplicationController

  def index
    
    unless params[:word].nil?
      @word = Word.friendly.find(params[:word])
      @citations = Citation.for_word(@word.id)
    else
      @citations = Citation.all
    end
    
    respond_to do |format|
      format.json { render json: @citations.as_json(methods: [:source, :target, :value], except: [:id, :source_id, :destination_id, :created_at, :updated_at]), root: false }
    end
  end

  private

  def citation_params
    params.required(:user).permit(:source_id, :destination_id)
  end
end