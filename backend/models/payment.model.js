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
        },
        { timestamps: true }
    )
);

module.exports = {
    payment,
};
