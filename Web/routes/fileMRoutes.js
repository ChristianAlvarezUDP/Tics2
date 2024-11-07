// routes/userRoutes.js
import express from 'express';
import { Upload, UploadView, Download, ShowFile, Delete } from '../controllers/fileMController.js';
const router = express.Router();

router.get('/download/:fileid', Download);
router.get('/showfile/:fileid', ShowFile);

router.post('/subir', Upload);
router.post('/eliminar', Delete);

export default router;
