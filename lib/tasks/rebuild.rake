namespace :rebuild do
  desc "Rebuild data"
  task data: :environment do
    Category.destroy_all
    Vehicle.destroy_all
    4.times.each do
      category_name = Faker::Movie.title
      vehicle_name = Faker::Vehicle.make_and_model
      3.times.each do |t|
        Category.create(name: category_name, created_at: t.months.ago, qty_of_views: rand(20))
        Vehicle.create(name: vehicle_name, created_at: t.months.ago, qty_of_views: rand(20))
      end
    end
  end

end
