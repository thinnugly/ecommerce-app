const mongoose = require("mongoose");

const category = mongoose.model(
  "category",
  mongoose.Schema(
    {
      categoryName: {
        type: String,
        required: true,
        unique: true,
      },
      categoryDescription: {
        type: String,
        required: false,
      },
      categoryImage: {
        type: String,
      },
    },
    {
      toJSON: {
        transform: function(doc, ret) {
          ret.categoryId = ret._id.toString();
          delete ret._id;
          delete ret.__v;
        }
      }
    }
  )
);

module.exports = {
  category,
};
