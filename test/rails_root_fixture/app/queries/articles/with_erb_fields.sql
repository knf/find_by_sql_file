-- Gets certain fields from articles using ERB to pass the SELECT fragment

SELECT <%= @select -%> FROM articles