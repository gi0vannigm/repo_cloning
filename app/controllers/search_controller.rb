class SearchController < ApplicationController
  def index
  end

  def results
    @query = params[:query]
  end
end
