import express from 'express';
import session from 'express-session';
import path from 'path';
import { fileURLToPath } from 'url';
import userRoutes from './routes/userRoutes.js';
import fileMRoutes from './routes/fileMRoutes.js';
import miscRoutes from './routes/miscRoutes.js';
import adminRountes from './routes/adminRountes.js';
import { popMessages } from './controllers/helperFunctions.js';

import { addAuditor, getAuditor } from './database/dbQueries.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();
const PORT = 3000;

app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, '/views'));

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static('public'));

app.use(session({
  secret: 'your secret key',
  resave: false,
  saveUninitialized: true,
}));

app.use(function(req, res, next) {
  res.locals.session = req.session;
  next();
});

app.use(userRoutes);
app.use(fileMRoutes);
app.use(miscRoutes);
app.use(adminRountes);

app.get('/', (req, res) => {
  const messages = popMessages(req);

  getAuditor('21.189.168-8', (err2, res2) => {
    res.render('index', {'alert_messages': messages, 'data1': res2.rows});
  });
});

app.use((req, res, next) => {
  res.status(404).render('404');
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});