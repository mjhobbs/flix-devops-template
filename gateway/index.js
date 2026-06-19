const express = require('express');
const axios = require('axios');
const cors = require('cors');

const app = express();
app.use(express.json());
app.use(cors({ origin: 'http://localhost:8081' }));

const VIDEO_SERVICE = 'http://video-service:3002';
const HISTORY_SERVICE = 'http://history-service:3003';

app.get('/videos', async (req, res) => {
  const response = await axios.get(`${VIDEO_SERVICE}/videos`);
  res.json(response.data);
});

app.post('/history', async (req, res) => {
  const response = await axios.post(`${HISTORY_SERVICE}/history`, req.body);
  res.json(response.data);
});

app.listen(8080, () => console.log('Gateway running'));
