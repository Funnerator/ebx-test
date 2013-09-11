class AwsSnsWriter
  def connect!
    dg = Ebx::DeployGroup.new
    @topic = dg.notification_service

    @db = AWS::DynamoDB.new
  end

  # FORMAT
  # { request_items: {keys: [], [attributes_to_get: []], consistent_read:
  # <Bool>}, return_consumed_capacity: <TOTAL | NONE>
  def batch_get_item(options)
    @db.client.batch_get_item(options)
  end

  def batch_delete_item(options)
    @topic.publish({
      method: 'batch_delete_item',
      args: [table_name, key, options]
    }.to_json)
  end

  def create_table(table_name, key = :id, options = {})
    @topic.publish({
      method: 'create_table',
      args: [key, options]
    }.to_json)
  end

  def delete_item(table_name, key, options={})
    @topic.publish({
      method: 'delete_item',
      args: [key, options]
    }.to_json)
  end

  def delete_table(table_name)
    @topic.publish({
      method: 'delete_table',
      args: [table_name]
    }.to_json)
  end

  def get_item(table_name, key, options = {})
  end

  def update_item(table_name, key, options = {})
    @topic.publish({
      method: 'update_item',
      args: [table_name, key, options]
    }.to_json)
  end

  def list_tables
  end

  def put_item(table_name, object, options = {})
    @topic.publish({
      method: 'put_item',
      args: [table_name, object, options]
    }.to_json)
  end

  def query(table_name, opts = {})
  end

  def scan(table_name, scan_hash, select_opts)
  end

  def get_table(table_name)
  end

  def count(table_name)
  end

  def self.send_test
    w = AwsSnsWriter.new
    w.connect!

    w.create_table('testtt')
  end
end
