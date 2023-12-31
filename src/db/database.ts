import { Sequelize } from "sequelize-typescript";
import { config, dialect } from "../config/db.config";

class Database {
  public sequelize: Sequelize | undefined;

  constructor(database: string) {
    this.connectToDatabase(database);
  }

  private async connectToDatabase(database: string) {
    this.sequelize = new Sequelize({
      database: database,
      username: config.USER,
      password: config.PASSWORD,
      host: config.HOST,
      dialect: dialect,
      pool: {
        max: config.pool.max,
        min: config.pool.min,
        acquire: config.pool.acquire,
        idle: config.pool.idle
      },
      models: []
    });

    await this.sequelize
      .authenticate()
      .then(() => {
        console.log("Connection has been established successfully.");
      })
      .catch((err) => {
        console.error("Unable to connect to the Database:", err);
      });
  }
}

export default Database;
