const express = require('express');
const { createLightship } = require('lightship');

const app = express();

app.get('/', (req, res) => res.send('Hello world! :)'));

const server = app.listen(3333);

const lightship = createLightship({ detectKubernetes: false });

lightship.registerShutdownHandler(() => {
  server.close();
});

lightship.signalReady();
