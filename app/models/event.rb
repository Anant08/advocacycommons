class Event < ApplicationRecord
  has_many :ticket_levels

  belongs_to :location, class_name: 'Address', foreign_key: :address_id
  belongs_to :creator, class_name: 'Person'
  belongs_to :organizer, class_name: 'Person'
  belongs_to :modified_by, class_name: 'Person'
  has_many :attendances
  has_many :reminders

  after_save :add_identifier

  scope :any_identifier, ->(identifier) { where('? = any (identifiers)', identifier) }

  def add_identifier
    identifier = "advocacycommons:#{id}"

    if identifiers.nil?
      self.identifiers = [identifier]
      save
    elsif identifiers.include?(identifier)
      true
    else
      identifiers << identifier
      save
    end
  end

  def identifier(system_prefix)
    identifiers.detect { |i| i["#{system_prefix}:"] }
  end

  def identifier_id(system_prefix)
    identifier(system_prefix)&.split(':')&.second
  end
end
