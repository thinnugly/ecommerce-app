const { cart } = require("../models/cart.model");
const { order } = require("../models/order.model");

async function createOrderFromCart(params, callback) {
    try {
        const cartM = await cart.findOne({ userId: params.userId }).populate("products.product");

        if (!cartM || cartM.products.length === 0) {
            return callback(new Error("Carrinho vazio ou não encontrado"));
        }

        // Calcular o total
        let products = [];
        let grandTotal = 0;

        cartM.products.forEach(product => {
            const salePrice = product.product.productSalePrice;
            const regularPrice = product.product.productPrice;
            const qty = product.qty;

            const amount = (salePrice > 0) ? salePrice : regularPrice;

            products.push({
                product: product.product._id,
                qty,
                amount
            });

            grandTotal += amount * qty;
        });


        // Criar o pedido
        const orderM = new order({
            userId: params.userId,
            products: products,
            orderStatus: "pending",
            grandTotal,
        });

        await orderM.save();

        return callback(null, orderM);
    } catch (err) {
        return callback(err);
    }
}

module.exports = { createOrderFromCart };
