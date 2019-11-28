const express = require('express');

const HOST = process.env.HOST;
const PORT = process.env.PORT;

app = express();

app.get('/', (_, res) => {
  res.send('helloworld!');
});

app.listen(PORT, HOST, () => {
  console.log(`server is running on ${HOST}:${PORT}`);
});
