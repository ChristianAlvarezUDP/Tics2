// controllers/userController.js
import { addMessage, popMessages, checkUserAnyPrivileges } from './helperFunctions.js';
import { getUserID } from '../database/dbQueries.js';

const USE_USER_ID_FOR_PASSWORD = true;

export async function loginUser(req, res) {
  if (req.session.loggedin) {
    const isAdmin =  await checkUserAnyPrivileges(req, ['Administrador', 'Veterinario']);

    if (isAdmin) {
      res.redirect('/admin');
      return;
    }
    else {
      res.redirect('/');
      return;
    }
  }

  let { rut, password } = req.body;

  // TODO: enforce rut format
  rut = rut.replace(/\./g, '').replace(/\-/g, '')

  let startIndex = rut.length - 1 - password.length;

  let extractedString = rut.slice(startIndex, startIndex + password.length);

  console.log(rut, extractedString, password)

  if (extractedString !== password) {
      addMessage(req, "Credenciales incorrectas", "error");
      res.redirect('/login');
      return;
  }

  getUserIDFromId(rut, (err, result) => {
    if (err) {
      console.error("Error");
      return;
    }

    if (!result || result.length < 1) {
      addMessage(req, "Credenciales incorrectas", "error");
      res.redirect('/login');
      return;
    }
    
    req.session.loggedin = true;
    req.session.username = rut;
    req.session.userId = result[0]['id'];
    req.session.isAdmin = false;
    
    res.redirect('/usuario');
  })
};


export function getUserData(req, res) {
  if (!req.session.loggedin) {
    res.redirect('/');

    return;
  }
};

export const LogoutUser = (req, res) => {
  req.session.destroy((err) => {
    if (err) {
      console.error("Error al cerrar sesión:", err);
      res.redirect('/');
      return;
    }

    res.redirect('/');
  });
};
