module Rapidfire
  class AnswerGroup < ActiveRecord::Base
    belongs_to :question_group
    belongs_to :user, polymorphic: true
    has_many   :answers, inverse_of: :answer_group, autosave: true

    validates_uniqueness_of :email, scope: [:first_name, :last_name]

    if Rails::VERSION::MAJOR == 3
      attr_accessible :question_group, :user, :first_name, :last_name, :email
    end
  end
end
