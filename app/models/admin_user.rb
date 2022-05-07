class AdminUser < ApplicationRecord
  scope :signed_in_users, -> { where("expired_at >= NOW()").available }
  scope :available, -> { where(deleted_at: nil) }
  before_save :set_password_hash
  attr_accessor :password

  def validate_password?(password)
    return false unless available?
    hash_password(password) == password_hash
  end

  def hash_password(password)
    self.class.hash_password(password, password_solt)
  end

  def available?
    deleted_at.blank?
  end

  def sign_in
    return nil unless available?
    session_id = SecureRandom.uuid
    begin
      update(
        session_id: session_id,
        expired_at: Time.zone.now().since(1.day)
      )
    rescue
      return nil
    end
    session_id
  end

  def sign_out
    update(
      session_id: nil,
      expired_at: nil
    )
  end

  def self.signed_in_user(session_id)
    return nil unless session_id
    signed_in_users.find_by(session_id: session_id)
  end

  def self.find_by_user_name_and_password(user_name, password)
    result = available.find_by(user_name: user_name)
    (result&.validate_password?(password) || nil) && result
  end

  def self.create(**hash)
    create!(hash)
    true
  rescue
    false
  end

  def self.hash_password(password, solt)
    Digest::SHA256.hexdigest(solt + "#" + password)
  end

  private

  def set_password_hash
    solt = password.present? && SecureRandom.uuid
    self.password_solt = solt
    self.password_hash = solt && self.class.hash_password(password, solt)
  end
end
