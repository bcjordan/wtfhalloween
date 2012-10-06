module ActiveRecord
  class Base
    def self.random
      if (c = count) != 0
        find(:first, :offset => rand(c))
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
    session['visitor'] = (!session['visitor'] || params['reset']) ? { } : session['visitor']
    @visitor           = session['visitor']
    @visitor.merge!(params)

    # Try a bunch of costumes on, virtually
    tries = 0
    while (!@costume || !match(@costume, @visitor))
      @costume = Costume.random
      tries    += 1
      if tries > 350
        @visitor = { } # Forget everything we've learned. Too specific.
        break
      end
    end

    session['visitor'] = @visitor

    @choice = get_option @visitor, @costume
  end

  ## TODO: Fix this logic to handle falses
  def match(costume, visitor)
    for key, visitor_choice in visitor
      if costume.has_attribute? (key)
        costume_choice = (costume.read_attribute key)
      end

      if (visitor_choice == "duh") and (costume_choice.nil? or costume_choice == "" or costume_choice == "FALSE")
        return false
      elsif (visitor_choice == "nuh") and !(costume_choice.nil? or costume_choice == "" or costume_choice == "FALSE")
        return false
      end
    end

    return true
  end

  # @param [Hash] visitor
  # @param [Costume] costume
  def get_option visitor, costume
    if costume.is_girl and !visitor["girl"]
      return { phrase: "I'm not a fucking girl", param: "girl=nuh" }
    elsif costume.is_guy and !visitor["girl"]
      return { phrase: "I'm not a fucking dude", param: "girl=duh" }
    elsif costume.is_slutty and !visitor["slutty"]
      return { phrase: "I'm not a fucking slut", param: "slutty=nuh" }
    elsif costume.isnt_slutty and !visitor["slutty"]
      return { phrase: randomize("What is this cutesy shit? I want to get laid", "not slutty enough", "nowhere near slutty enough"), param: "slutty=duh" }
    else
      return { phrase: randomize("Forget everything I told you", "You don't know me, reset", "forget what I said"), param: "reset=duh" }
    end
  end

  def is s
    s != nil and s != "nuh"
  end

  def randomize(*arr)
    if (arr.length == 0)
      return 0
    end
    return arr[rand(arr.length)]
  end
end
