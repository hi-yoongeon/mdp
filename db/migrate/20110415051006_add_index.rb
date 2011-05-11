class AddIndex < ActiveRecord::Migration
  def self.up
    # sequence index
    add_index :activities, :sequence, :unique => false
    add_index :alarms, :sequence, :unique => false
    add_index :followings, :sequence, :unique => false
    add_index :messages, :sequence, :unique => false
    add_index :notices, :sequence, :unique => false
    add_index :posts, :sequence, :unique => false
    add_index :store_detail_info_logs, :sequence, :unique => false
    add_index :store_food_logs, :sequence, :unique => false
    add_index :post_comments, :sequence, :unique => false
    
    # attach_files
    add_index :attach_files, :store_id, :unique => false
    add_index :attach_files, :post_id, :unique => false
    
    # bookmarks
    add_index :bookmarks, :user_id
    add_index :bookmarks, :object, :unique => false
    add_index :bookmarks, :foreign_key, :unique => false

    # likes
    add_index :likes, :user_id
    add_index :likes, :object, :unique => false
    add_index :likes, :foreign_key, :unique => false    

    # messages

    # posts
    add_index :posts, :store_id
    add_index :posts, :user_id
    add_index :posts, :lat
    add_index :posts, :lng

    # post_comments
    add_index :post_comments, :post_id
    
    # store_detail_infos
    add_index :store_detail_infos, :store_id
    
    # store_foods
    add_index :store_foods, :store_id
    add_index :store_foods, :food_id
    
    # store_tags
    add_index :store_tags, :store_id
    add_index :store_tags, :tag_id
    
    # post_tags
    add_index :post_tags, :post_id
    add_index :post_tags, :tag_id
    
    # user_tags
    add_index :user_tags, :user_id
    add_index :user_tags, :tag_id
    
    # messages
    add_index :messages, :received_user_id
    add_index :messages, :sent_user_id

    # user_external_accounts
    add_index :user_external_accounts, :user_id
    
    # user_mileages
    add_index :user_mileages, :user_id
    
    # stores
    add_index :stores, :reg_user_id
    add_index :stores, :lat, :unique => false
    add_index :stores, :lng, :unique => false
    add_index :stores, :like_count, :unique => false
    
  end

  def self.down
    # sequence index
    remove_index :activities, :sequence
    remove_index :alarms, :sequence
    remove_index :followings, :sequence
    remove_index :messages, :sequence
    remove_index :notices, :sequence
    remove_index :posts, :sequence
    remove_index :store_detail_info_logs,  :sequence
    remove_index :store_food_logs,  :sequence
    remove_index :post_comments,  :sequence
    
    # attach_files
    remove_index :attach_files, :store_id
    remove_index :attach_files, :post_id
    
    # bookmarks
    remove_index :bookmarks, :user_id
    remove_index :bookmarks, :object
    remove_index :bookmarks, :foreign_key

    # likes
    remove_index :likes, :user_id
    remove_index :likes, :object
    remove_index :likes, :foreign_key

    # messages

    # posts
    remove_index :posts, :store_id
    remove_index :posts, :user_id
    remove_index :posts, :lat
    remove_index :posts, :lng

    # post_comments
    remove_index :post_comments, :post_id
    
    # store_detail_infos
    remove_index :store_detail_infos, :store_id
    
    # store_foods
    remove_index :store_foods, :store_id
    remove_index :store_foods, :food_id
    
    # store_tags
    remove_index :store_tags, :store_id
    remove_index :store_tags, :tag_id
    
    # post_tags
    remove_index :post_tags, :post_id
    remove_index :post_tags, :tag_id
    
    # user_tags
    remove_index :user_tags, :user_id
    remove_index :user_tags, :tag_id
    
    # messages
    remove_index :messages, :received_user_id
    remove_index :messages, :sent_user_id

    # user_external_accounts
    remove_index :user_external_accounts, :user_id
    
    # user_mileages
    remove_index :user_mileages, :user_id
    
    # stores
    remove_index :stores, :reg_user_id
    remove_index :stores, :lat
    remove_index :stores, :lng
    remove_index :stores, :like_count


  end
end
