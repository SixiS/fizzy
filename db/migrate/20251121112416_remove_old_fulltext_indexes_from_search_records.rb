class RemoveOldFulltextIndexesFromSearchRecords < ActiveRecord::Migration[8.2]
  def up
    # Specific for Mysql
    return unless connection.adapter_name.include?("Mysql")

    (0..15).each do |shard|
      remove_index "search_records_#{shard}", name: "index_search_records_#{shard}_on_content_and_title"
    end
  end

  def down
    # Specific for Mysql
    return unless connection.adapter_name.include?("Mysql")

    (0..15).each do |shard|
      add_index "search_records_#{shard}", [ :content, :title ], type: :fulltext, name: "index_search_records_#{shard}_on_content_and_title"
    end
  end
end
