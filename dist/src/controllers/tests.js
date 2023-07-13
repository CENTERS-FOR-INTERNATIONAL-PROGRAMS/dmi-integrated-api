"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.deleteTest = exports.updateTest = exports.createTest = exports.getTest = exports.getTests = void 0;
const test_1 = __importDefault(require("../models/test"));
const getTests = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        //res.json({ message: 'GET /user request received' });
        const testTables = yield test_1.default.findAll();
        res.json(testTables);
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: 'Internal server error, contact API administrator'
        });
    }
});
exports.getTests = getTests;
const getTest = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { id } = req.params;
    try {
        const test = yield test_1.default.findByPk(id);
        if (test) {
            res.json(test);
        }
        else {
            res.status(404).json({
                msg: `test with id ${id} not found`
            });
        }
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: 'Internal server error, contact API administrator'
        });
    }
});
exports.getTest = getTest;
const createTest = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { body } = req;
    try {
        const test = yield test_1.default.create({
            name: body.name,
            description: body.description,
        });
        res.json(test);
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: 'Internal server error, contact API administrator'
        });
    }
});
exports.createTest = createTest;
const updateTest = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { id } = req.params;
    const { body } = req;
    try {
        const result = yield test_1.default.update({
            name: body.name,
            description: body.description
        }, {
            where: {
                id
            }
        });
        if (Number(result) === 1) {
            res.json({
                msg: `test with id ${id} updated`
            });
        }
        else {
            res.status(404).json({
                msg: `test with id ${id} not found`
            });
        }
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: 'Internal server error, contact API administrator'
        });
    }
});
exports.updateTest = updateTest;
const deleteTest = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { id } = req.params;
    try {
        const result = yield test_1.default.destroy({
            where: {
                id
            }
        });
        console.log('Result: ' + result);
        if (result) {
            res.json({
                msg: `Test with id ${id} deleted`
            });
        }
        else {
            res.status(404).json({
                msg: `Test with id ${id} not found`
            });
        }
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: 'Internal server error, contact API administrator'
        });
    }
});
exports.deleteTest = deleteTest;
