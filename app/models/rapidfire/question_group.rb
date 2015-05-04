module Rapidfire
  class QuestionGroup < ActiveRecord::Base
    has_many :questions
    has_many :answers, through: :questions
    validates :name, :presence => true

    if Rails::VERSION::MAJOR == 3
      attr_accessible :name
    end
  end
end
