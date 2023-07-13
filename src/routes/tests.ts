import { Router } from 'express';

import { createTest, getTest,getTests,updateTest,deleteTest } from '../controllers/tests';

const router = Router();

router.get('/', getTests);
router.get('/:id', getTest);
router.post('/', createTest);
router.put('/:id', updateTest);
router.delete('/:id', deleteTest);

export default router;