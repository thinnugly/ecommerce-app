const mongoose = require("mongoose");

const relatedProduct = mongoose.model(
  "relatedProduct",
  mongoose.Schema(
    {
      product: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "product",
      },
      relatedProduct: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "product",
      }
    },
    {
      toJSON: {
        transform: function(doc, ret) {
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
  relatedProduct,
};
