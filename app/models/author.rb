class Author < ApplicationRecord
  has_many :courses

  def change_author(new_author)
    self.courses.update_all(author_id: new_author)
  end
end
