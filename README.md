# PTMC
Phenomenological Theory of Martensite Crystallography implementation according to Bowles and Mackenzie

[J.S. Bowles, J.K. Mackenzie, Acta Metall. 2 (1954) 138–147]

## Example 1
This example covers the case of the *fcc* to *bcc* martensitic transformation in steel that was covered in Harry Bhadeshia's monograph [Bhadeshia, H. K. D. H. (1991). Worked Examples in the Geometry of Crystals, Second edition](https://www.phase-trans.msm.cam.ac.uk/2001/geometry2/Geometry.pdf) from page 57 forward.

The results can be reproduced by following few simple steps:
- Run the main file
- Choose "Fe-gamma_Bhadeshia_1991.cif" as the input structure for the parent phase
- Choose "Fe-alphaP_Bhadeshia_1991.cif" as the input structure for the daughter phase
- Use the default lattice correspondance matrix *bCa*:

| | |  |
| --------------- | --------------- | --------------- |
| 1 | -1 | 0 |
| 1 | 1  | 0 |
| 0 | 0  | 1 |

- Choose *Dislocation slip LIS* as the lattice invariant shear mechanism
- Set the *LIS plane* to *1 0 1* and the *LIS direction* to *1 0 -1*
- Retrieve the results in the command window and compare with the results in Bhadeshia's monograph

## Example 2
This example covers the case of the *fcc* to *orthorhombic* martensitic transformation in Ti-alloys that was covered by Chai et al. [Chai, Y. W., Kim, H. Y., Hosoda, H. & Miyazaki, S. (2009). Acta Mater. 57, 4054–4064.](http://dx.doi.org/10.1016/j.actamat.2009.04.051) in Table 2.

The results can be reproduced by following few simple steps:
- Run the main file
- Choose "Ti-beta_ChaiEtAl_ActaMaterialia_2009.cif" as the input structure for the parent phase
- Choose "Ti-alphaDP_ChaiEtAl_ActaMaterialia_2009.cif" as the input structure for the daughter phase
- Use the default lattice correspondance matrix *bCa*:

| | |  |
| --------------- | --------------- | --------------- |
| 1 | 0 | 0 |
| 0 | 0.5  | -0.5 |
| 0 | 0.5  | 0.5 |

- Choose *Twinning LIS* as the lattice invariant shear mechanism
- Set the *LIS plane* to *1 1 1*
- Retrieve the results in the command window and compare with the results in Bhadeshia's monograph
