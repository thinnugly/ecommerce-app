const usersService = require("../services/user.service");

exports.register = (req, res, next) => {
  usersService.register(req.body, (error, results) => {
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

exports.login = (req, res, next) => {
  const { email, password } = req.body;

  usersService.login({email, password}, (error, results) => {
    if (error) {
      return next(error);
    } else {
      return res.status(200).send({
        message: "Success",
        data: results,
      });
    }
  })
}


