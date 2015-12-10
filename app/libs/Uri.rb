module URI
  module_function
  def encode(str)
    if str
      CFURLCreateStringByAddingPercentEscapes nil, str.to_s, "[]", ";=&,@", KCFStringEncodingUTF8
    end
  end
  def remove_whitespace(str)
    if str
      str.sub! ' ', '%20'
    end
  end
end