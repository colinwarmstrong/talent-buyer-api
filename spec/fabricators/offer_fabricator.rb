Fabricator(:offer) do
  status { 'pending' }
  guarantee { 9001 }
  date { '2018-12-24' }
  bonuses { 'Free chips in the dressing room' }
  radius_clause { '100 miles, 60 +/- days' }
  total_expenses { 5000 }
  gross_potential { 4001 }
  door_times { '9pm - 11pm' }
  age_range { '18+' }
  merch_split { '80/20 band/venue' }
  artist_name { 'Sepultura' }
end
