# Quadruped robot simulation in Matlab

This is simulation of quadruped robot made in `Matlab` using `Simulink` library `Simscape Multibody`.
Simulation was made for project "Człap człap" of student's scientific group [KN Integra](http://www.integra.agh.edu.pl/)
at AGH University of Science and Technology.

Blocks in Simulink inherit parameters from objects defined in `quadruped_sim_param.mlx` to make
it easier to modify and duplicate `Simulink` modified blocks.


## Requirements

Simulation requires following `Matlab Toolboxes`:
- `Simulink Simscape`
- `Simulink Simscape Driveline`
- `Simulink Simscape Multibody`

## Changelog

1.1 Moved leg bodies to body objects, fixed single leg inverse kinematics. In logged data:
    - Angular speed of motor is now in rpm.
    - Added pure motor torque as an option.
    - Added current measurement as an option.

## License

This simulation is published under [GPL v3.0 license](https://github.com/Kotochleb/Quadruped-simulation/blob/master/LICENSE).
