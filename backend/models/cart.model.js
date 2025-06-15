const mongoose = require("mongoose");

const cart = mongoose.model(
  "cart",
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
          qty: {
            type: Number,
            required: true,
          }
        }
      ]
    },
    {
      toJSON: {
        transform: function (model, ret) {
          ret.cartId = ret._id.toString();
          delete ret._id;
          delete ret.__v;
        }
      }
    },
    {
      timestamps: true
    }
  )
);

module.exports = {
  cart,
};
