class Asset < ApplicationRecord
    belongs_to :user
    has_many :purchases
    has_many_attached :pictures
    has_one_attached :zip_file
end
