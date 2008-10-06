ActiveRecord::Schema.define :version => 1 do

  create_table :articles, :force => true do |article|
    article.string    :title
    article.boolean   :published
    article.date      :created_on
    article.timestamp :updated_at
  end
end
