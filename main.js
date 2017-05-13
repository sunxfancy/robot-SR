const {createFunction} = require('./build/Release/robot-sr');

const fn = createFunction();
console.log(fn());