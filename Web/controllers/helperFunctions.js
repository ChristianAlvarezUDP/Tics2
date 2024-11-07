import { getUserPrivileges } from '../database/dbQueries.js';

export function addMessage(req, message, type) {
    if (typeof req.session == 'undefined') {
        console.log("No hay sesion");
        return;
    }

    if (typeof req.session.alert_messages == 'undefined') {
        req.session.alert_messages = [];
    }

    req.session.alert_messages.push({'message': message, 'type': type});
}

export function clearMessages(req) {
    if (typeof req.session == 'undefined') {
        console.log("No hay sesion");
        return;
    }

    if (typeof req.session.alert_messages == 'undefined') {
        return;
    }

    req.session.alert_messages.length = 0;
}

export function getMessages(req) {
    if (typeof req.session == 'undefined') {
        console.log("No hay sesion");
        return [];
    }

    if (typeof req.session.alert_messages == 'undefined') {
        return [];
    }

    return req.session.alert_messages;
}

export function popMessages(req) {
    let messages = JSON.parse(JSON.stringify(getMessages(req)));
    clearMessages(req);
    return messages;
}

/** Evalua si el usuario actual tiene TODOS los permisos necesarios. Esto se verifica viendo los grupos del usuario en la base de datos.
 * @param {Object} req                 La request realizada por la pagina, contiene 'session'.
 * @param {Array}  requiredPrivileges  Una lista de los privilegios a evaluar.
 */
export async function checkUserAllPrivileges(req, requiredPrivileges) {
    let result = false;

    const query = new Promise((resolve, reject) => {
        getUserPrivileges(req.session.username, (err, res) => {
            if(err) {
                return reject("db", `${err.message}`);
            }

            result = requiredPrivileges.every(val => res.map((row) => { return row['name_group']; }).includes(val));

            resolve();
        });
    });

    await query;

    return result;
}
  
/** Evalua si el usuario actual tiene ALGUNO de los permisos necesarios. Esto se verifica viendo los grupos del usuario en la base de datos.
 * @param {Object} req                 La request realizada por la pagina, contiene 'session'.
 * @param {Array}  requiredPrivileges  Una lista de los privilegios a evaluar.
 */
export async function checkUserAnyPrivileges(req, requiredPrivileges) {
    let result = false;

    const query = new Promise((resolve, reject) => {
        getUserPrivileges(req.session.username, (err, res) => {
            if(err) {
                return reject("db", `${err.message}`);
            }
            
            result = requiredPrivileges.some(val => res.map((row) => { return row['name_group']; }).includes(val));

            resolve();
        });
    });

    await query;

    return result;
}