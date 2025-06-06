const { relatedProduct } = require("../models/related-product.model");
const { product } = require("../models/product.model");

async function addRelatedProduct(params, callback) {
  if (!params.product) {
    return callback(
      {
        message: "Product Id Required.",
      },
      ""
    );
  }

  if (!params.relatedProduct) {
    return callback(
      {
        message: "Related Product Id Required.",
      },
      ""
    );
  }

  const model = new relatedProduct(params);
  model
    .save()
    .then(async (response) => {
      await product.findOneAndUpdate({
        _id: params.product
      }, {
        $addToSet: {
          "relatedProducts": model
        }
      });
      return callback(null, response);
    })
    .catch((error) => {
      return callback(error);
    });
}

async function removeRelatedProduct(params, callback) {
  const { productId, relatedProductId } = params;

  relatedProduct.findOneAndDelete({
    product: productId,
    relatedProduct: relatedProductId
  })
  .then(async (response) => {
    if (!response) return callback("Not Found Product with Id: " + productId);

    // Remove o ID do relacionamento do array relatedProducts no produto
    await product.findByIdAndUpdate(productId, {
      $pull: { relatedProducts: response._id }
    });

    return callback(null, response);
  })
  .catch((error) => {
    return callback(error);
  });
}

module.exports = {
  addRelatedProduct,
  removeRelatedProduct,
};
