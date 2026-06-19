const express = require('express');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 8081;

// Serve static files from the current directory
app.use(express.static(path.join(__dirname)));

// Serve index.html for the root route
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'index.html'));
});

// Start the server
app.listen(PORT, () => {
  console.log(`Frontend server running on port ${PORT}`);
});
