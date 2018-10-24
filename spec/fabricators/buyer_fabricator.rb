Fabricator(:buyer) do
  # neighborhood
  # houses(count: 2)
  # name { Faker::Name.name }
  # age 45
  # gender { %w(M F).sample }
  venue
  first_name { 'Billy' }
  last_name { 'Mays' }
  email {'mays@mays.com' }
  username { 'b_amazed' }
  password_digest { '567890123' }
end
