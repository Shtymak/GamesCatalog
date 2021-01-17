class CallMe < ApplicationRecord
  validates :phone, presence: { message: 'only number' },
                    numericality: true,
                    length: { minimum: 10, maximum: 15 }
end
