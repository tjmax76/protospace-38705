class Comment < ApplicationRecord
  validates :content, presence: true
  
  belongs_to :user, dependent: :destroy
  belongs_to :prototype, dependent: :destroy

end
