# Requirements Specification: Handmade Ceramics Online Store

## 1. Overview

This project is an online store dedicated to selling handmade ceramics. The
store allows shoppers to browse a catalog of ceramic products (mugs, bowls,
vases, plates, and other handcrafted pieces), add items to a shopping cart,
and complete a purchase through a checkout process. The goal is to provide a
simple, reliable, and pleasant shopping experience for customers, while
giving the store's staff the ability to manage products and view orders.

## 2. Actors

- **Shopper (Guest)**: A visitor browsing the catalog without an account.
- **Customer (Registered Shopper)**: A shopper who has created an account,
can save cart contents across sessions, and can view their order history.
- **Store Administrator**: A staff member who manages the product catalog,
inventory, and views/manages orders placed by customers.

## 3. Functional Requirements

### 3.1 Product Catalog

- FR-1: The system shall display a catalog of handmade ceramic products,
each with a name, description, price, images, category (e.g., mugs,
bowls, vases, plates), and stock availability.
- FR-2: The system shall allow shoppers to browse products by category.
- FR-3: The system shall allow shoppers to search products by keyword
(e.g., name or description).
- FR-4: The system shall allow shoppers to view a detailed product page
showing all product information, additional images, and related/similar
products.
- FR-5: The system shall indicate when a product is out of stock and
prevent it from being added to the cart in that case.
- FR-6: The system shall allow sorting and/or filtering of catalog listings
(e.g., by price, category, newest).

### 3.2 Shopping Cart

- FR-7: The system shall allow shoppers to add a product (with a chosen
quantity) to their shopping cart.
- FR-8: The system shall allow shoppers to view the contents of their cart,
including product details, quantity, unit price, and line/total price.
- FR-9: The system shall allow shoppers to update the quantity of an item
in the cart or remove an item from the cart.
- FR-10: The system shall recalculate the cart subtotal, applicable taxes,
shipping estimate, and total whenever the cart contents change.
- FR-11: The system shall persist the cart for a guest shopper for the
duration of their browser session at minimum.
- FR-12: The system shall persist the cart for a registered customer across
sessions and devices (i.e., associated with their account).
- FR-13: The system shall prevent adding more of a product to the cart than
is currently available in stock.

### 3.3 Checkout

- FR-14: The system shall allow a shopper to proceed from cart to checkout.
- FR-15: The system shall collect shipping information (name, address,
contact details) during checkout.
- FR-16: The system shall allow the shopper to select a shipping method,
displaying associated cost and estimated delivery time, if applicable.
- FR-17: The system shall collect payment information and process payment
securely during checkout.
- FR-18: The system shall display an order summary (items, quantities,
prices, shipping, taxes, and total) for the shopper to review before
confirming the order.
- FR-19: The system shall create an order record upon successful payment,
and shall not create an order if payment fails.
- FR-20: The system shall display an order confirmation to the shopper
after a successful checkout, including an order number/reference.
- FR-21: The system shall send an order confirmation notification (e.g.,
email) to the shopper after a successful checkout.
- FR-22: The system shall decrement product stock levels upon successful
order placement.
- FR-23: The system shall allow a guest shopper to check out without
creating an account (guest checkout).

### 3.4 Customer Accounts

- FR-24: The system shall allow a shopper to register for an account using
an email address and password (or supported identity provider).
- FR-25: The system shall allow a registered customer to log in and log
out.
- FR-26: The system shall allow a registered customer to view their past
orders and order status.
- FR-27: The system shall allow a registered customer to view and update
their saved shipping addresses and contact information.

### 3.5 Catalog &amp; Order Management (Administration)

- FR-28: The system shall allow a store administrator to create, update,
and remove (or deactivate) products in the catalog.
- FR-29: The system shall allow a store administrator to update product
stock levels.
- FR-30: The system shall allow a store administrator to view a list of
orders and the details of an individual order.
- FR-31: The system shall allow a store administrator to update the status
of an order (e.g., processing, shipped, delivered, cancelled).
- FR-32: The system shall restrict catalog and order management functions
to authenticated users with the administrator role.

## 4. Non-Functional Requirements

- NFR-1 (Usability): The storefront shall be usable on both desktop and
mobile-sized browser viewports.
- NFR-2 (Performance): Catalog listing and product detail pages shall load
within 2 seconds under normal load conditions.
- NFR-3 (Security): All payment and personal information shall be
transmitted over encrypted connections (HTTPS/TLS). Passwords shall never
be stored in plain text.
- NFR-4 (Security): Only authenticated administrators shall be able to
access catalog and order management functions.
- NFR-5 (Reliability): Order and payment processing shall be consistent —
a customer shall never be charged without a corresponding order being
recorded, and shall never have an order recorded without a corresponding
successful payment.
- NFR-6 (Availability): The storefront shall be available to shoppers
during standard e-commerce traffic conditions, including brief periods of
elevated load (e.g., promotions).
- NFR-7 (Data Integrity): Stock levels shall remain accurate and consistent
even when multiple shoppers attempt to purchase the same limited-stock
item concurrently.
- NFR-8 (Accessibility): Core storefront flows (browse, cart, checkout)
shall follow basic web accessibility practices (semantic HTML, sufficient
color contrast, keyboard navigability).

## 5. Out of Scope

- Multi-vendor marketplace functionality (this store sells a single
seller's handmade ceramics catalog).
- In-person / point-of-sale integration.
- Subscription or recurring-order billing.
- Advanced loyalty/rewards programs.

## 6. Assumptions

- Payment processing will be handled via integration with an external
payment provider; the system itself does not need to implement raw
card-processing/PCI vaulting.
- Shipping cost calculation may rely on a simplified model (e.g., flat
rate or weight/zone-based estimate) rather than live carrier-rate
integration, unless otherwise specified.
- A single default currency is used for pricing and checkout.

## 7. Glossary

- **Catalog**: The collection of ceramic products available for purchase.
- **Cart**: The set of products and quantities a shopper intends to
purchase, prior to checkout.
- **Checkout**: The process of collecting shipping and payment information
and finalizing an order.
- **Order**: A confirmed purchase record created after successful payment.
- **SKU**: Stock keeping unit — a unique identifier for a distinct product
(and variant, if applicable).

