const { product } = require("../models/product.model");
const { category } = require("../models/category.model");
const { MONGO_DB_CONFIG } = require("../config/app.config");

async function createProduct(params, callback) {
  if (!params.productName) {
    return callback(
      {
        message: "Product Name Required.",
      },
      ""
    );
  }

  if (!params.category) {
    return callback(
      {
        message: "Category Required.",
      },
      ""
    );
  }

  const model = new product(params);
  model
    .save()
    .then((response) => {
      return callback(null, response);
    })
    .catch((error) => {
      return callback(error);
    });
}

async function getProducts(params, callback) {
  const productName = params.productName;
  const categoryId = params.categoryId;

  var condition = {};
  if (productName) {
    condition["productName"] = {
      $regex: new RegExp(productName), $options: "i"
    };
  }

  if (categoryId) {
    condition["category"] = categoryId;
  }

  let perPage = Math.abs(params.pageSize) || MONGO_DB_CONFIG.PAGE_SIZE;
  let page = (Math.abs(params.page) || 1) - 1;

  // ex: totalRecord = 20, pageSize = 10, page = 1
  product
    .find(condition, "productName productShortDescription productPrice productSalePrice productImage productSKU productType stockStatus createdAt updatedAt")
    .sort(params.sort)
    .populate("category", "categoryName categoryImage")
    .limit(perPage)
    .skip(perPage * page)
    .then((response) => {
      return callback(null, response);
    })
    .catch((error) => {
      return callback(error);
    });
}

async function getProductBId(params, callback) {
  const productId = params.productId;

  product
    .findById(productId)
    .populate("category", "categoryName categoryImage")
    .then((response) => {
      if (!response) callback("Not Found Product with Id: " + productId);
      else callback(null, response);
    })
    .catch((error) => {
      return callback(error);
    });
}

async function upadateProduct(params, callback) {
  const productId = params.productId;

  product
    .findByIdAndUpdate(productId, params, { useFindAndModify: false })
    .then((response) => {
      if (!response) callback("Not Found Product with Id: " + productId);
      else callback(null, response);
    })
    .catch((error) => {
      return callback(error);
    });
}

async function deleteProduct(params, callback) {
  const productId = params.productId;

  product
    .findByIdAndDelete(productId)
    .then((response) => {
      if (!response) callback("Not Found Product with Id: " + productId);
      else callback(null, response);
    })
    .catch((error) => {
      return callback(error);
    });
}

module.exports = {
  createProduct,
  getProducts,
  getProductBId,
  upadateProduct,
  deleteProduct,
};
