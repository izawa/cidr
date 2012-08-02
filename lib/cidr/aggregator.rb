module Cidr

class Aggregator
  require 'ipaddr'
  
  ##
  ## private methods
  ##

  private
  
  def initialize
    @addr_pool = Array.new(32) {[]}
  end
  
  def _merge_address (pool, next_pool, hostmask)
    i=0
    while(i <= pool.length-2) 
      modified_flag = false
      if (pool[i] >> hostmask) ^ (pool[i+1] >> hostmask) == 1 then
        next_pool.push pool[i]
        pool.delete_at i
        pool.delete_at i
        modified_flag = true
      end
      i+=1
      i-=1 if modified_flag
    end
  end
  
  def _store_ipaddr_str (ip)
    begin
      ipa = IPAddr.new(ip,Socket::AF_INET)
    rescue
      return nil
    end
    prefixlen = _netmask2prefixlen(ipa.inspect.match(/^.*\/(.*)\>/)[1])
    @addr_pool[32 - prefixlen].push ipa.to_i
  end
  
  def _store_ipaddr_int (ip)
    if 2**32 > ip  && ip >= 0 then
      @addr_pool[0].push ip
    else
      return nil
    end
  end
  
  def _countbits (bits)
    bits = (bits & 0x55555555) + (bits >> 1 & 0x55555555);
    bits = (bits & 0x33333333) + (bits >> 2 & 0x33333333);
    bits = (bits & 0x0f0f0f0f) + (bits >> 4 & 0x0f0f0f0f);
    bits = (bits & 0x00ff00ff) + (bits >> 8 & 0x00ff00ff);
    return (bits & 0x0000ffff) + (bits >>16 & 0x0000ffff);
  end
  
  def _netmask2prefixlen (netmask)
    prefix=0
    netmask.split('.').each{|bits|
      prefix += _countbits (bits.to_i)
    }
    return prefix
  end
  
  def _aggregate
    for i in 0..30 do
      if @addr_pool[i].length > 1
        @addr_pool[i].sort!
        @addr_pool[i].uniq!
        _merge_address(@addr_pool[i], @addr_pool[i+1], i)
      end
    end
  end
  
  
  ##
  ## public methods
  ##
  
  public
  
  def add (ip)
    case ip.class.to_s
    when 'String'
      return nil unless _store_ipaddr_str (ip)
    when 'Fixnum'
      return nil unless _store_ipaddr_int (ip)
    else
      return nil
    end
  end
  
  def list
    _aggregate
    return_addrs = Array.new
    
    for i in 0..31 do
      @addr_pool[i].each {|ipaddr|
        return_addrs.push ({:addr => IPAddr.new(ipaddr,Socket::AF_INET).to_s,
                             :prefix => 32-i})
      }
    end
    return_addrs
  end
end

end
