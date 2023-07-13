"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const sequelize_1 = require("sequelize");
const config_1 = __importDefault(require("../../config"));
const db = new sequelize_1.Sequelize(config_1.default.dbConfig.db, config_1.default.dbConfig.user, config_1.default.dbConfig.password, {
    host: config_1.default.dbConfig.host,
    port: config_1.default.dbConfig.port,
    dialect: 'mssql',
    dialectOptions: {
        requestTimeout: 30000,
        options: {
            encrypt: true,
        }
    }
});
exports.default = db;
