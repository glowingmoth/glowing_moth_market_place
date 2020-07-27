class User < ApplicationRecord
    has_many :assets
    has_many :purchases
end
