import express from 'express';
const router = express.Router();

router.get('/about', (req, res) => {
  res.render('About');
});

export default router;