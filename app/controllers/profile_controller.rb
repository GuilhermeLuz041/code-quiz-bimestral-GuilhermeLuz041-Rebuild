class ProfileController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @quiz_results = UserResult.where(user: current_user)
                            .includes(:questionnaire)
                            .order(submitted_at: :desc)
  end
end