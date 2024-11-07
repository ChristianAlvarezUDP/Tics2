import path from 'path';
import multer from 'multer';
import fs from 'fs';
import { dirname } from 'path';
import { } from '../database/dbQueries.js';
import { addMessage, checkUserAnyPrivileges, checkUserAllPrivileges } from './helperFunctions.js';
import { fileURLToPath } from 'url';
import { error } from 'console';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);
const basePath = path.join(__dirname, '../');

function getFormattedDate(date) {
  let month = '' + (date.getMonth() + 1);
  let day = '' + date.getDate();
  let year = date.getFullYear();

  if (month.length < 2) month = '0' + month;
  if (day.length < 2) day = '0' + day;

  return [year, month, day].join('');
};

export const UploadView = (req, res) => {

}

/** 
 * Función de carga que permite a los usuarios subir archivos.
 * Crea un directorio en función de la fecha actual si no existe.
 * Utiliza 'multer' para manejar la subida del archivo y manejar cualquier error.
 * Si no hay errores y se sube un archivo, inserta una fila en la base de datos para el archivo,
 * y luego termina la respuesta con un mensaje de éxito.
 *
 * @param {Object} req Objeto de solicitud HTTP. Se espera que este objeto contenga 'file' 
 *                     como una propiedad que representa el archivo a subir.
 * @param {Object} res Objeto de respuesta HTTP utilizado para enviar la respuesta al cliente.
 */
export const Upload = (req, res) => {

};

/** 
 * Función de descarga que permite a los usuarios descargar archivos utilizando su ID.
 * Primero, obtiene la ruta del archivo usando su ID. Si se produce un error durante esta acción,
 * se muestra un mensaje de error. Si no se encuentra el archivo correspondiente a la ID dada,
 * se envía una respuesta con estado 404. Si el archivo existe, se establece el encabezado de 
 * 'Content-Disposition' con el nombre original del archivo para la respuesta y se envía el archivo.
 *
 * @param {Object} req Objeto de solicitud HTTP. Se espera que este objeto contenga 
 *                     'params' con una propiedad 'fileid' que representa el ID del archivo a descargar.
 * @param {Object} res Objeto de respuesta HTTP utilizado para enviar la respuesta al cliente.
 */
export const Download = async (req, res) => {

};

export const ShowFile = async (req, res) => {

};

function handleFiles(req, res, err, result, download=true) {

}

export const Delete = async (req, res) => {

};