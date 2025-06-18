const createOrderFromCartService = require("../services/create-order-from-cart.service");
const {
  createPaypalOrder,
  capturePaypalOrder,
  getPaymentStatus
} = require("../services/order.service");

exports.createOrder = (req, res, next) => {
  var model = {
    userId: req.user.data.userId,
  };

  createOrderFromCartService.createOrderFromCart(model, (error, results) => {
    if (error) {
      return next(error);
    }
    return res.status(200).send({
      message: "Success",
      data: results,
    });
  });
};

exports.createPaypal = async (req, res) => {
  try {
    const paypalOrder = await createPaypalOrder(req.params.orderId);

    const approvalUrl = paypalOrder.links.find(
      (link) => link.rel === "approve"
    ).href;

    const paypalOrderId = paypalOrder.id;

    res.json({ approvalUrl, paypalOrderId });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};


exports.capturePaypal = async (req, res) => {
  try {
    const status = await capturePaypalOrder(req.params.paypalOrderId);
    res.json({ status });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

exports.paymentSuccess = async (req, res) => {
  try {
    const paypalOrderId = req.query.paypalOrderId || req.query.token;
    if (!paypalOrderId) {
      return res.status(400).send(`
        <html>
          <head><title>Erro</title></head>
          <body style="font-family: sans-serif; text-align: center; margin-top: 50px;">
            <svg width="80" height="80" viewBox="0 0 24 24" fill="none" stroke="#d32f2f" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <circle cx="12" cy="12" r="10" />
              <line x1="15" y1="9" x2="9" y2="15" />
              <line x1="9" y1="9" x2="15" y2="15" />
            </svg>
            <h1 style="color: red;">Token ausente</h1>
            <p>Não foi possível identificar o pagamento.</p>
          </body>
        </html>
      `);
    }

    const status = await capturePaypalOrder(paypalOrderId);

    return res.send(`
      <html>
        <head>
          <title>Pagamento Concluído</title>
          <meta http-equiv="refresh" content="5;url=meuapp://payment-success" />
          <style>
            body { font-family: sans-serif; text-align: center; margin-top: 50px; background: #f4f4f4; }
            h1 { color: #2e7d32; }
            p { font-size: 18px; }
          </style>
        </head>
        <body>
          <svg width="80" height="80" viewBox="0 0 24 24" fill="none" stroke="#2e7d32" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M20 6L9 17l-5-5" />
          </svg>
          <h1>Pagamento realizado com sucesso!</h1>
          <p>Status: <strong>${status}</strong></p>
          <p>Você será redirecionado para o app em instantes...</p>
        </body>
      </html>
    `);
  } catch (err) {
    console.error(err);
    return res.status(500).send(`
      <html>
        <head><title>Erro</title></head>
        <body style="font-family: sans-serif; text-align: center; margin-top: 50px;">
          <svg width="80" height="80" viewBox="0 0 24 24" fill="none" stroke="#d32f2f" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="12" cy="12" r="10" />
            <line x1="15" y1="9" x2="9" y2="15" />
            <line x1="9" y1="9" x2="15" y2="15" />
          </svg>
          <h1 style="color: red;">Erro ao capturar pagamento</h1>
          <p>Tente novamente mais tarde.</p>
        </body>
      </html>
    `);
  }
};


exports.paymentCancel = (req, res) => {
  res.send(`
    <html>
      <head>
        <title>Pagamento Cancelado</title>
        <style>
          body { font-family: sans-serif; text-align: center; margin-top: 50px; background: #fff3f3; }
          h1 { color: #d32f2f; }
          p { font-size: 18px; }
        </style>
      </head>
      <body>
        <svg width="80" height="80" viewBox="0 0 24 24" fill="none" stroke="#d32f2f" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <circle cx="12" cy="12" r="10" />
          <line x1="15" y1="9" x2="9" y2="15" />
          <line x1="9" y1="9" x2="15" y2="15" />
        </svg>
        <h1>Pagamento cancelado</h1>
        <p>Você cancelou o pagamento ou fechou a janela.</p>
        <p>Se desejar, volte ao app para tentar novamente.</p>
      </body>
    </html>
  `);
};

exports.getPStatus = async (req, res) => {
  const model = {
    userId: req.user.data.userId,
    orderId: req.query.orderId,
  };

  if (!model.orderId) {
    return res.status(400).json({ error: 'orderId é obrigatório' });
  }

  try {
    const payment = await getPaymentStatus(model);

    if (!payment) {
      return res.status(404).json({ error: 'Pagamento não encontrado para este pedido de ordem' });
    }

    res.json({ paymentStatus: payment.status });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};



