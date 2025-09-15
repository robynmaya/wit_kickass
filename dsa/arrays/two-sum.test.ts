import { twoSum, twoSumBruteForce } from './two-sum';

describe('Two Sum', () => {
  test('should return correct indices for valid input', () => {
    expect(twoSum([2, 7, 11, 15], 9)).toEqual([0, 1]);
    expect(twoSum([3, 2, 4], 6)).toEqual([1, 2]);
    expect(twoSum([3, 3], 6)).toEqual([0, 1]);
  });

  test('should return empty array when no solution exists', () => {
    expect(twoSum([1, 2, 3], 7)).toEqual([]);
  });

  test('brute force should work the same', () => {
    expect(twoSumBruteForce([2, 7, 11, 15], 9)).toEqual([0, 1]);
    expect(twoSumBruteForce([3, 2, 4], 6)).toEqual([1, 2]);
  });
});
