# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Supplier.create(name: "ゼクウ株式会社", user_id: 1, is_side_business: false)
Supplier.create(name: "ピザーラ橋本下九沢店", user_id: 1, is_side_business: false)
Supplier.create(name: "ブランディア物販", user_id: 1, is_side_business: true)
Supplier.create(name: "アフィリエイト", user_id: 1, is_side_business: true)

ExpenseCategory.create(name: "仕入れ費", user_id: 1)
ExpenseCategory.create(name: "交際費", user_id: 1)


Income.create(month: 1, price: 20000, supplier_id: 1, user_id: 1, is_side_business: false, year: 2022)
Income.create(month: 2, price: 30003, supplier_id: 1, user_id: 1, is_side_business: false, year: 2022)
Income.create(month: 3, price: 14567, supplier_id: 2, user_id: 1, is_side_business: false, year: 2022)
Income.create(month: 4, price: 201000, supplier_id: 1, user_id: 1, is_side_business: false, year: 2022)
Income.create(month: 5, price: 267890, supplier_id: 1, user_id: 1, is_side_business: false, year: 2022)
Income.create(month: 6, price: 23451, supplier_id: 1, user_id: 1, is_side_business: false, year: 2022)
Income.create(month: 6, price: 1234, supplier_id: 2, user_id: 1, is_side_business: false, year: 2022)
Income.create(month: 7, price: 14688, supplier_id: 2, user_id: 1, is_side_business: false, year: 2022)
Income.create(month: 8, price: 75678, supplier_id: 2, user_id: 1, is_side_business: false, year: 2022)
Income.create(month: 9, price: 56789, supplier_id: 2, user_id: 1, is_side_business: false, year: 2022)
Income.create(month: 10, price: 90000, supplier_id: 2, user_id: 1, is_side_business: false, year: 2022)
Income.create(month: 11, price: 100000, supplier_id: 1, user_id: 1, is_side_business: false, year: 2022)
Income.create(month: 12, price: 12000, supplier_id: 1, user_id: 1, is_side_business: false, year: 2022)

Income.create(month: 1, price: 20000, supplier_id: 1, user_id: 1, is_side_business: true, year: 2022)
Income.create(month: 2, price: 30003, supplier_id: 1, user_id: 1, is_side_business: true, year: 2022)
Income.create(month: 3, price: 14567, supplier_id: 2, user_id: 1, is_side_business: true, year: 2022)
Income.create(month: 4, price: 201000, supplier_id: 1, user_id: 1, is_side_business: true, year: 2022)
Income.create(month: 5, price: 267890, supplier_id: 1, user_id: 1, is_side_business: true, year: 2022)
Income.create(month: 6, price: 23451, supplier_id: 1, user_id: 1, is_side_business: true, year: 2022)
Income.create(month: 6, price: 1234, supplier_id: 2, user_id: 1, is_side_business: true, year: 2022)
Income.create(month: 7, price: 14688, supplier_id: 2, user_id: 1, is_side_business: true, year: 2022)
Income.create(month: 8, price: 75678, supplier_id: 2, user_id: 1, is_side_business: true, year: 2022)
Income.create(month: 9, price: 56789, supplier_id: 2, user_id: 1, is_side_business: true, year: 2022)
Income.create(month: 10, price: 90000, supplier_id: 2, user_id: 1, is_side_business: true, year: 2022)
Income.create(month: 11, price: 100000, supplier_id: 1, user_id: 1, is_side_business: true, year: 2022)
Income.create(month: 12, price: 12000, supplier_id: 1, user_id: 1, is_side_business: true, year: 2022)