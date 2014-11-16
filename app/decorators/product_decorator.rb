class ProductDecorator < Draper::Decorator
  delegate_all

  def price_in_dollars
    price.divmod(100).join('.')
  end

end
