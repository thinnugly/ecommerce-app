const { category } = require("../models/category.model");
const { MONGO_DB_CONFIG } = require("../config/app.config");

async function createCategory(params, callback) {
  if (!params.categoryName) {
    return callback(
      {
        message: "Category Name Required.",
      },
      ""
    );
  }

  const model = new category(params);
  model
    .save()
    .then((response) => {
      return callback(null, response);
    })
    .catch((error) => {
      return callback(error);
    });
}

async function getCategories(params, callback) {
  const categoryName = params.categoryName;
  var condition = categoryName
    ? {
        categoryName: { $regex: new RegExp(categoryName), $options: "i" },
      }
    : {};

  let perPage = Math.abs(params.pageSize) || MONGO_DB_CONFIG.PAGE_SIZE;
  let page = (Math.abs(params.page) || 1) - 1;

  // ex: totalRecord = 20, pageSize = 10, page = 1
  category
    .find(condition, "categoryName categoryImage")
    .limit(perPage)
    .skip(perPage * page)
    .then((response) => {
      return callback(null, response);
    })
    .catch((error) => {
      return callback(error);
    });
}

async function getCategoryBId(params, callback) {
  const categoryId = params.categoryId;

  category
    .findById(categoryId)
    .then((response) => {
      if (!response) callback("Not Found Category with Id: " + categoryId);
      else callback(null, response);
    })
    .catch((error) => {
      return callback(error);
    });
}

async function upadateCategory(params, callback) {
  const categoryId = params.categoryId;

  category
    .findByIdAndUpdate(categoryId, params, { useFindAndModify: false })
    .then((response) => {
      if (!response) callback("Not Found Category with Id: " + categoryId);
      else callback(null, response);
    })
    .catch((error) => {
      return callback(error);
    });
}

async function deleteCategory(params, callback) {
  const categoryId = params.categoryId;

  category
    .findByIdAndDelete(categoryId)
    .then((response) => {
      if (!response) callback("Not Found Category with Id: " + categoryId);
      else callback(null, response);
    })
    .catch((error) => {
      return callback(error);
    });
}

module.exports = {
  createCategory,
  getCategories,
  getCategoryBId,
  upadateCategory,
  deleteCategory,
};
