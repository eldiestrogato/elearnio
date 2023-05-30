class Author < ApplicationRecord
  has_many :courses
  validates :name, presence: true

  def change_author(new_author)
    self.courses.update_all(author_id: new_author)
  end
end
