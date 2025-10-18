json.extract! question, :id, :questionnaire_id, :enunciation, :deleted_at, :created_at, :updated_at
json.url question_url(question, format: :json)
