transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/luisd/Documents/ProjectsFPGA/ProyectoGrupalArqui1/CPU/Pipeline {C:/Users/luisd/Documents/ProjectsFPGA/ProyectoGrupalArqui1/CPU/Pipeline/PipelineWB.sv}
vlog -sv -work work +incdir+C:/Users/luisd/Documents/ProjectsFPGA/ProyectoGrupalArqui1/CPU/Pipeline {C:/Users/luisd/Documents/ProjectsFPGA/ProyectoGrupalArqui1/CPU/Pipeline/PipelineMem.sv}
vlog -sv -work work +incdir+C:/Users/luisd/Documents/ProjectsFPGA/ProyectoGrupalArqui1/CPU/Pipeline {C:/Users/luisd/Documents/ProjectsFPGA/ProyectoGrupalArqui1/CPU/Pipeline/PipelineEx.sv}
vlog -sv -work work +incdir+C:/Users/luisd/Documents/ProjectsFPGA/ProyectoGrupalArqui1/CPU/tests {C:/Users/luisd/Documents/ProjectsFPGA/ProyectoGrupalArqui1/CPU/tests/pipeline_tb.sv}

