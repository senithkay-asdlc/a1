# Design: Handmade Ceramics Online Store

## 1. Overview

The Handmade Ceramics Online Store is a small e-commerce system that lets
shoppers browse a catalog of handmade ceramic products, manage a shopping
cart, and complete checkout with shipping and payment details. Registered
customers can track their orders and manage saved addresses; a store
administrator manages the product catalog, stock levels, and order
fulfillment. The system is composed of a single customer/admin-facing web
application backed by a single API service that owns all catalog, cart,
order, and account data.

## 2. Components

- **ceramics-webapp** (`web-application`) — the storefront single-page
application used by guests, registered customers, and the store
administrator (role-gated views) to browse products, manage the cart,
check out, view order history, and manage the catalog/orders.
- **ceramics-api** (`service`) — the backend API owning the product catalog,
cart, checkout/order, and customer account data; integrates with the
payment provider for checkout and the email provider for order
confirmations.

## 3. Capabilities

### ceramics-webapp

- **Catalog browsing** — category/keyword browsing, sorting/filtering,
product detail pages with related products (FR-1–FR-6).
- **Cart management** — add/update/remove items, live subtotal/tax/shipping/
total recalculation, out-of-stock prevention (FR-7–FR-13).
- **Checkout flow** — shipping info, shipping method selection, payment
entry, order summary review, order confirmation display (FR-14–FR-20,
FR-23).
- **Account management** — registration, login/logout, order history,
saved addresses (FR-24–FR-27).
- **Admin console (role-gated)** — product CRUD, stock updates, order list/
detail, order status updates, visible only to the administrator role
(FR-28–FR-32).

### ceramics-api

- **Catalog service** — CRUD for products, categories, search/sort/filter,
stock tracking (FR-1–FR-6, FR-28, FR-29).
- **Cart service** — persistent cart per guest session / per customer
account, quantity and stock validation, price/tax/shipping computation
(FR-7–FR-13).
- **Checkout &amp; order service** — creates orders atomically with payment
confirmation, decrements stock, triggers confirmation email, supports
guest checkout (FR-14–FR-23).
- **Account service** — registration/login (via Thunder), saved addresses,
order history (FR-24–FR-27).
- **Order management (admin)** — list/detail/status-update endpoints
restricted to the administrator role (FR-30–FR-32).

## 4. Data model

- **Product** — id, name, description, price, category, images\[\],
stockQuantity, active, createdAt, updatedAt.
- **Category** — id, name, slug.
- **Cart** — id, ownerId (customer id or guest session id), items\[\]
(productId, quantity, unitPriceSnapshot), subtotal, tax, shippingEstimate,
total, updatedAt.
- **Order** — id, customerId (nullable for guest), items\[\] (productId,
name snapshot, unitPrice, quantity), shippingAddress, shippingMethod,
subtotal, tax, shippingCost, total, paymentStatus, orderStatus
(processing/shipped/delivered/cancelled), createdAt.
- **Address** — id, customerId, name, line1, line2, city, region, postalCode,
country, phone.
- **Customer** — id (from Thunder subject), email, name, addresses\[\].

Relationships: a Customer has many Addresses and Orders; an Order has many
OrderItems referencing a Product at time of purchase; a Cart has many
CartItems referencing a Product; a Product belongs to a Category.

## 5. Roles &amp; access

- **Guest** — browse catalog, manage a session-scoped cart, complete guest
checkout. No authentication required.
- **Customer** — everything a Guest can do, plus a persistent cart tied to
their account, order history, and saved addresses. Authenticated via
Thunder.
- **Store Administrator** — catalog management (create/update/deactivate
products, update stock) and order management (view/update order status).
Authenticated via Thunder; authorized by role/group membership.

## 6. Interactions

- `ceramics-webapp` → `ceramics-api`: all catalog, cart, checkout, account,
and admin operations over HTTPS/JSON.
- `ceramics-webapp` → `user-auth` (Thunder): OIDC Authorization Code + PKCE
sign-in/sign-up for customers and the administrator.
- `ceramics-api` → `user-auth` (Thunder): validates the caller's identity via
the platform gateway (JWT validation + identity headers); resolves the
caller's role from `X-User-Groups`.
- `ceramics-api` → `payment-provider` (external): charges the shopper's
payment method during checkout.
- `ceramics-api` → `email-provider` (external): sends order confirmation
emails after successful checkout.

## 7. Data flow

1. **Browse &amp; add to cart**: shopper loads `ceramics-webapp` → fetches
 catalog listings/detail from `ceramics-api` → adds a product to the cart;
 `ceramics-api` validates requested quantity against current stock and
 returns the updated cart totals.
2. **Checkout**: shopper reviews the cart → proceeds to checkout → submits
 shipping info and a shipping method → submits payment details;
 `ceramics-api` charges the amount via `payment-provider`; on success it
 creates the Order, decrements stock, and triggers a confirmation email via
 `email-provider`; on payment failure no Order is created and the shopper
 sees an error.
3. **Order confirmation &amp; tracking**: shopper sees an order confirmation
 with an order number; a registered customer can later view the order and
 its status in their order history.
4. **Catalog &amp; order administration**: the administrator signs in via
 Thunder, and uses the admin console in `ceramics-webapp` to create/update
 products, adjust stock, and update order statuses in `ceramics-api`.