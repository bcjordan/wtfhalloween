class Costume < ActiveRecord::Base
  attr_accessible :amazon_id, :amazon_link, :buy, :girl, :imgur, :kid, :prime, :quip, :scary, :short_name, :slutty
  validates_uniqueness_of :imgur
  validates_presence_of :amazon_link, :short_name

  def is_girl
    is girl
  end

  def is_guy
    !(is girl)
  end

  def is_slutty
    is slutty
  end

  def isnt_slutty
    !(is slutty)
  end

  def is s
    s != nil and s != "" and s != "FALSE"
  end
end
