module Literature
  class Reference < ActiveRecord::Base
    has_and_belongs_to_many :reactions
    #TODO virtual attribute for bibtex data
    attr_accessor :bibtex
  end
end
