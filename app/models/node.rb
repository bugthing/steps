class Node < ActiveRecord::Base
  extend InjectedAssociation

  validates :name, presence: true

  injected_association :step

  attr_accessor :plan
  attr_writer :step_source
  attr_writer :step_fetcher

end
