#!/bin/env ruby
# encoding: utf-8

FactoryGirl.define do
  factory :location do
    name "Tähtitorninmäki I Observatoriebacken"
    foursq_id "4ba8f64ef964a5202dfe39e3"
    street_address "Tähtitorninkatu"
    cross_street "Tähtitorninkatu"
    city "Helsinki"
    state "Etelä-Suomen Lääni"
    postal_code "00140"
    country "Finland"
    lat 60.161977496360954
    lng 24.952762126922607
    posts_count 0
  end
end