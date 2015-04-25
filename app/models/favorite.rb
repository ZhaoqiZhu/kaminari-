class Favorite
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String, default: ""
  field :votes, type: Integer, default: 0
  #field :answers, type: Array, default: []
  field :answers_count, type: Integer, default: 0

  belongs_to :owner, class_name: "User"
  validates_presence_of :owner

  has_and_belongs_to_many :answers, inverse_of: nil

end
