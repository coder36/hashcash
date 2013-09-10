require 'digest/sha1'
require 'securerandom'
require 'date'
require 'base64'

class HashCash

	def initialize( bits )
		@bits = bits
		@mask = get_mask( bits )
	end

	def get_mask( bits )
		(1...bits).inject(1) { |sum| (sum * 2 ) + 1}
	end

	# Generate a hash
	def hash( email )
		time = Time.now.strftime( "%d%m%y" )
		find( "1:" + @bits.to_s + ":" + time + ":" + email + "::" )
	end

	def find( str )
		r = SecureRandom.hex(20).to_i
		while true			
			w = str + r.to_s 
			# Base64.strict_encode64( r.to_s )
			s = Digest::SHA1.hexdigest (w)
			return w if (s.to_i(16) & @mask) == 0 
			r = r + 1 
		end
	end

	def validate( hash )
		d = Date.strptime( hash[5,6], "%d%m%y" )
		return :FAIL_ON_DATE if ( d < (Date.today -2) || d > (Date.today +2) )
		s = (Digest::SHA1.hexdigest hash).to_i(16)
		return :FAIL_ON_HASH if (s & get_mask( hash[2,2].to_i ) ) != 0
		:OK
	end

end