const { user } = require("../models/user.model");
const bcrypt = require("bcryptjs")
const auth = require("../middleware/auth");

async function register(params, callback) {
  if (!params.email === undefined) {
    return callback(
      {
        message: "Email Required.",
      },
      ""
    );
  }

  let isUserExist = await user.findOne({email: params.email});
  if (isUserExist) {
    return callback(
      {
        message: "Email already registed.",
      },
      ""
    );
  }

  const salt = bcrypt.genSaltSync(10);
  params.password = bcrypt.hashSync(params.password, salt);

  const model = new user(params);
  model
    .save()
    .then((response) => {
      return callback(null, response);
    })
    .catch((error) => {
      return callback(error);
    });
}

async function login({email, password}, callback) {
  const userModel = await user.findOne({ email });

  if(userModel != null) {
    if(bcrypt.compareSync(password, userModel.password)) {
      const token = auth.generateAccessToken(userModel.toJSON());
      return callback(null, {...userModel.toJSON(), token});
    }else {
      return callback({
        message: "Invalid Email/Password"
      });
    }
  }else {
    return callback({
      message: "Invalid Email/Password"
    });
  }
}

module.exports = {
  login,
  register
}