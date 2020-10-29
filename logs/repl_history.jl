# time: 2020-10-24 10:40:50 EDT
# mode: julia
	exit()
# time: 2020-10-24 10:43:02 EDT
# mode: julia
	using Flux
# time: 2020-10-24 10:43:09 EDT
# mode: julia
	import Pkg; Pkg.add("Flux")
# time: 2020-10-24 10:44:14 EDT
# mode: julia
	import Pkg; Pkg.add("DifferentialEquations")
# time: 2020-10-24 10:44:39 EDT
# mode: julia
	import Pkg; Pkg.add("DiffEqFlux")
# time: 2020-10-24 10:44:49 EDT
# mode: julia
	using Plots
# time: 2020-10-24 10:45:00 EDT
# mode: julia
	import Pkg; Pkg.add("Plots")
# time: 2020-10-24 10:45:16 EDT
# mode: julia
	import Pkg; Pkg.add("NPZ")
# time: 2020-10-24 10:45:27 EDT
# mode: julia
	import Pkg; Pkg.add("BSON")
# time: 2020-10-24 10:45:41 EDT
# mode: julia
	using Random
# time: 2020-10-24 10:45:47 EDT
# mode: julia
	exit()
# time: 2020-10-24 10:45:53 EDT
# mode: julia
	using DifferentialEquations
# time: 2020-10-24 10:54:33 EDT
# mode: julia
	using Flux
# time: 2020-10-24 10:57:01 EDT
# mode: julia
	using DiffEqFlux
# time: 2020-10-24 11:00:13 EDT
# mode: julia
	using Plots
# time: 2020-10-24 11:02:31 EDT
# mode: julia
	using NPZ
# time: 2020-10-24 11:02:33 EDT
# mode: julia
	using BSON: @save
# time: 2020-10-24 11:02:34 EDT
# mode: julia
	using BSON: @load
# time: 2020-10-26 04:32:25 EDT
# mode: julia
	using PyCall
# time: 2020-10-26 04:32:36 EDT
# mode: julia
	@pywith pybuiltin("open")("file.txt","w") as f begin
	    f.write("hello")
	end
# time: 2020-10-26 04:32:41 EDT
# mode: julia
	exit()
# time: 2020-10-26 04:33:49 EDT
# mode: julia
	using PyCall
# time: 2020-10-26 04:33:51 EDT
# mode: julia
	py"""
	import numpy as np
	
	def sinpi(x):
	    return np.sin(np.pi * x)
	"""
# time: 2020-10-26 04:33:55 EDT
# mode: julia
	py"sinpi"(1)
# time: 2020-10-26 04:34:09 EDT
# mode: julia
	py"sinpi(1)"
# time: 2020-10-26 04:34:20 EDT
# mode: julia
	py"sinpi(0.5)"
# time: 2020-10-26 04:50:11 EDT
# mode: julia
	ENV["PYTHON"]
# time: 2020-10-26 04:50:15 EDT
# mode: julia
	ENV
# time: 2020-10-26 04:50:18 EDT
# mode: julia
	exit()
# time: 2020-10-26 07:21:30 EDT
# mode: julia
	using Zygote
# time: 2020-10-26 07:21:35 EDT
# mode: julia
	import Pkg; Pkg.add("Zygote")
# time: 2020-10-27 04:08:48 EDT
# mode: julia
	exit()
# time: 2020-10-27 04:11:24 EDT
# mode: julia
	ENV["PYTHON"] = "/home/mingzeya/tools/Python-3.9.0/bin/python3"
# time: 2020-10-27 04:11:28 EDT
# mode: julia
	Pkg.build("PyCall")
# time: 2020-10-27 04:11:40 EDT
# mode: julia
	import Pkg
# time: 2020-10-27 04:11:42 EDT
# mode: julia
	Pkg.build("PyCall")
# time: 2020-10-27 04:13:36 EDT
# mode: julia
	exit()
# time: 2020-10-27 04:51:09 EDT
# mode: julia
	ENV["PYTHON"]
# time: 2020-10-27 04:51:16 EDT
# mode: julia
	ENV
# time: 2020-10-27 04:51:28 EDT
# mode: julia
	ENV["PYTHON"]
# time: 2020-10-27 04:51:59 EDT
# mode: julia
	ENV["PYTHON"]="/home/mingzeya/tools/Python-3.6.12/bin/python3"
# time: 2020-10-27 04:52:05 EDT
# mode: julia
	ENV["PYTHON"]
# time: 2020-10-27 04:52:10 EDT
# mode: julia
	import Pkg
# time: 2020-10-27 04:52:14 EDT
# mode: julia
	Pkg.build("PyCall")
# time: 2020-10-27 04:52:34 EDT
# mode: julia
	py"""
	import numpy as np
	"""
# time: 2020-10-27 04:52:40 EDT
# mode: julia
	using PyCall
# time: 2020-10-27 04:56:58 EDT
# mode: julia
	ENV["PYTHON"]="/home/mingzeya/tools/miniconda3/bin/python3"
# time: 2020-10-27 04:57:15 EDT
# mode: julia
	py"""
	import numpy as np
	"""
# time: 2020-10-27 04:57:21 EDT
# mode: julia
	using PyCall
# time: 2020-10-27 04:57:38 EDT
# mode: julia
	ENV["PYTHON"]="/home/mingzeya/tools/miniconda3/bin/python3"
# time: 2020-10-27 04:57:43 EDT
# mode: julia
	import Pkg
# time: 2020-10-27 04:57:50 EDT
# mode: julia
	Pkg.build("PyCall")
# time: 2020-10-27 04:58:00 EDT
# mode: julia
	Using PyCall
# time: 2020-10-27 04:58:07 EDT
# mode: julia
	using PyCall
# time: 2020-10-27 04:58:21 EDT
# mode: julia
	py"""
	       import numpy as np
	       """
# time: 2020-10-27 04:58:31 EDT
# mode: julia
	exit()
# time: 2020-10-27 05:00:48 EDT
# mode: julia
	ENV["PYTHON"]
# time: 2020-10-27 06:51:13 EDT
# mode: julia
	exit()
# time: 2020-10-28 01:49:52 EDT
# mode: julia
	data_max_size = 5 # from 0 to data_max_size
# time: 2020-10-28 01:50:00 EDT
# mode: julia
	max_data_num = 93  # how many steps are there in total? max_data_num+1
# time: 2020-10-28 01:50:01 EDT
# mode: julia
	numpts = 113
# time: 2020-10-28 01:51:40 EDT
# mode: julia
	py"""
	import pandas as pd
	import numpy as np
	import julia
	julia.install()
	from julia import Main
	numpts = Main.numpts
	print(numpts)
	"""
# time: 2020-10-28 01:51:59 EDT
# mode: julia
	using PyCall
# time: 2020-10-28 01:52:11 EDT
# mode: julia
	py"""
	      import pandas as pd
	      import numpy as np
	      import julia
	      julia.install()
	      from julia import Main
	      numpts = Main.numpts
	      print(numpts)
	      """
# time: 2020-10-28 01:53:25 EDT
# mode: julia
	exit()
# time: 2020-10-29 01:17:29 EDT
# mode: julia
	import Pkg
# time: 2020-10-29 01:18:12 EDT
# mode: julia
	Pkg.install("DiffEqFlux")
# time: 2020-10-29 01:18:27 EDT
# mode: julia
	using Eq
# time: 2020-10-29 01:18:37 EDT
# mode: julia
	Pkg.add("DiffEqFlux")
# time: 2020-10-29 01:19:22 EDT
# mode: julia
	exit()
