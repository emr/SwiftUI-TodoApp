const config = require('./jest.config');

module.exports = {
  ...config,
  roots: ['test/e2e'],
};
