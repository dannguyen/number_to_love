require 'spec_helper'

module NumberToLove
  describe "LoveNumber" do

    before(:each) do
      @num = LoveNumber.new(423, precision: 2)
    end

    context 'instance methods' do 
      it '#to_v reflects original value' do 
        expect(@num.to_v).to eq 423
      end

      it '#to_s returns a string with options' do 
        expect(@num.to_s).to eq '420'
      end
    end

    context "Acting like a number" do 
      context 'delegate to Numeric' do 
        it 'delegates to original number, i.e. :value' do 
          expect(@num.next).to eq 424
        end
      end

      it 'should have equality based off of :value' do 
        expect(@num).to eq 423
      end
    end


    context 'String.like behavior' do 
      it 'interpolates' do 
        expect("#{@num}").to eq "420"
      end

      it "delgates all non-numeric methods to String" do 
       # pending "hmmmm...."
        bignum = LoveNumber.new(50000)
        expect(bignum.upcase).to eq '50 THOUSAND' 
      end

    end

    context 'ad-hoc addition of options' do 
      it 'treats options as attr_accessors' do 
        @num.precision = 3
        expect(@num.to_s).to eq "423"
      end
    end


  end
end