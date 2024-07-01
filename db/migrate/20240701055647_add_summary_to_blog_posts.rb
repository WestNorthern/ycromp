class AddSummaryToBlogPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :blog_posts, :summary, :text
  end
end
