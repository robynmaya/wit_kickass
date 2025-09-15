#!/usr/bin/env node

/**
 * Problem runner utility
 * Usage: npm run solve <problem-name>
 */

import { readdir } from 'fs/promises';
import { join } from 'path';

async function findProblem(problemName: string) {
  const directories = ['arrays', 'linked-lists', 'problems'];
  
  for (const dir of directories) {
    try {
      const files = await readdir(join(process.cwd(), dir));
      const problemFile = files.find(file => 
        file.includes(problemName.toLowerCase()) && 
        (file.endsWith('.ts') || file.endsWith('.js')) &&
        !file.endsWith('.test.ts') &&
        !file.endsWith('.test.js')
      );
      
      if (problemFile) {
        return join(dir, problemFile);
      }
    } catch {
      // Directory doesn't exist, continue
    }
  }
  
  return null;
}

async function main() {
  const problemName = process.argv[2];
  
  if (!problemName) {
    console.log('Usage: npm run solve <problem-name>');
    console.log('Example: npm run solve two-sum');
    process.exit(1);
  }
  
  const problemPath = await findProblem(problemName);
  
  if (!problemPath) {
    console.log(`Problem "${problemName}" not found.`);
    console.log('Available problems:');
    // List available problems
    const directories = ['arrays', 'linked-lists', 'problems'];
    for (const dir of directories) {
      try {
        const files = await readdir(join(process.cwd(), dir));
        const problemFiles = files.filter(file => 
          (file.endsWith('.ts') || file.endsWith('.js')) &&
          !file.endsWith('.test.ts') &&
          !file.endsWith('.test.js')
        );
        if (problemFiles.length > 0) {
          console.log(`\n${dir}:`);
          problemFiles.forEach(file => console.log(`  - ${file.replace(/\.(ts|js)$/, '')}`));
        }
      } catch {
        // Directory doesn't exist
      }
    }
    process.exit(1);
  }
  
  console.log(`Running ${problemPath}...`);
  
  try {
    const module = await import(`../${problemPath}`);
    
    // Try to run a main function if it exists
    if (typeof module.main === 'function') {
      module.main();
    } else {
      console.log('Problem loaded successfully!');
      console.log('Available exports:', Object.keys(module));
    }
  } catch (error) {
    console.error('Error running problem:', error);
  }
}

main().catch(console.error);
