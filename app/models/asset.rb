class Asset < ApplicationRecord
    belongs_to :user
    has_many_attached :pictures
end
