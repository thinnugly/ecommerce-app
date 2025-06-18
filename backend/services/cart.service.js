const { cart } = require("../models/cart.model");
const async = require("async");


async function addCart(params, callback) {
  if (!params.userId) {
    return callback(
      {
        message: "userId Required.",
      },
      ""
    );
  }

  try {
    const cartDB = await cart.findOne({ userId: params.userId });

    if (cartDB == null) {
      // Se o carrinho não existir, crie um novo
      const cartModel = new cart({
        userId: params.userId,
        products: params.products,
      });

      const response = await cartModel.save();
      return callback(null, response);
    } else if (cartDB.products.length == 0) {
      // Se o carrinho existir, mas estiver vazio, adicione os produtos
      cartDB.products = params.products;
      const updatedCart = await cartDB.save();
      return callback(null, updatedCart);
    } else {
      // Se o carrinho tiver produtos, adicione ou atualize conforme necessário
      for (const product of params.products) {
        let itemIndex = cartDB.products.findIndex(
          (p) => p.product.toString() === product.product.toString()
        );

        if (itemIndex === -1) {
          // Produto não encontrado, adicione-o
          cartDB.products.push({
            product: product.product,
            qty: product.qty,
          });
        } else {
          // Produto já existe, atualize a quantidade
          cartDB.products[itemIndex].qty += product.qty;
        }
      }

      const updatedCart = await cartDB.save();
      return callback(null, updatedCart);
    }
  } catch (error) {
    return callback(error);
  }
}

async function getCart(params, callback) {
  if (!params || !params.userId) {
    return callback(new Error('userId Required.'));
  }

  try {
    const response = await cart.findOne({ userId: params.userId })
      .populate({
        path: 'products',
        populate: {
          path: 'product',
          model: 'product',
          select: 'productName productPrice productSalePrice productImage',
          populate: {
            path: 'category',
            model: 'category',
            select: 'categoryName',
          },
        },
      });

    return callback(null, response);
  } catch (error) {
    console.error('Erro ao obter o carrinho:', error);
    return callback(error);
  }
}

async function removeCartItem(params, callback) {
  if (!params || !params.userId) {
    return callback(new Error('userId is required.'));
  }

  try {
    const cartDB = await cart.findOne({ userId: params.userId });
    if (!cartDB) {
      return callback(new Error('Cart not found.'));
    }

    if (params.productId && params.qty) {
      const { productId, qty } = params;

      if (cartDB.products.length === 0) {
        return callback(null, { status: 'empty', message: 'Cart is empty!' });
      }

      const itemIndex = cartDB.products.findIndex(p => p.product.toString() === productId);

      if (itemIndex === -1) {
        return callback(null, { status: 'invalid', message: 'Product not found in cart!' });
      }

      const product = cartDB.products[itemIndex];

      if (product.qty === qty) {
        cartDB.products.splice(itemIndex, 1); // Remove the product entirely
      } else if (product.qty > qty) {
        product.qty -= qty; // Reduce the quantity
      } else {
        return callback(null, { status: 'error', message: 'Enter a lower quantity.' });
      }

      await cartDB.save();
      return callback(null, { status: 'success', message: 'Cart updated successfully!' });

    } else {
      return callback(new Error('Product ID and quantity are required.'));
    }

  } catch (error) {
    console.error('Error removing product from cart:', error);
    return callback(error);
  }
}

async function clearCartByUserId(params, callback) {
  if (!params || !params.userId) {
    return callback(new Error('userId is required.'));
  }

  try {
    const result = await cart.findOneAndDelete({ userId: params.userId });
    return callback(null, result); 
  } catch (error) {
    console.error('Error removing cart:', error);
    return callback(error);
  }
}


module.exports = {
  addCart,
  getCart,
  removeCartItem,
  clearCartByUserId,
};
