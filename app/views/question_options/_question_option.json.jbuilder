json.extract! question_option, :id, :question_id, :title, :is_correct, :deleted_at, :created_at, :updated_at
json.url question_option_url(question_option, format: :json)
