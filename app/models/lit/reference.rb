module Lit
  class Reference < ActiveRecord::Base
    #TODO write rake task that sets HABTM for reaction

    require 'bibtex'
    has_and_belongs_to_many :reactions, :class_name => "Reaction", :join_table => 'reactions_references'
    attr_accessor :bibtex

    def bibtex2zotero
      type  = bibtex.to_hash[:bibtex_type]
      case type
        when :article
          @zotero = zotero_journal_article
        when :book
          @zotero = zotero_book
        when :inbook
          @zotero = zotero_book_section
        else
          @zotero = zotero_document
      end
      @zotero
    end

    def bibtex_authors_to_array
      res = []
      bibtex.author.each{|a|
        res << {'creatorType' => 'author',
          'firstName' => a.first,
          'lastName' => a.last
        }
      }
      res
    end

    def format_bibtex_date
      res = ""
      if bibtex.month
        res+= bibtex.month.to_s + " - "
      end
      res += bibtex.year
    end

    def zotero_journal_article
        zotero_item = [{
          :itemType => "journalArticle",
          :title => bibtex[:title],
          :creators => bibtex_authors_to_array,
          :abstractNote => bibtex[:note],
          :publicationTitle => bibtex[:journal],
          :volume => bibtex[:volume],
          :issue => bibtex[:number],
          :pages => bibtex[:pages],
          :date => format_bibtex_date,
          :series => "",
          :seriesTitle => "",
          :seriesText => "",
          :journalAbbreviation => "",
          :language => "",
          :DOI => bibtex[:doi],
          :ISSN => bibtex[:issn],
          :shortTitle => "",
          :url => bibtex[:url],
          :accessDate => "",
          :archive => "",
          :archiveLocation => "",
          :libraryCatalog => "",
          :callNumber => "",
          :rights => "",
          :extra => "",
          :tags => [],
          :collections => [],
          :relations => {}
        }]
        zotero_item.to_json
    end

    def zotero_book
      zotero_item = [{
        :itemType => "book",
        :title => bibtex[:title],
        :creators => bibtex_authors_to_array,
        :abstractNote => bibtex[:note],
        :series => bibtex[:series],
        :seriesNumber => bibtex[:number],
        :volume =>  bibtex[:volume],
        :numberOfVolumes => "",
        :edition => bibtex[:edition],
        :place => "",
        :publisher => bibtex[:publisher],
        :date => format_bibtex_date,
        :numPages => "",
        :language => "",
        :ISBN => bibtex[:isbn],
        :shortTitle => "",
        :url => bibtex[:url],
        :accessDate => "",
        :archive => "",
        :archiveLocation => "",
        :libraryCatalog => "",
        :callNumber => "",
        :rights => "",
        :extra => "",
        :tags => [],
        :collections => [],
        :relations => {}
      }]
      zotero_item.to_json
    end

    def zotero_book_section
      zotero_item = [{
        :itemType => "bookSection",
        :title => bibtex[:title],
        :creators => bibtex_authors_to_array,
        :abstractNote => bibtex[:note],
        :bookTitle => bibtex[:booktitle],
        :series => bibtex[:series],
        :seriesNumber => bibtex[:number],
        :volume => bibtex[:volume],
        :numberOfVolumes => "",
        :edition => bibtex[:edition],
        :place => "",
        :publisher => bibtex[:publisher],
        :date => format_bibtex_date,
        :pages => bibtex[:pages],
        :language => "",
        :ISBN => bibtex[:isbn],
        :shortTitle => "",
        :url => bibtex[:url],
        :accessDate => "",
        :archive => "",
        :archiveLocation => "",
        :libraryCatalog => "",
        :callNumber => "",
        :rights => "",
        :extra => "",
        :tags => [],
        :collections => [],
        :relations => {}
      }]
      zotero_item.to_json
    end

    def zotero_document
      zotero_item = [{
        :itemType => "document",
        :title => bibtex[:title],
        :creators => bibtex_authors_to_array,
        :abstractNote => bibtex[:note],
        :publisher => bibtex[:publisher],
        :date => format_bibtex_date,
        :language => "",
        :shortTitle => "",
        :url => bibtex[:url],
        :accessDate => "",
        :archive => "",
        :archiveLocation => "",
        :libraryCatalog => "",
        :callNumber => "",
        :rights => "",
        :extra => "",
        :tags => [],
        :collections => [],
        :relations => {}
      }]
    end

  end
end
