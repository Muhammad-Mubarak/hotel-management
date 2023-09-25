class User < ApplicationRecord
  has_many :hotels, foreign_key: 'owner_id'
end
