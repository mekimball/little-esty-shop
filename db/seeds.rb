# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

      BulkDiscount.create!(discount: 0.5, number_of_items_necessary: 25, merchant_id: 1)
      BulkDiscount.create!(discount: 0.25, number_of_items_necessary: 20, merchant_id: 1)
      BulkDiscount.create!(discount: 0.15, number_of_items_necessary: 10, merchant_id: 1)
      BulkDiscount.create!(discount: 0.5, number_of_items_necessary: 15, merchant_id: 2)
