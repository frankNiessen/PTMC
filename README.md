# PTMC
Phenomenological Theory of Martensite Crystallography implementation according to Bowles and Mackenzie

[J.S. Bowles, J.K. Mackenzie, Acta Metall. 2 (1954) 138–147]

## Example 1
This example covers the case of the $fcc$ to $bcc$ martensitic transformation in steel that was covered in Harry Bhadeshia's monograph [Bhadeshia, H. K. D. H. (1991). Worked Examples in the Geometry of Crystals, Second edition](https://www.phase-trans.msm.cam.ac.uk/2001/geometry2/Geometry.pdf) from page 57 forward.

The results can be reproduced by following few simple steps:
- Run the main file
- Choose "Fe-gamma_Bhadeshia_1991.cif" as the input structure for the parent phase
- Choose "Fe-alphaP_Bhadeshia_1991.cif" as the input structure for the daughter phase
- Use the default lattice correspondance matrix $bCa$:

| 1 | -1 | 0 |
| 1 | 1  | 0 |
| 0 | 0  | 1 |

`1 -1  0

1  1  0

0  0  1`

- Choose *Dislocation slip LIS* as the lattice invariant shear mechanism
- Set the *LIS plane* to *1 0 1* and the *LIS direction* to *1 0 -1*
- Retrieve the results in the command window and compare with the results in Bhadeshia's monograph
