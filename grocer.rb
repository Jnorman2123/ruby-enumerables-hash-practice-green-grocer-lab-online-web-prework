require 'pry'

def consolidate_cart(cart)
  final_hash = {}
  cart.each do|element_hash| 
    element_name = element_hash.keys[0]
    # element_stats = element_hash.values[0]
    
    if final_hash.has_key?(element_name)
      final_hash[element_name][:count] += 1 
    else 
      final_hash[element_name] = {
        count: 1, 
        price: element_hash[element_name][:price],
        clearance: element_hash[element_name][:clearance]
      }
    end 
  end 
  final_hash
end 

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item = coupon[:item]
    item_with_coupon = "#{item} W/COUPON"
    if cart.has_key?(item)
      if cart[item][:count] >= coupon[:num] && !cart.has_key?(item_with_coupon)
        cart[item_with_coupon] = {price: coupon[:cost] / coupon[:num], clearance: cart[item][:clearance], count: coupon[:num]}
      elsif cart[item][:count] >= coupon[:num] && cart.has_key?(item_with_coupon)
        cart[item_with_coupon][:count] += coupon[:num]
      end 
      cart[item][:count] -= coupon[:num]
    end 
  end 
  cart
end 


