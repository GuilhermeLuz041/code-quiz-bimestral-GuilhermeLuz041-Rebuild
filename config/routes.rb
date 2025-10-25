Rails.application.routes.draw do
  devise_for :users

  root "questionnaires#index"


  resources :questionnaires do

    resources :questions, except: [:index]

    get 'question/:id', to: 'quiz_attempts#show', as: :quiz_question
    post 'question/:id/submit', to: 'quiz_attempts#submit_answer', as: :submit_quiz_answer
    get 'result', to: 'quiz_attempts#result', as: :quiz_result
  end


  resources :questions, only: [] do
    resources :question_options, except: [:index, :show]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end