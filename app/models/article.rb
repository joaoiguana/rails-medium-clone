class Article < ApplicationRecord
  belongs_to :user
  has_rich_text :content

  validates :title, presence: true
  validates :content, presence: true

  # Friendly URLs using slugs
  extend FriendlyId
  friendly_id :title, use: :slugged

  # Scopes
  scope :published, -> { where(published: true) }
  scope :drafts, -> { where(published: false) }

  def reading_time
    words_per_minute = 200
    word_count = content.to_plain_text.scan(/\w+/).size
    (word_count.to_f / words_per_minute).ceil
  end
end
