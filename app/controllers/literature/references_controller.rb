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

    # POST /references
    def create
      @reference = Reference.new(reference_params)

      if @reference.save
        redirect_to @reference, notice: 'Reference was successfully created.'
      else
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

      def setup_authentication
        access_token = @request_token.get_access_token(:oauth_verifier => ENV['ZOTERO_VERIFIER'])
        auth = {}
        auth["token"] = access_token.token
        auth["token_secret"] = access_token.secret
        File.open('auth.yaml', 'w') {|f| YAML.dump(auth, f)}
        access_token
      end

  end
end
