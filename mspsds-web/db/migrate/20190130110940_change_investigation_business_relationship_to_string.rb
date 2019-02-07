class ChangeInvestigationBusinessRelationshipToString < ActiveRecord::Migration[5.2]
  class InvestigationBusiness < ApplicationRecord; end
  def up
    safety_assured do
      change_table(:investigation_businesses, bulk: true) do |t|
        t.string :new_relationship
        InvestigationBusiness.in_batches.each_record do |ib|
          ib.update!(new_relationship: from_enum(ib.relationship))
        end
        t.remove :relationship
        t.rename :new_relationship, :relationship
      end
    end
  end

  def down
    safety_assured do
      change_table(:investigation_businesses, bulk: true) do |t|
        t.rename :relationship, :new_relationship
        t.integer :relationship, default: 0, null: false
        InvestigationBusiness.in_batches.each_record do |ib|
          ib.update!(relationship: to_enum(ib.new_relationship))
        end
        t.remove :new_relationship
      end
    end
  end

  def from_enum relationship_enum_id
    case relationship_enum_id
    when 0
      "manufacturer"
    when 1
      "distributor"
    when 2
      "importer"
    else
      raise "Unexpected relationship enum value!"
    end
  end

  def to_enum relationship_enum_title
    case relationship_enum_title
    when "manufacturer"
      0
    when "distributor"
      1
    when "importer"
      2
    else
      raise "Unexpected relationship enum title!"
    end
  end
end
