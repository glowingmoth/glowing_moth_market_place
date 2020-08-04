class Asset < ApplicationRecord
    belongs_to :user
    has_many :purchases, dependent: :destroy
    has_many_attached :pictures
    has_one_attached :zip_file

    def has_purchased?(user_id)
        self.purchases.find_by_user_id(user_id)
    end
end
