class Costume < ActiveRecord::Base
  attr_accessible :amazon_id, :amazon_link, :buy, :girl, :imgur, :kid, :prime, :quip, :scary, :short_name, :slutty
  validates_uniqueness_of :imgur
  validates_presence_of :amazon_link, :short_name
end
