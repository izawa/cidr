# Cidr

CIDR aggregator for IPv4 addresses

## Installation

Add this line to your application's Gemfile:

    gem 'cidr', :git => "https://github.com/izawa/cidr.git"

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cidr

## Usage

    require 'cidr'

    aggregator = Cidr::Aggregator.new

    aggregator.add('192.168.0.1')
    aggregator.add('192.168.0.2')
    aggregator.add('192.168.0.3')
    aggregator.add('192.168.0.4')
    aggregator.add('192.168.0.5')
    aggregator.add('192.168.0.6')
    aggregator.add('192.168.0.7')

    aggregator.list
      #=> [{:addr=>"192.168.0.1", :prefix=>32},
           {:addr=>"192.168.0.2", :prefix=>31},
           {:addr=>"192.168.0.4", :prefix=>30}]

aggregator.add will be able to recognize the input string in the following format.

  * 192.168.0.1  (without prefix)
  * 192.168.0.0/24 (with prefix)

'xxx.xxx.xxx.xxx' and  'xxx.xxx.xxx.xxx/32' are assumed to be identical.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
