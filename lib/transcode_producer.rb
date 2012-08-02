# Copyright (c) 2012 Ryan J. Geyer
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

require 'fog'
require 'bunny'
require 'simple-rss'
require 'open-uri'

module RGeyer
  class TranscodeProducer

    def initialize(amqp_hostname, options={})
      options.merge!({:host => amqp_hostname})
      @input_queue_name = options[:input_queue_name] || 'encode_input'

    #  @gstore = Fog::Storage.new({:provider => 'Google'})
      @bunny = Bunny.new(options)
      @bunny.start
      @queue = @bunny.queue(@input_queue_name)
      @exchange = @bunny.exchange('')
    end

    #def list_gstore_objects(bucket_name)
    #  @gstore.get_bucket(bucket_name).body['Contents']
    #end

    def list_rss_objects(rss_link)
      rss = SimpleRSS.parse open(rss_link)
      rss.items
    end

    def publish_to_amqp(message)
      @exchange.publish(message, :key => @input_queue_name)
    end

    def get_input_queue_status
      @queue.status
    end
  end
end