# Automated Stability Analysis Tool

This repository contains a MATLAB script designed to automate the construction of the Routh-Hurwitz table, which is essential for analyzing the stability of control systems.

## Features

- **Automated Routh-Hurwitz Table Construction:**  
  Simplifies the stability analysis process by accurately processing and organizing polynomial coefficients into a structured matrix.

- **Dynamic Polynomial Handling:**  
  Supports polynomial equations of varying lengths, ensuring precise stability assessment with automated row calculations.

- **Error Handling:**  
  Includes systematic error handling to manage potential issues during computation.

## Warnings

- **Zero Coefficients:**  
  If any polynomial coefficient is zero, the script may encounter difficulties in processing the table correctly. Ensure that coefficients are non-zero, or manually adjust the table as needed.

- **Special Cases:**  
  The script may not handle certain special cases, such as repeated roots or purely imaginary roots, correctly. Additional manual intervention may be required in these situations.

- **Edge Cases:**  
  Polynomials with very high degrees or coefficients close to zero might result in numerical instability or inaccurate results.
