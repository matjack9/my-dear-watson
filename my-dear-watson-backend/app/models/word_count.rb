class WordCount < ApplicationRecord
  belongs_to :twitter_account

  def twitter_handle
    self.twitter_account.handle
  end
end
