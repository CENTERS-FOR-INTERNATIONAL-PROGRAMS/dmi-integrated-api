import { DataTypes } from 'sequelize';
import db from '../db/connection';

const TestTable = db.define('TestTable', {

    name: {
        type: DataTypes.STRING
    },
    description: {
        type: DataTypes.STRING
    },
    enabled: {
        type: DataTypes.BOOLEAN
    },
}, {
    timestamps: false
});


export default TestTable;