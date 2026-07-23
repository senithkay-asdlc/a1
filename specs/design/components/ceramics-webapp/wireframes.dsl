// Handmade Ceramics Online Store — storefront + admin console

screen Catalog "Shoppers browse the ceramics catalog by category and keyword"
  navbar "Ceramics Co | Shop | Mugs | Bowls | Vases | Plates | Cart | Account"
  row
    heading "Handmade Ceramics"
    right
    search "Search products…"
    select "Sort: Newest"
  row
    badge "All (86)" info
    badge "Mugs (24)"
    badge "Bowls (18)"
    badge "Vases (20)"
    badge "Plates (24)"
  row
    card "Speckled Stoneware Mug | $28 | In stock"
    card "Hand-thrown Cereal Bowl | $34 | In stock"
    card "Ivory Bud Vase | $42 | Only 2 left"
  row
    card "Rustic Dinner Plate Set | $65 | In stock"
    card "Matte Blue Mug | $28 | Out of stock"
    card "Speckled Serving Bowl | $48 | In stock"
  button "View product" -> ProductDetail

screen ProductDetail "Shopper reviews one product and adds it to the cart"
  navbar "Ceramics Co | Shop | Mugs | Bowls | Vases | Plates | Cart | Account"
  breadcrumb "Shop / Mugs / Speckled Stoneware Mug"
  split 60/40
    left
      image "Speckled Stoneware Mug"
      heading "Speckled Stoneware Mug"
      text "Hand-thrown stoneware mug with a speckled glaze. Holds 12oz. Dishwasher safe."
      text "Category: Mugs · SKU: MUG-014"
      heading "You may also like"
      row
        card "Matte Blue Mug | $28"
        card "Terracotta Mug | $26"
    right
      card "$28"
        badge "In stock" success
        text "Quantity"
        select "1"
        button "Add to cart" primary -> Cart

screen Cart "Shopper reviews cart contents before checkout"
  navbar "Ceramics Co | Shop | Mugs | Bowls | Vases | Plates | Cart | Account"
  heading "Your Cart"
  table "Product | Unit price | Qty | Line total"
    row "Speckled Stoneware Mug | $28 | 2 | $56"
    row "Ivory Bud Vase | $42 | 1 | $42"
  row
    right
    text "Subtotal: $98 · Tax: $8.33 · Shipping: $6.00 · Total: $112.33"
  row
    right
    button "Continue shopping" -> Catalog
    button "Proceed to checkout" primary -> Checkout

screen Checkout "Shopper enters shipping and payment details and reviews the order"
  navbar "Ceramics Co | Shop | Mugs | Bowls | Vases | Plates | Cart | Account"
  heading "Checkout"
  split 60/40
    left
      heading "Shipping address"
      input "Full name"
      input "Address line 1"
      input "City"
      row
        input "State/Region"
        input "Postal code"
      select "Shipping method: Standard (3-5 days) — $6.00"
      heading "Payment"
      input "Card number"
      row
        input "Expiry"
        input "CVC"
    right
      card "Order summary"
        text "Speckled Stoneware Mug ×2 — $56"
        text "Ivory Bud Vase ×1 — $42"
        text "Subtotal: $98"
        text "Tax: $8.33"
        text "Shipping: $6.00"
        text "Total: $112.33"
        button "Place order" primary -> OrderConfirmation

screen OrderConfirmation "Shopper sees confirmation that the order was placed"
  navbar "Ceramics Co | Shop | Mugs | Bowls | Vases | Plates | Cart | Account"
  heading "Thank you for your order!"
  text "Order #10456 confirmed — a confirmation email is on its way."
  card "Order #10456 | $112.33 | Processing"
  row
    right
    button "View order history" -> OrderHistory
    button "Continue shopping" primary -> Catalog

screen OrderHistory "Registered customer reviews their past orders and status"
  navbar "Ceramics Co | Shop | Mugs | Bowls | Vases | Plates | Cart | Account"
  heading "My Orders"
  table "Order # | Date | Items | Total | Status" -> OrderConfirmation
    row "10456 | Mar 2 | 2 items | $112.33 | Processing"
    row "10391 | Feb 14 | 1 item | $42.00 | Delivered"
    row "10322 | Jan 30 | 3 items | $98.50 | Cancelled"
  heading "Saved addresses"
  card "Home | 12 River St, Springfield"
  button "Add address"

screen AdminProducts "Administrator manages the product catalog and stock"
  navbar "Ceramics Co Admin"
  sidebar "Products | Orders | Settings"
  row
    heading "Products"
    right
    button "Add product" primary -> AdminProductForm
  table "Product | Category | Price | Stock | Status" -> AdminProductForm
    row "Speckled Stoneware Mug | Mugs | $28 | 34 | Active"
    row "Matte Blue Mug | Mugs | $28 | 0 | Out of stock"
    row "Ivory Bud Vase | Vases | $42 | 2 | Active"

screen AdminProductForm "Administrator creates or edits a product and its stock level"
  navbar "Ceramics Co Admin"
  sidebar "Products | Orders | Settings"
  breadcrumb "Products / Speckled Stoneware Mug"
  heading "Edit Product"
  input "Name — Speckled Stoneware Mug"
  textarea "Description"
  row
    select "Category: Mugs"
    input "Price — 28.00"
  input "Stock quantity — 34"
  toggle "Active" active
  row
    right
    button "Cancel" -> AdminProducts
    button "Save product" primary -> AdminProducts

screen AdminOrders "Administrator reviews orders and updates their status"
  navbar "Ceramics Co Admin"
  sidebar "Products | Orders | Settings"
  heading "Orders"
  tabs "All | Processing | Shipped | Delivered | Cancelled"
  table "Order # | Customer | Items | Total | Status"
    row "10456 | J. Alvarez | 2 items | $112.33 | Processing"
    row "10451 | Guest | 1 item | $34.00 | Shipped"
    row "10448 | M. Chen | 3 items | $98.50 | Delivered"
  row
    right
    select "Update status: Shipped"
    button "Save" primary
