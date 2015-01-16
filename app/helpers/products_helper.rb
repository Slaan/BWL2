module ProductsHelper

  # flattens the first layer, not recusive
  def low_fatten(aList)
    aList.reduce([]) {|accu, elem| accu + elem}
  end

  def single_support(x)
    trans_containing(x) / no_of_transactions
  end
  
  def support(x, y)
    if no_of_transactions == 0.0 then
      return 0.0
    end
    trans_containing(x.to_set.merge(y.to_set)) / no_of_transactions
  end

  def confidence(x, y)
    tc = trans_containing(x)
    if tc == 0.0 then
      return 0.0
    end
    trans_containing(x.to_set.merge(y.to_set)) / tc
  end

  def no_of_transactions
    Order.all.size.to_f
  end 

  def trans_containing(transaction_set)
    Order.all.reduce(0) do |accu, order|
      order.products.to_set.superset?(transaction_set.to_set) ? accu + 1 : accu
    end.to_f
  end

end
