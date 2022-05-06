class User < ApplicationRecord
    before_save { self.email = email.downcase } #emailは大文字小文字を区別しない。`before_save {self.email = self.email.downcase! }`と等価
    # \Aは先頭
    # https://qiita.com/jnchito/items/ea7832df6f64a9034872
    # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    VALID_EMAIL_REGEX = /\A[\w+\-]+[\.]*[\w+\-]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :name, presence: true ,length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },format: { with: VALID_EMAIL_REGEX },uniqueness: { case_sensitive: false } #  uniqueness: { case_sensitive: false } 大文字小文字を区別してユニークであること
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
end
