import Database from './dbControl.js';


/** Llama a la funcion 'Callback' con la id de base de datos del cliente con la identificacion dada.
 * @param {Int}              id       Identificacion legal del cliente, puede ser un Rut, Pasaporte, etc.
 * @param {Int}              number_1 Primer numero de celular/telefono del cliente.
 * @param {Int}              number_2 Segundo numero de celular/telefono del cliente.
 * @param {CallableFunction} callback Funcion a la cual se llamara, debe tener 2 parametros "Error" y "Resultado".
 */
export function getUserID(id, number_1, number_2, callback) {
    let dbInstance = Database.getInstance();

    // TODO: Handle multiple numbers
    dbInstance.query("SELECT id FROM client WHERE REPLACE(REPLACE(legal_id, '.', ''), '-', '') = ? AND number_1 = ?", [id, number_1], callback);
}

export function getUserPrivileges(email, callback) {

}

export function getAuditor(rut, callback) {
    let dbInstance = Database.getInstance();

    dbInstance.query("SELECT * FROM subus.auditor WHERE rut = '21.189.168-8'", [], callback);
}

export function addAuditor(rut, nombre, callback) {
    let dbInstance = Database.getInstance();

    dbInstance.query("INSERT INTO subus.auditor (rut, nombre) VALUES ($1, $2)", [rut, nombre], callback);
}