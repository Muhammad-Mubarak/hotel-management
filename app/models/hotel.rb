class Hotel < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  has_many_attached :images
end
