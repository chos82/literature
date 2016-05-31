require_dependency "lit/application_controller"
require 'oauth'

module Lit
  class ReferencesController < ApplicationController
    before_action :set_reference, only: [:show, :edit, :update, :destroy]

    # GET /references
    def reflist
      @reference = Reference.new
      @reaction = Reaction.find(params[:id])
      connect2zotero
      get_reaction_references
    end

    # POST /references
    def create
      @reaction = Reaction.find(params[:id])
      @reference = Reference.new
      begin
        @reference.bibtex = BibTeX.parse(params[:reference][:bibtex])[0]
      rescue BibTeX::ParseError => e
        flash[:notice] = e.message
        redirect_to :action => 'reflist'
        return
      end
      connect2zotero
      @zotero = @reference.bibtex2zotero
      get_reaction_references
      for i in 0...@items.length do
        if @items[i]['data']['title'] == @reference.bibtex.title
          #session[:duplicate] = @items[i]
          flash[:notice] = "The reference you posted already exists."
          redirect_to :action => 'reflist' #'duplicate'
          return
        end
      end
      @res = @access_token.post("https://api.zotero.org/users/"+
        ENV['ZOTERO_ID'] + '/items/?key=dK9x7PnEXSR3LzbZiW9IdvT0', @zotero)
      @res_hash = JSON.parse @res.body
      @reference.reactions << @reaction
      @reference.zotero_itemKey = @res_hash['success']['0'].to_s
    # TODO make it transactional!
      @reference.save
      if !@res_hash['success'].empty?
        flash[:notice] = "The item was successfully created on Zotero and saved as reference."
        redirect_to :action => 'reflist'
      else
        flash[:notice] = "Reference could not be saved. Zotero server message: " + @res_hash['failed']['0']['message']
        redirect_to :action => 'reflist'
      end
    end


    private

      # Only allow a trusted parameter "white list" through.
      def reference_params
        params.require(:reference).permit(:bibtex)
      end

      def connect2zotero
        @consumer = OAuth::Consumer.new(ENV['ZOTERO_KEY'], ENV['ZOTERO_SECRET'],
              :site               => "https://api.www.zotero.org")
        @access_token = OAuth::AccessToken.new(@consumer, ENV['ZOTERO_TOKEN'],
          ENV['ZOTERO_SECRET'])
      end

      def get_reaction_references
        key_list = ''
        i = 0
        references = @reaction.references
        references.each{|r|
          key_list += r.zotero_itemKey
          i += 1
          key_list += ',' if i < references.length
        }
        if !references.empty?
          res = @access_token.get("https://api.zotero.org/users/"+
            ENV["ZOTERO_ID"]+"/items/?itemKey="+key_list+"&key=dK9x7PnEXSR3LzbZiW9IdvT0")
          @items = JSON.parse res.body
        else
          @items = []
        end
      end

  end
end
