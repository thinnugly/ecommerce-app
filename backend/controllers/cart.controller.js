const cartService = require("../services/card.service");


exports.create = (req, res, next) => {
  var model = {
    userId: req.user.data.userId,
    products: req.body.products,
  };

  cartService.addCart(model, (error, results) => {
    if(error) {
      return next(error);
    }
    return res.status(200).send({
      message: "Success",
      data: results,
    });
  });
};

exports.findAll = (req, res, next) => {
  cartService.getCart({ userId: req.user.data.userId }, (error, results) => {
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
  var model = {
    userId: req.user.data.userId,
    productId: req.body.productId,
    qty: req.body.qty,
  };

  cartService.removeCartItem(model, (error, results) => {
    if(error) {
      return next(error);
    }
    return res.status(200).send({
      message: "Success",
      data: results,
    });
  });
};



