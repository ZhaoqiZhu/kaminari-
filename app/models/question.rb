class Question
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  validates_presence_of :title
  field :body, type: String
  field :clicks, type: Integer, default: 0


  field :answers_count, type: Integer, default: 0
  field :total_votes, type: Integer, default: 0

  has_many :answers, dependent: :destroy
  belongs_to :author, class_name: "User"
  validates_presence_of :author


  def self.hottestq
    all.desc(:total_votes)
  end
end
