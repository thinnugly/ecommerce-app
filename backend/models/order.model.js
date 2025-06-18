const mongoose = require("mongoose");

const order = mongoose.model(
    "order",
    mongoose.Schema(
        {
            userId: {
                type: String,
                required: true,
            },
            products: [
                {
                    product: {
                        type: mongoose.Schema.Types.ObjectId,
                        ref: "product",
                        required: true,
                    },
                    amount: {
                        type: Number,
                        required: true,
                    },
                    qty: {
                        type: Number,
                        required: true,
                    }
                }
            ],
            grandTotal: {
                type: Number,
                required: true,
            },
            orderStatus: {
                type: String,
                enum: ["pending", "paid", "failed"],
                default: "pending",
            },
            transactionID: {
                type: String,
            },
        },
        {
            timestamps: true
        }
    )
);

module.exports = {
    order,
};
