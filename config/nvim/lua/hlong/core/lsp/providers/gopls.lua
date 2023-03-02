local opt = {
	settings = {
		gopls = {
			directoryFilters = {
				"-bazel-bin",
				"-bazel-out",
				"-bazel-testlogs",
				"-bazel-mypkg",
			},
		},
	},
}

return opt
