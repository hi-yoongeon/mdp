class AccessGrant < ActiveRecord::Base
  
  protected
  def self.access_token_expired?(token)
    access_grant = find(:first, :conditions => ["access_token = ?", token])
    return DateTime.now.to_f > access_grant.access_token_expires_at.to_f
  end
  
  def self.random_string(len)
    #generat a random password consisting of strings and digits
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    newpass = ""
    1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
    return newpass
  end
  
  
  def self.refresh(token)
    access_grant = find(:first, :conditions => ["access_token = ?", token])
    token = AccessGrant.generate_token(token)
    expires_at = DateTime.now + 7
    if access_grant.update_attributes(:access_token => token , :access_token_expires_at => expires_at)
      token
    end
    nil
  end

  def self.revoke(token)
    access_grant = find(:first, :select => "id", :conditions => ["access_token = ?", token])
    delete(access_grant.id)
  end

  def self.generate_token(text)
    security_salt = "wqopfjdvaqpj@!#!RFjvqievjq"
    require 'digest/sha1'
    plaintext = text + security_salt

    unique_token_generated = false
    token = nil

    while !unique_token_generated do
      token = Digest::SHA1.hexdigest plaintext
      # validate duplication of generated token
      if count(:conditions => ["access_token = ?", token]) == 0
        unique_token_generated = true
      end
    end

    token
  end
  
end
