#set heading(numbering: "(I)")
#show heading: it => [
  #set align(center)
  #set text(font: "Inria Serif")
  \~ #emph(it.body)
  \~
]



= Last Week's Plan
- Finish the MPC experiment of quadrotor.

= Accomplishment
- [x] Coded and Tested Immediate-Reaction Mode Change of `manual` and `offbaord`  mode.
- [x] C_NMPC Interface.
- [x] Connectivity between plain simulation and C_NMPC.
- [] Connectivity between gazebo simulation and C_NMPC. (*rotation*)

#figure(
  image("Figures/cnmpc_quad.png", width: 80%),
  caption: [Time Statistics of quadrotor MPC],
)

= This Week's Plan
- Finish the MPC experiment of `quadrotor`.
- [] PX4 interface transription of C_NMPC cmds.
- [] Real world experiment of C_NMPC. (*rotation*)
