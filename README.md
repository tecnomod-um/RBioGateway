Description
RBiogateway is an R package designed to provide programmatic access to the BioGateway knowledge network (https://biogateway.eu), which integrates biological information from multiple sources.

Key Features
R Interface: Seamless integration with BioGateway endpoint.
Reproducible Research: Designed to fit into standard R bioinformatics workflows.
Python Parity: Implements equivalent functionality to the existing [Python package](https://github.com/AlbertoHernandezHidalgo/PyBioGateway.git)


Installation
```
devtools::install_github("tecnomod-um/RBioGateway")

library(RBioGateway)
#Example of use: human proteins involved in the biological process negative regulation of neuron apoptotic process (GO:0043524)
bp2prot(biological_process = "GO:0043524", taxon = "Homo sapiens", sources = T)
```

Development Status
This package is currently under development as part of TFG in Biotechnology at the University of Murcia, supervised by Dr. Jesualdo Tomás Fernández Breis and Juan Mulero Hernández.

License
MIT License