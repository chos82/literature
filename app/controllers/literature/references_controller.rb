require_dependency "literature/application_controller"
require 'oauth'

module Literature
  class ReferencesController < ApplicationController
    before_action :set_reference, only: [:show, :edit, :update, :destroy]

    # GET /references
    def index
      @consumer = OAuth::Consumer.new(ENV['ZOTERO_KEY'], ENV['ZOTERO_SECRET'],
            :site               => "https://api.www.zotero.org")
      @access_token = OAuth::AccessToken.new(@consumer, ENV['ZOTERO_TOKEN'],
        ENV['ZOTERO_SECRET'])
      @res = @access_token.get("https://api.zotero.org/users/"+
        ENV["ZOTERO_ID"]+"/items?key=dK9x7PnEXSR3LzbZiW9IdvT0")
    end

    # GET /references/1
    def show
    end

    # GET /references/new
    def new
      @reference = Reference.new
    end

    # GET /references/1/edit
    def edit
    end

    def write_zotero

    end

    # POST /references
    def create
      #@reaction = Reaction.find(params[:id])
      @reference = Reference.new
      @reference.bibtex = BibTeX.parse(params[:reference][:bibtex])[0]
      @consumer = OAuth::Consumer.new(ENV['ZOTERO_KEY'], ENV['ZOTERO_SECRET'],
            :site => "https://api.www.zotero.org")
      @access_token = OAuth::AccessToken.new(@consumer, ENV['ZOTERO_TOKEN'],
        ENV['ZOTERO_SECRET'])
      @zotero = @reference.bibtex2zotero
      @res = @access_token.post("https://api.zotero.org/users/"+
        ENV['ZOTERO_ID'] + '/items/?key=dK9x7PnEXSR3LzbZiW9IdvT0', @zotero)
      @res_hash = JSON.parse @res.body
      if @res_hash['success']
        flash[:notice] = "The item was successfully created on Zotero and saved as reference."
        redirect_to :action => 'index'
      else
        flash[:notice] = "Reference could not be saved."
        render :new
      end
    end

    # PATCH/PUT /references/1
    def update
      if @reference.update(reference_params)
        redirect_to @reference, notice: 'Reference was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /references/1
    def destroy
      @reference.destroy
      redirect_to references_url, notice: 'Reference was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_reference
        @reference = Reference.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def reference_params
        params.require(:reference).permit(:title, :author)
      end

      def setup_request_token
        @consumer = OAuth::Consumer.new(ENV['ZOTERO_KEY'], ENV['ZOTERO_SECRET'],
              :site               => "https://www.zotero.org",
              :request_token_path => '/oauth/request',
              #:authorize_path     => '/oauth/authorize',
              :access_token_path  => '/oauth/access')
        @request_token = @consumer.get_request_token
      end

  end
end
