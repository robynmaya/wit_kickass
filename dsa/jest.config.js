export default {
  preset: 'ts-jest',
  testEnvironment: 'node',
  roots: ['<rootDir>'],
  testMatch: [
    '**/__tests__/**/*.test.ts',
    '**/__tests__/**/*.test.js',
    '**/tests/**/*.test.ts',
    '**/tests/**/*.test.js',
    '**/*.test.ts',
    '**/*.test.js'
  ],
  collectCoverageFrom: [
    '**/*.ts',
    '**/*.js',
    '!**/*.test.ts',
    '!**/*.test.js',
    '!**/node_modules/**',
    '!**/dist/**'
  ]
};
