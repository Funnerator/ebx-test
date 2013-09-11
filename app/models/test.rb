class Test
  include Dynamoid::Document

  field :name
  field :email
  field :rank, :integer
  field :number, :float
  field :joined_at, :datetime
  field :hash, :serialized
end
