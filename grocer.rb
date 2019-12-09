require 'pry'

def find_item_by_name_in_collection(name, collection)
  counter = 0 
  
  while counter < collection.length 
    if collection[counter][:item] == name 
      return collection[counter]
    end
    counter += 1 
  end 
end

def consolidate_cart(cart)
  new_cart = []
  counter = 0 
  
  while counter < cart.length 
  new_cart_item = find_item_by_name_in_collection(cart[counter][:item], new_cart)
    if new_cart_item != nil 
      new_cart_item[:count] += 1
      
    else 
      new_cart_item = {
        :item => cart[counter][:item],
        :price => cart[counter][:price],
        :clearance => cart[counter][:clearance],
        :count => 1 
      }
      new_cart << new_cart_item
    end
    counter += 1
  end
  new_cart
end 
  

def apply_coupons(cart, coupons)
  i = 0
  while i < coupons.count do
    coupon = coupons[i]
    item_with_coupon = find_item_by_name_in_collection(coupon[:item], cart)
    item_is_in_basket = !!item_with_coupon
    count_is_big_enough_to_apply = item_is_in_basket && item_with_coupon[:count] >= coupon[:num]
    if item_is_in_basket and count_is_big_enough_to_apply
      consolidated_cart(item_with_coupon, coupon, cart)
    end
    i += 1
  end
  cart
end

def apply_clearance(cart)
  counter = 0 
  while counter < cart.length
    if cart[counter][:clearance]
      cart[counter][:price] = (cart[counter][:price] - (cart[counter][:price] * 0.20)).round(2)
    end 
    counter += 1 
  end
  cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)
  
  total = 0 
  counter = 0 
  
  while counter < final_cart.length 
    total += final_cart[counter][:price] * final_cart[counter][:count]
    counter += 1 
  end 
  
  if total > 100 
    total -= (total * 0.10)
  end 
  total
end



