class CreateUserBlogInfos < ActiveRecord::Migration
  def change
    create_table :user_blog_infos do |t|
      t.string :userName
      t.string :feedUrl
      t.string :blogUrl

      t.timestamps null: false
    end
  end
end
