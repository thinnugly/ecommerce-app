const relatedProductService = require("../services/related-products.service");
const upload = require("../middleware/product.upload");

exports.create = (req, res, next) => {
  relatedProductService.addRelatedProduct(req.body, (error, results) => {
    if (error) {
      return next(error);
    } else {
      return res.status(200).send({
        message: "Success",
        data: results,
      });
    }
  });
};


exports.delete = (req, res, next) => {
  const params = {
    productId: req.params.productId,
    relatedProductId: req.params.relatedProductId,
  };

  relatedProductService.removeRelatedProduct(params, (error, result) => {
    if (error) {
      return next(error);
    } else {
      return res.status(200).json({
        message: "Success",
        data: result,
      });
    }
  });
};


