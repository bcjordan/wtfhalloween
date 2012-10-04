module ActiveRecord
  class Base
    def self.random
      if (c = count) != 0
        find(:first, :offset =>rand(c))
      end
    end
  end
end

class String
  def fix_url
    self.include?('http') ? self : "http://#{self}"
  end
end

class HomeController < ApplicationController
  def index
    @costume = Costume.random
  end
end
