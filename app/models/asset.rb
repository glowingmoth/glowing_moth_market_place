class Asset < ApplicationRecord
    belongs_to :user
    has_many :purchases, dependent: :destroy
    has_many_attached :pictures
    has_one_attached :zip_file
    validates :title, :content, presence: true, length: {maximum: 100}
    validates :description, presence: true, length: {maximum: 400}
    validates :price, presence: true, numericality: {only_integer: true, greater_than: 0}
    validates :pictures, :zip_file, presence: true

    def has_purchased?(user_id)
        self.purchases.find_by_user_id(user_id)
    end
end
