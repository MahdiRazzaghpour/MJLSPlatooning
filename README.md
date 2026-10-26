# MJLS Platooning

Code and data for the paper

> M. Razzaghpour, A. Datar, D. Schneider, M. Zaman, H. Werner, H. Frey, J. Mohammadpour Velni, Y. P. Fallah,
> **"Finite State Markov Modeling of C-V2X Erasure Links for Performance and Stability Analysis of Platooning Applications,"**
> IEEE International Systems Conference (SysCon), 2022. [IEEE Xplore](https://ieeexplore.ieee.org/abstract/document/9773892)

## What it does

Packet erasures on the C-V2X links between platoon members are modeled as a finite-state Markov chain, with
transition probabilities estimated from connectivity data. With a cooperative adaptive cruise controller in the loop,
the platoon becomes a Markov jump linear system (MJLS): one system matrix per state of the communication links. The
code checks mean-square stability of that system through an eigenvalue problem on its mean and covariance dynamics,
and confirms the result with Monte Carlo ensembles of trajectories.

## Layout

| Path | What it is |
|---|---|
| `analyze_MJLS_via_EVP.m` | mean-square stability of an MJLS via the eigenvalue problem, on scalar and textbook examples (including "unstable + unstable = stable" and "stable + stable = unstable") |
| `Simualte_MJLS_ensembles.m` | Monte Carlo ensembles of MJLS trajectories for the same examples |
| `plot_mean_var_for_scalar.m` | sample mean and covariance plots for the scalar examples |
| `lib/` | `Simulate_MJLS.m`, `get_B_T_matrices.m` (mean and covariance dynamics), `gen_rand_Laplacian.m`, plotting helpers |
| `mahdi_platooning_example/` | the platooning analysis: `main_mahdi_analysis.m` builds the 64 communication-link modes from `connectivity_data_mahdi/`, controller designs for the best and worst links (`design_for_extreme_cases.m`), reference trajectories (`gen_ref*.m`), and notes on the protocol (PDF) |
| `plots/` | `SYSCON.m` and the data behind the paper's figures (`plots/Plots/`) |

## Running it

MATLAB. Add `lib/` to the path, then run `mahdi_platooning_example/main_mahdi_analysis.m` for the platooning
analysis, or `analyze_MJLS_via_EVP.m` and `Simualte_MJLS_ensembles.m` for the standalone examples.

Developed with the paper's co-authors as part of PhD research at the University of Central Florida.
