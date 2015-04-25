class Answer
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body, type: String, default: ""
  field :votes, type: Integer, default: 0

  belongs_to :question
  belongs_to :author, class_name: "User"
  validates_presence_of :question
  validates_presence_of :author

  after_create do
		self.question.inc(answers_count: 1)
	end

	after_destroy do
		self.question.inc(answers_count: -1)
	end

  def self.hottestq
    all.desc(:total_votes)
  end

end
