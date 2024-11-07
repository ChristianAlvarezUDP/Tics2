import bcrypt from 'bcrypt';
import { addMessage, popMessages, checkUserAllPrivileges, checkUserAnyPrivileges } from './helperFunctions.js';
import { } from '../database/dbQueries.js';

export async function generatePasswordHash(req, res) {
  /*
  if (!req.session.loggedin) {
    res.redirect('/');
    return;
  }

  let isAdmin = await checkUserAnyPrivileges(req, ['Administrador']);

  if (!isAdmin) {
    res.redirect('/');
    return;
  }
  */

  const password = req.params.password;

  bcrypt.genSalt(10, function(err, salt) {
    bcrypt.hash(password, salt, function(err, hash) {
        console.log(hash, salt);
    });
  });

  res.redirect('/admin');
}

export async function loginUser(req, res) {

};

export const LogoutUser = (req, res) => {
  req.session.destroy((err) => {
    if (err) {
      console.error("Error al cerrar sesión:", err);
      addMessage(req, "Ocurrió un error al cerrar sesión", "error");
      res.redirect('/');
      return;
    }

    addMessage(req, 'Sesión cerrada exitosamente', 'success' );

    res.redirect('/');
  });
};
