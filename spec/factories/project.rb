FactoryBot.define do
  factory(:project) do
    name { Faker::Name.name }
    description { Faker::Markdown.emphasis }
  end
end
