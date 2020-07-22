json.extract! channel, :id, :slug, :user_id, :team_id, :created_at, :updated_at

json.messages do
    json.array! channel.messages do |m|
        json.extract! m, :id, :body, :user_id
        json.date m.created_at.strftime("%d/%m/$y")
        json.user do
            json.extract! m.user, :id, :name, :email
        end
    end
end