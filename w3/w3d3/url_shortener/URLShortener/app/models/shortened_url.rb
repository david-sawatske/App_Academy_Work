require 'securerandom'

class ShortenedUrl < ApplicationRecord
  include SecureRandom

  validates :short_url, presence: true, uniqueness: true
  validates :long_url, presence: true
  validates :user_id, presence: true

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "User"

  has_many :visits,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: "Visit"

  has_many :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :user


  def self.from_url(options)
    ShortenedUrl.create!(user_id: options[:user].id,
                         long_url: options[:long_url],
                         short_url: random_code)
  end

  def self.random_code
    random = SecureRandom.base64(16)
    while ShortenedUrl.exists?(short_url: random)
      random = SecureRandom.base64(16)
    end
    random
  end

  def num_clicks
    visits.length
  end

  def num_uniq
    visitors.length
  end

  def num_recent_uniques
    recent_visits = visits.select { |visit| visit.updated_at + 600 >= Time.now }

    recent_visits.uniq(&:user_id).length
  end

end

# visits.select { |visit| visit. }
