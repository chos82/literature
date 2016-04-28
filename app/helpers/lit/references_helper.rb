module Lit
  module ReferencesHelper

    def display_authors authors
      res = ''
      return res if authors.empty?
      if authors.length < 3
        i = 0
        authors.each{|a|
          res += a['firstName'] + ' ' + a['lastName']
          res += ' and ' if i < 1 && authors.length > 1
          i += 1
        }
        res += '.'
      else
        res += a['firstName'] + ' ' + a['lastName'] + " et al."
      end
      res
    end

  end
end
