class AwsSqsReader
  def connect!
    env = Ebx::AwsEnvironment.new
    sqs = AWS::SQS.new
    @queue = sqs.queues.named(env.sqs_name)

    @queue.poll do |msg|
      msg = JSON.parse(msg.body)['Message']
      Rails.logger.info "MSG Received #{msg}"
      #send(msg['method'], *msg['args'])
    end
  end

  def create_table(table_name, key = :id, options = {})
  end
end
