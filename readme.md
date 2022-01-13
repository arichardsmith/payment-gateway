# Payment gateway bug reproduction

This is a basic demo of the payment gateway issue on the woocomerce "Customer Payment Page".

## Setup

Clone the repo then run `docker-compose up` to start the containers with [docker-compose](https://docs.docker.com/compose/).

This will load a wordpress install on `localhost:8888` with woocomerce, shopfront and the flywire gateway installed. It will also add some products and a test order.

## Reproducing the issue

Once everything is loaded head to <http://localhost:8888/checkout/order-pay/58/?pay_for_order=true&key=wc_order_2jw2UT4xADHU3> and log in with user `admin` and password `admin`. _If_ I've set everything up right you should get a payment page where the loader just spins after you click "Pay for order".

The payment gateway will still load if you go through the [checkout](http://localhost:8888/checkout/).

## Ideas

When I was trying to work this out on our own site, I ended up digging into the woocommerce checkout script and it looks like it handles the [checkout](https://github.com/woocommerce/woocommerce/blob/7ef18a587929e7c08cc9a54ce41522c41d228eda/plugins/woocommerce/legacy/js/frontend/checkout.js#L35) from different to the [customer payment form](https://github.com/woocommerce/woocommerce/blob/7ef18a587929e7c08cc9a54ce41522c41d228eda/plugins/woocommerce/legacy/js/frontend/checkout.js#L27). The checkout handler submits with AJAX and sets `window.location` with the redirected url, so the javascript excutes. But the customer payment form hits the server, so redirecting to a `javascript:` url doesn't work.

Hope this helps ¯\_(ツ)_/¯