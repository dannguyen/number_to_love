require 'action_pack'
require 'number_to_love/love_number'
module NumberToLove

  def number_to_love(val, opts={})
    LoveNumber.new(val, opts)
  end

end


include NumberToLove



