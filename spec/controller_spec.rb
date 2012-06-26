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

require File.expand_path(File.join(File.dirname(__FILE__), 'helper'))

require 'yaml'

describe RGeyer::Controller do
  context :list_gstore_objects do
    it 'can contact google' do
      yo = RGeyer::Controller.new("50.112.3.239", {:user => 'foo', :pass => 'barbaz'})
      yo.list_gstore_objects('rgeyer').each do |obj|
        puts obj['Key']
        ['Universal', 'iPod', 'iPad', 'AppleTV', 'Android High', 'High Profile' ].each do |preset|
          #yo.publish_to_amqp({:type => 'gstore', :object => obj, :handbrake_preset => preset})
        end
      end
    end
  end

  context :list_rss_objects do
    it 'can extract rss objects' do
      yo = RGeyer::Controller.new("50.112.3.239", {:user => 'foo', :pass => 'barbaz'})
      objects = yo.list_rss_objects 'http://archive.org/services/collection-rss.php?collection=opensource_movies'
      #puts objects.to_yaml
      puts yo.get_input_queue_status.to_yaml
    end
  end
end