import pkg from 'pg';
const { Pool } = pkg;
import { config } from './config.mjs';

class Database {
  constructor() {
    this.pool = new Pool({
      max: 10,
      host: config.host,
      user: config.user,
      password: config.password,
      database: config.database,
      idleTimeoutMillis: 10000,
    });
  }

  static getInstance() {
    if (!Database.instance) {
      Database.instance = new Database();
    }
    return Database.instance;
  }

  getConnection(callback) {
    this.pool.getConnection((err, connection) => {
      if (err) {
        console.error('Error al obtener la conexión: ', err);
        callback(false);
      } else {
        console.log('Conexión a la base de datos exitosa!');
        callback(true, connection);
      }
    });
  }

  disconnect() {
    this.pool.end((err) => {
      if (err) {
        console.error('Error al cerrar la conexión: ', err);
        return false;
      }
      console.log('Conexión cerrada correctamente');
      return true;
    });
  }

  query(sql, values, callback) {
    this.pool.query(sql, values, (err, result) => {
      if (err) {
        console.error('Error al realizar la consulta: ', err);
        callback(err, null);
      } else {
        callback(null, result);
      }
    });
  }
}

export default Database;
