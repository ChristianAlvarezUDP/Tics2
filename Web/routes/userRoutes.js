// routes/userRoutes.js
import express from 'express';
import { popMessages } from '../controllers/helperFunctions.js'
import { loginUser, getUserData, LogoutUser } from '../controllers/userController.js';
const router = express.Router();

// Ruta de inicio de sesión (GET)
router.get('/login', (req, res) => {
  if (req.session.loggedin) {
    res.redirect('/');
    return;
  }

  const messages = popMessages(req);

  res.render('login', { alert_messages: messages });
});

// Ruta de inicio de sesión (POST)
router.post('/login', loginUser);

router.get('/usuario', getUserData);

router.get('/logout', LogoutUser);

export default router;
