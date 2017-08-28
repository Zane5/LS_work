class InvoiceEntery
  #attr_reader :quantity, :product_name
  attr_accessor :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent nagative quantities from being set
    #quantity = updated_count if updated_count >= 0
    self.quantity = updated_count if updated_count >= 0
  end
end

i = InvoiceEntery.new('Joe', 1)
puts i.update_quantity(2)
