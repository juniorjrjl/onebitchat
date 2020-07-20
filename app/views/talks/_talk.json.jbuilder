json.extract! talk, :id, :user_one_id, :user_two_id, :team_id, :created_at, :updated_at

json.messages do
    json.array! talk.messages do |m|
        json.extract! m, :id, :body, :user_id, :created_at, :updated_at
    end
end