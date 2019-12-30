require 'pry'
def find_item_by_name_in_collection(name, collection)
  i = 0 
  while i < collection.length do
    if collection[i][:item] == name
      return collection[i]
    end
    i += 1
  end
end
#collection is the array to search for 'name'. if name exists return the hash in collection. if not, return nil.
#
  # Implement me first!
  #
  # Consult README for inputs and outputs

def consolidate_cart(cart)
  i = 0
  cons_cart = [] #will be a new array that represents the cart with the item counts
  while i < cart.length do
    in_cart = find_item_by_name_in_collection(cart[i][:item],cons_cart)
    if in_cart != nil
      in_cart[:count] += 1
    else
      in_cart = {
        :item => cart[i][:item],
        :price => cart[i][:price],
        :clearance => cart [i][:clearance],
        :count => 1
      }
      cons_cart << in_cart
    end
    i += 1
  end
  cons_cart
end
#if 
  #it will iterate through array and count each item once and if cart[i][:item] exists it will increment the count
  #binding.pry
# Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.

def apply_coupons(cart, coupons)
 i = 0
  while i < coupons.length
     item = find_item_by_name_in_collection(coupons[i][:item],cart)
     coupon_item = "#{coupons[i][:item]} W/COUPON"
     cart_item_coupon = find_item_by_name_in_collection(coupon_item, cart)
     #binding.pry
     if item && item[:count] >= coupons[i][:num] #if its elgible for a coupon, apply it!
       if cart_item_coupon
          cart_item_coupon[:count] += coupons[i][:num]
          item[:count] -= coupons[i][:num]
       else
         cart_item_coupon = {
           :item => coupon_item,
           :price => coupons[i][:cost]/coupons[i][:num],
           :count => coupons[i][:num],
           :clearance => item[:clearance]
         }
         cart << cart_item_coupon
         item[:count] -= coupons[i][:num]
         #binding.pry
        end
      end
    i += 1
  end
 cart
end
# discount_hash = cons_cart[i]
    # discount_hash[:item] = "#{discount_hash[:item]} W/COUPON"
    # discount_hash[:price] = coupons[i][:cost]/coupons[i][:num]
    # discount_hash[:count] = coupons[i][:num]
    # cons_cart[i][:count] -= coupons[i][:num]
    # #cart[i][:count] -= coupons[i][:num]
  # if cons_cart[i][:item] == coupons[i][:item] #&& cons_cart[i][:count] == coupons[i][:num] #check to see if item has a coupon match
#write out the pseudocode logic chronologically.
# consolidate_cart method uses the find_item_by_name_in_collection method. 
#we just need to subtract the discounted items from the original item count in the consolidated_cart
# if the item is in the consolidated cart and the coupons array then we can apply the coupon
#i can do it in one big if compound statement!!
#check the count vs num

# Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart

def apply_clearance(cart)
  i = 0
  #binding.pry
  while i < cart.length do
    if cart[i][:clearance] == true
       cart[i][:price] = (cart[i][:price] - cart[i][:price]*0.20).round(2)
    end
    cart
    i += 1
  end
  cart
end

#binding.pry
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart

def checkout(cart, coupons)
  new_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(new_cart,coupons)
  clearance_cart = apply_clearance(couponed_cart)
    i = 0
    total = 0
    while i < couponed_cart.length
      total += (couponed_cart[i][:price]*couponed_cart[i][:count])
      i += 1
    end
  total
end

 # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
