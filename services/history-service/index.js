const express = require('express');
const app = express();
app.use(express.json());

let history = [];

app.post('/history', (req, res) => {
  history.push(req.body.videoId);
  res.json({ status: 'saved' });
});

app.get('/history', (req, res) => {
  res.json(history);
});

app.listen(3003, () => console.log('History service running'));
