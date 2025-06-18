const categoryController = require("../controllers/categories.controller");
const productController = require("../controllers/products.controller");
const userController = require("../controllers/users.controller");
const sliderController = require("../controllers/sliders.controller");
const relatedProductController = require("../controllers/related-product.controller");
const cartController = require("../controllers/cart.controller");
const orderController = require("../controllers/order.controller");
const { authenticationToken} = require("../middleware/auth");

const express = require("express");
const router = express.Router();

router.post("/category", categoryController.create);
router.get("/category", categoryController.findAll);
router.get("/category/:id", categoryController.findOne);
router.put("/category/:id", categoryController.update);
router.delete("/category/:id", categoryController.delete);

router.post("/product", productController.create);
router.get("/product", productController.findAll);
router.get("/product/:id", productController.findOne);
router.put("/product/:id", productController.update);
router.delete("/product/:id", productController.delete);

router.post("/register", userController.register);
router.post("/login", userController.login);

router.post("/slider", sliderController.create);
router.get("/slider", sliderController.findAll);
router.get("/slider/:id", sliderController.findOne);
router.put("/slider/:id", sliderController.update);
router.delete("/slider/:id", sliderController.delete);

router.post("/relatedProduct", relatedProductController.create);
router.delete("/relatedProduct/:productId/:relatedProductId", relatedProductController.delete);

router.post("/cart", [authenticationToken], cartController.create);
router.get("/cart", [authenticationToken], cartController.findAll);
router.delete("/cart", [authenticationToken], cartController.delete);
router.delete("/cart/clear", [authenticationToken], cartController.clearCartByUserId);

router.post("/order", [authenticationToken], orderController.createOrder);
router.get("/order", [authenticationToken], orderController.getPStatus);
router.post("/create-paypal/:orderId", [authenticationToken], orderController.createPaypal);
router.post("/capture-paypal/:paypalOrderId", [authenticationToken], orderController.capturePaypal);

router.get("/orders/payment-success", orderController.paymentSuccess);
router.get("/orders/payment-cancel",  orderController.paymentCancel);

module.exports = router;