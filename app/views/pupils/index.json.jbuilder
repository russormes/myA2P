json.array!(@pupils) do |pupil|
  json.extract! pupil, :id, :given_name, :other_name, :family_name, :name_known_by, :dob, :gender, :image_path
  json.url pupil_url(pupil, format: :json)
end
