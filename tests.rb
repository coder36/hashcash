require './hashcash'
describe "HashCash" do 
	
	subject { HashCash.new( 20 ) }

	it "can generate a bit mask" do
		subject.get_mask( 8 ).should == 255
	end

	it "can generate a hash" do 
		h = subject.hash( "coder36@mygmail.com")
	end

	it "can validate" do
		h = subject.hash( "coder36@mygmail.com")
		subject.validate( h ).should be_eql :OK
		subject.validate( "1:20:060408:adam@cypherspace.org::1QTjaYd7niiQA/sc:ePa" ).should be_eql :FAIL_ON_DATE
		subject.validate( h + "b" ).should be_eql :FAIL_ON_HASH
	end
	
end