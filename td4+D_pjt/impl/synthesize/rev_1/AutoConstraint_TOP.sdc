
#Begin clock constraint
define_clock -name {TOP|XTAL_IN} {p:TOP|XTAL_IN} -period 10.000 -clockgroup Autoconstr_clkgroup_0 -rise 0.000 -fall 5.000 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {Gowin_PLL|clkoutd_inferred_clock} {n:Gowin_PLL|clkoutd_inferred_clock} -period 7.619 -clockgroup Autoconstr_clkgroup_1 -rise 0.000 -fall 3.809 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {TOP|count_derived_clock[22]} {n:TOP|count_derived_clock[22]} -period 10.000 -clockgroup Autoconstr_clkgroup_0 -rise 0.000 -fall 5.000 -route 0.000 
#End clock constraint
