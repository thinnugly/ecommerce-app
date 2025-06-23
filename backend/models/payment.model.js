const mongoose = require("mongoose");

const payment = mongoose.model(
    "payment",
    mongoose.Schema(
        {
            orderId: {
                type: mongoose.Schema.Types.ObjectId,
                ref: "order",
                required: true,
            },
            paypalOrderId: String,
            status: {
                type: String,
                enum: ["CREATED", "COMPLETED", "FAILED"],
                default: "CREATED",
            },
            payerEmail: String,
            payerID: String,
            transactionID: String,
            amount: Number,
            deliveryMethod: {
                type: String,
                enum: ["pickup", "delivery"],
                default: "pickup"
            },
            deliveryFee: { type: Number, default: 0 },
        },
        { timestamps: true }
    )
);

module.exports = {
    payment,
};
