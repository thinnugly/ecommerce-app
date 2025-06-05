const slidersService = require("../services/sliders.service");
const upload = require("../middleware/slider.upload");

exports.create = (req, res, next) => {
  upload(req, res, function (err) {
    if (err) {
      next(err);
    } else {
      const path =
        req.file != undefined ? req.file.path.replace(/\\/g, "/") : "";
      var model = {
        sliderName: req.body.sliderName,
        sliderDescription: req.body.sliderDescription,
        sliderImage: path != "" ? "/" + path : "",
      };

      slidersService.createSlider(model, (error, results) => {
        if (error) {
          return next(error);
        } else {
          return res.status(200).send({
            message: "Success",
            data: results,
          });
        }
      });
    }
  });
};

exports.findAll = (req, res, next) => {
  var model = {
    sliderName: req.query.sliderName,
    pageSize: req.query.pageSize,
    page: req.query.page,
  };

  slidersService.getSliders(model, (error, results) => {
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

exports.findOne = (req, res, next) => {
  var model = {
    sliderId: req.params.id,
  };

  slidersService.getSliderBId(model, (error, results) => {
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

exports.update = (req, res, next) => {
  upload(req, res, function (err) {
    if (err) {
      next(err);
    } else {
      const path =
        req.file != undefined ? req.file.path.replace(/\\/g, "/") : "";
      var model = {
        sliderId: req.params.id,
        sliderName: req.body.sliderName,
        sliderDescription: req.body.sliderDescription,
        sliderImage: path != "" ? "/" + path : "",
      };

      slidersService.upadateSlider(model, (error, results) => {
        if (error) {
          return next(error);
        } else {
          return res.status(200).send({
            message: "Success",
            data: results,
          });
        }
      });
    }
  });
};

exports.delete = (req, res, next) => {
  var model = {
    sliderId: req.params.id,
  };

  slidersService.deleteSlider(model, (error, results) => {
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
