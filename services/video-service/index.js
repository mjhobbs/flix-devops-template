const express = require('express');
const app = express();

const videos = [
  { id: 1, title: 'DevOps Intro' },
  { id: 2, title: 'Docker Basics' }
];

app.get('/videos', (req, res) => {

  res.json(videos);
});

app.listen(3002, () => console.log('Video service running'));
