Hashcash
========

How can we reduce spam ?  

A simple approach is to charge 5p for every email.  This would stop the spammers!  Another approach is to limit the number of emails which a (hijacked spambot) can send.  This is where proof of work algorthms come in.  


What is a proof of work algorithm?
----------------------------------
A proof of work algorthm is a mechanism by which a hash can be produced which demonstrates that some CPU work has taken place.  The algorithm will typically take seconds to run.

Based on: http://en.wikipedia.org/wiki/Hashcash

Given an email address:            markymiddleton@gmail.com
Prefix with a date:                220813:markymiddleton@gmail.com
Prefix with a 0 bit mask length:   1:20:220813:markymiddleton@gmail.com 

The proof of work algorithm (in pseudo code):

		a = "1:20:220813:markymiddleton@gmail.com"
		s = 7668687687686677868986       <===== large random number
		while( true ) {
			s = s + 1            
			proof = a + "::" + s         <==== "1:20:220813:markymiddleton@gmail.com::7668687687686677868986"
			hash = sha1 ( proof )        <==== "68768778687687667860000"
			if the first 20 bits of the hash is 0, then return proof
		}


Ruby implementation:

		hashcash = HashCash.new( 20 )
		h = hashcash.hash( "markymiddleton@gmail.com" )
		puts h
		hashcash.validate( h )



To run the tests:

        rspec tests.rb