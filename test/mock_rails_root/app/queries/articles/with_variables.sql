-- Gets articles with given values for 'created_on' and 'published'

SELECT * FROM articles WHERE created_on = :created_on
                         AND published  = :published
