require 'spec_helper'


describe "number_to_love" do

  it 'is a helper method that creates a LoveNumber' do 
    expect(number_to_love(42)).to be_a LoveNumber
  end


  context 'options' do 
    describe 'number_to_human operators' do 
      it 'should respect :precision' do 
        expect(number_to_love(0.4201, precision: 2).to_s).to eq "0.42"
      end

      
    end
  end
end
