const { slider } = require("../models/slider.model");
const { MONGO_DB_CONFIG } = require("../config/app.config");

async function createSlider(params, callback) {
  if (!params.sliderName) {
    return callback(
      {
        message: "Slider Name Required.",
      },
      ""
    );
  }

  const model = new slider(params);
  model
    .save()
    .then((response) => {
      return callback(null, response);
    })
    .catch((error) => {
      return callback(error);
    });
}

async function getSliders(params, callback) {
  const sliderName = params.sliderName;
  var condition = sliderName
    ? {
      sliderName: { $regex: new RegExp(sliderName), $options: "i" },
      }
    : {};

  let perPage = Math.abs(params.pageSize) || MONGO_DB_CONFIG.PAGE_SIZE;
  let page = (Math.abs(params.page) || 1) - 1;

  // ex: totalRecord = 20, pageSize = 10, page = 1
  slider
    .find(condition, "sliderName sliderImage")
    .limit(perPage)
    .skip(perPage * page)
    .then((response) => {
      return callback(null, response);
    })
    .catch((error) => {
      return callback(error);
    });
}

async function getSliderBId(params, callback) {
  const sliderId = params.sliderId;

  slider
    .findById(sliderId)
    .then((response) => {
      if (!response) callback("Not Found Slider with Id: " + sliderId);
      else callback(null, response);
    })
    .catch((error) => {
      return callback(error);
    });
}

async function upadateSlider(params, callback) {
  const sliderId = params.sliderId;

  slider
    .findByIdAndUpdate(sliderId, params, { useFindAndModify: false })
    .then((response) => {
      if (!response) callback("Not Found Slider with Id: " + categoryId);
      else callback(null, response);
    })
    .catch((error) => {
      return callback(error);
    });
}

async function deleteSlider(params, callback) {
  const sliderId = params.sliderId;

  slider
    .findByIdAndDelete(sliderId)
    .then((response) => {
      if (!response) callback("Not Found Slider with Id: " + categoryId);
      else callback(null, response);
    })
    .catch((error) => {
      return callback(error);
    });
}

module.exports = {
  createSlider,
  getSliders,
  getSliderBId,
  upadateSlider,
  deleteSlider,
};
