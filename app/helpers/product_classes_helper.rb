module ProductClassesHelper
  def display_price(range, text, text2, text3 = "-")
    return text3 if range.blank?
    if range.max == range.min
      sprintf(text2, range.min)
    else
      sprintf(text, range.min, range.max)
    end
  end
end
