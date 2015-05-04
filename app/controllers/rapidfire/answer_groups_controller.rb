module Rapidfire
  class AnswerGroupsController < Rapidfire::ApplicationController
    before_filter :find_question_group!

    def new
      @answer_group_builder = AnswerGroupBuilder.new(answer_group_params)
    end

    def create
      @answer_group_builder = AnswerGroupBuilder.new(answer_group_params)

      if @answer_group_builder.save
        flash[:notice] = "Thank you for completing the survey, #{params[:answer_group][:first_name]}, your answers have been saved."
        redirect_to question_groups_path
      else
        if AnswerGroup.where(email: params[:answer_group][:email], first_name: params[:answer_group][:first_name], last_name: params[:answer_group][:last_name]).any?
          flash[:notice] = 'Thanks, but you have already completed the survey.'
          redirect_to question_groups_path
        else
          flash[:notice] = 'There was a problem submitting your answers, please try again.'
          render :new
        end
      end
    end

    private
    def find_question_group!
      @question_group = QuestionGroup.find(params[:question_group_id])
    end

    def answer_group_params
      answer_params = { params: params[:answer_group] }
      answer_params.merge(user: current_user, question_group: @question_group)
    end
  end
end
