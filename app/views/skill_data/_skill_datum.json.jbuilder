json.extract! skill_datum, :id, :skill_id, :name, :range, :cost_id, :sp, :timing_id, :text, :is_artifact, :created_at, :updated_at
json.url skill_datum_url(skill_datum, format: :json)
