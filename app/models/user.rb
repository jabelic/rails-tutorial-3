class User < ApplicationRecord
    attr_accessor :remember_token # 
    before_save { self.email = email.downcase } #emailは大文字小文字を区別しない。`before_save {self.email = self.email.downcase! }`と等価
    # \Aは先頭
    # https://qiita.com/jnchito/items/ea7832df6f64a9034872
    # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    VALID_EMAIL_REGEX = /\A[\w+\-]+[\.]*[\w+\-]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :name, presence: true ,length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },format: { with: VALID_EMAIL_REGEX },uniqueness: { case_sensitive: false } #  uniqueness: { case_sensitive: false } 大文字小文字を区別してユニークであること
    has_secure_password
    # allow_nil: true 値がnilの場合にvalidationをスキップする
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
    # Users.methodでクラスメソッド
    # 渡された文字列のハッシュ値を返す
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    # ランダムなトークンを返す
    def User.new_token
        SecureRandom.urlsafe_base64
    end

    # 永続セッションのためにユーザーをデータベースに記憶する
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    # # 渡されたトークンがダイジェストと一致したらtrueを返す
    # def authenticated?(remember_toke n)
    #     BCrypt::Password.new(remember_digest).is_password?(remember_token)
    # end

    # 渡されたトークンがダイジェストと一致したらtrueを返す
    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    # ユーザーのログイン情報を破棄する
    def forget
        update_attribute(:remember_digest, nil)
    end
end
