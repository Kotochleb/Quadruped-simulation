# Quadruped robot simulation in Matlab

This is simulation of quadruped robot made in Matlab using Simulink library Simscape Multibody.
Simulation was made for project "Człap człap" of student's scientific group [KN Integra](http://www.integra.agh.edu.pl/)
at AGH University of Science and Technology.

Blocks in Simulink inherit parameters from objects defined in `quadruped_sim_param.mlx` to make
it easier to modify and duplicate Simulink modified blocks.


## Requirements

Simulation requires following Matlab Toolboxes:
- Simulink Simscape
- Simulink Simscape Multibody

## Changelog

### 0.2 - 20.04.2020
#### Added
- Leg joint blocks in Simulink inherit after `LegJoint` object.
- Motor angular speed saturation.
- Hip height in `single_leg.mlx`
- `leg_sim_data_validation.mlx` with:
  - Loop testing of different gearbox ratios.
  - Total power consumption of simulation.
  - Jump height.
  - Gearbox wear as integral of absolute value of angular acceleration with threshold value.
  - Comparison of different simulation results.

### Changed
- `controller` block is now called `motor`.
- Planetary gearbox block is now simple gain.
- Logged data:
  - Angular speed of motor is now both in rpm and rad/s.
  - Added pure motor torque as an option.

### Removed
- Simulink Simscape Driveline blocks.


### 0.1 - 18.04.2020
#### Added
- Leg bodies are now in objects.
- Jump sequence.
- Simulink Simscape Driveline planetary gearbox block.

#### Changed
- Logged data:
  - Angular speed of motor is now in rpm.
  - Added pure motor torque as an option.
  - Added current measurement as an option.
#### Fixed
- Single leg inverse kinematics


## License

This simulation is published under [GPL v3.0 license](https://github.com/Kotochleb/Quadruped-simulation/blob/master/LICENSE).
