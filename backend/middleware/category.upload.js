require('dotenv').config();

const { S3Client, PutObjectCommand } = require('@aws-sdk/client-s3');
const multer = require('multer');
const multerS3 = require('multer-s3');
const Path = require('path');

// Criando o cliente S3 com o SDK v3
const s3 = new S3Client({
  region: process.env.AWS_REGION,
  credentials: {
    accessKeyId: process.env.AWS_ACCESS_KEY_ID,
    secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY
  }
});

// Função de filtro de arquivo para Multer
const fileFilter = (req, file, callback) => {
  const acceptableExt = ['.png', '.jpg', '.jpeg'];
  if (!acceptableExt.includes(Path.extname(file.originalname).toLowerCase())) {
    return callback(new Error('Only .png, .jpg and .jpeg format allowed!'));
  }

  const fileSize = parseInt(req.headers['content-length']);
  if (fileSize > 5242880) {
    return callback(new Error('File size exceeds limit of 5MB.'));
  }

  callback(null, true);
};

// Configurando o Multer com o multer-s3 para usar o S3
const upload = multer({
  storage: multerS3({
    s3: s3,
    bucket: process.env.AWS_S3_BUCKET_NAME,
    key: function (req, file, cb) {
      cb(null, 'categories/' + Date.now() + '-' + file.originalname);
    },
  }),
  fileFilter: fileFilter,
  limits: { fileSize: 5242880 }, // 5MB
});

module.exports = upload.single('categoryImage');
