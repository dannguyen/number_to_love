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
        expect(bignum.upcase).to eq '50 K' 
      end
    end


    context 'default abbreviated units' do 
      before do 
        @num = LoveNumber.new(10000)
      end

      it 'should have abbreviated units by default' do 
        expect(@num.to_s).to eq "10 K"
      end
    end


    context ':minimalize option' do 
     
      context 'default options' do 
        it 'abbreviated units with unspaced format' do 
          expect(number_to_love(65121, minimalize: 2).to_s).to eq "65K"
        end
      
        it 'should have no delimiters' do 
          expect(number_to_love(65121, minimalize: 3).to_s).to eq "65.1K"
        end

        it 'should override all other human options' do 
          t = number_to_love(65121, minimalize: true)
          t.units = "%n %u"
          t.precision = 10

          expect(number_to_love(65121, minimalize: 2).to_s).to eq "65K"
        end
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