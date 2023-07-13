import { Request, Response } from "express";
import TestTable from "../models/test";


export const getTests = async( req: Request, res: Response ) => {
    try {
        //res.json({ message: 'GET /user request received' });
      const testTables = await TestTable.findAll();
     res.json(testTables);
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: 'Internal server error, contact API administrator'
        });
    }
}

export const getTest = async( req: Request, res: Response ) => {
    const { id } = req.params;
    try {
        const test = await TestTable.findByPk(id);
        if (test) {
            res.json(test);
        } else {
            res.status(404).json({
                msg: `test with id ${id} not found`
            });
        }
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: 'Internal server error, contact API administrator'
        });
    }
}

export const createTest = async( req: Request, res: Response ) => {
    const { body } = req;
    try {
        const test = await TestTable.create({
            name: body.name,
            description: body.description,
        });
        res.json(test);
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: 'Internal server error, contact API administrator'
        });
    }
}

export const updateTest = async( req: Request, res: Response ) => {
    const { id } = req.params;
    const { body } = req;
    try {
        const result = await TestTable.update({
            name: body.name,
            description: body.description
        }, {
            where: {
              id
            }
        });
        if ( Number(result) === 1 ) {
            res.json({
                msg: `test with id ${id} updated`
            })
        } else {
            res.status(404).json({
                msg: `test with id ${id} not found`
            })
        }
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: 'Internal server error, contact API administrator'
        });
    }
}

export const deleteTest= async( req: Request, res: Response ) => {
    const { id } = req.params;
    try {
        const result = await TestTable.destroy({
            where: {
                id
            }
        });
        console.log('Result: ' + result);
        if ( result ) {
            res.json({
                msg: `Test with id ${id} deleted`
            })
        } else {
            res.status(404).json({
                msg: `Test with id ${id} not found`
            })
        }
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: 'Internal server error, contact API administrator'
        });
    }
}