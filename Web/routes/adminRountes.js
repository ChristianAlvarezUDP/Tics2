import express from 'express';
import { popMessages } from '../controllers/helperFunctions.js'
import { loginUser, LogoutUser, generatePasswordHash } from '../controllers/adminController.js';

const router = express.Router();

router.get('/loginAdmin', (req, res) => {
  if (req.session.loggedin) {
    res.redirect('/admin');
    return;
  }
  
  const messages = popMessages(req);

  res.render('adminlogin', {alert_messages: messages});
});

router.post('/loginAdmin', loginUser);

router.get('/admin', LogoutUser);

router.get('/logout', LogoutUser);

router.get('/generatePassword/:password', generatePasswordHash);

export default router;
