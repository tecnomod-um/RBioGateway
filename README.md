# Description
RBiogateway is an R package that provides programmatic access to BioGateway (https://biogateway.eu), a biological knowledge graph that integrates data from multiple databases across diverse biological domains. The package offers a set of user-friendly functions that abstract users from the SPARQL query language, enabling seamless access to integrated information on genes, proteins, phenotypes, cis-regulatory modules, topologically associating domains, Gene Ontology terms, and the relationships among these entities.

![BGW example](https://github.com/juan-mulero/cisreg/blob/19d2155282f4242dac0f8a076a05679c651cacef/images/UseCases.PNG "Example")

Although BioGateway is a knowledge network focused mainly on human, information about other organisms can also be explored:

| Taxon                                   | Common name                 | Taxon ID |
|-----------------------------------------|-----------------------------|----------|
| *Mus musculus*                          | House mouse                 | 10090    |
| *Arabidopsis thaliana*                  | Thale cress                 | 3702     |
| *Oryza sativa* Japonica Group           | Rice (Asian rice)           | 39947    |
| *Dictyostelium discoideum*              | Social amoeba               | 44689    |
| *Zea mays*                              | Maize (corn)                | 4577     |
| *Caenorhabditis elegans*                | Nematode (roundworm)        | 6239     |
| *Danio rerio*                           | Zebrafish                   | 7955     |
| *Gallus gallus*                         | Chicken                     | 9031     |
| *Sus scrofa*                            | Pig                         | 9823     |
| *Bos taurus*                            | Cattle                      | 9913     |
| *Homo sapiens*                          | Human                       | 9606     |
| *Drosophila melanogaster*               | Fruit fly                   | 7227     |
| *Oryctolagus cuniculus*                 | Rabbit                      | 9986     |
| *Rattus norvegicus*                     | Brown rat                   | 10116    |
| *Saccharomyces cerevisiae* S288C        | Baker’s yeast               | 559292   |
| *Schizosaccharomyces pombe* 972h-       | Fission yeast               | 284812   |
| *Chlamydomonas reinhardtii*             | Green alga                  | 3055     |
| *Plasmodium falciparum* 3D7             | Malaria parasite            | 36329    |
| *Neurospora crassa* OR74A               | Red bread mold              | 367110   |
| *Canis lupus familiaris*                | Dog                         | 9615     |


**Key Features**
- R Interface: Seamless integration with BioGateway endpoint.
- Reproducible Research: Designed to fit into standard R bioinformatics workflows.
- Python Parity: Implements equivalent functionality to the existing [Python package](https://github.com/AlbertoHernandezHidalgo/PyBioGateway.git)


# Installation
```r
devtools::install_github("tecnomod-um/RBioGateway")
library(RBioGateway)

#Example of use: human proteins involved in the biological process negative regulation of neuron apoptotic process (GO:0043524)
bp2prot(biological_process = "GO:0043524", taxon = "Homo sapiens", sources = T)
```

# About BioGateway

The targeted endpoint of BioGateway is available at [https://semantics.inf.um.es/biogateway](https://semantics.inf.um.es/biogateway), using SPARQL language.

An interactive and user-friendly web application is also available at [https://semantics.inf.um.es/intuition_biogateway](https://semantics.inf.um.es/intuition_biogateway).

The BioGateway network is structured in [RDF](https://www.w3.org/RDF/) graphs, being each graph a different information domain. We distinguish two types of graphs in the network: entity graphs and relation graphs. The first ones aim to model different biological entities, while the second ones model relations between different entities.

![BGW graphs](https://github.com/juan-mulero/cisreg/blob/19d2155282f4242dac0f8a076a05679c651cacef/images/graphs.png "BioGateway network")

The knowledge network of BioGateway has the following graphs:
- crm : Cis Regulatory Modules (CRM). Currently only enhancer sequences, that increase gene transcription levels.
- crm2phen: Relations between CRM and phenotypes.
- crm2gene: Relations between CRM and target genes.
- crm2tfac: Relations between CRM and transcription factors.
- tad : Topologically associating domain. Domains of genome structure and regulation.
- gene : Genes.
- prot : Proteins.
- omim : OMIM ontology (phenotypes, among others).
- go : GO ontology (biological processes, molecular functions and cellular components).
- mi : Molecular Interaction Ontology.
- taxon : NCBI Taxon Ontology.
- gene2phen : Genes - Phenotypes (omim) relations .
- tfac2gene : Relations between transcription factors and their target genes.
- prot2prot : Protein-protein interactions.
- reg2targ : Protein - Protein regulatory relations
- prot2cc : Protein - Celullar components relations.
- prot2bp : Protein - Biological processes relations.
- prot2mf : Protein - Molecular functions relations.
- ortho : Protein-protein orthology relations.  

Supplementary material and tutorials for further exploration of the BioGateway network are available in the [cisreg](https://github.com/juan-mulero/cisreg) repository.


# Type of RBioGateway functions

In the current package design, we can classify the generated functions into two types: **Functions to retrieve data domain** and **Functions to retrieve relationships between domains**. Las funciones están documentadas, por lo que el usuario puede acceder a dicha documentación mediante la consulta de ayuda:

```r
?getGene_info
```

- **Functions to retrieve data domain**. These functions are designed to provide the user data about the biological entity consulted. That is, information about a gene, protein, cis regulatory module, etc. Example: Give me information about the Brca1 gene in mouse.
```r
getGene_info("Brca1", "Mus musculus")
```
```
#Output:
$start
[1] 101379587

$end
[1] 101442808

$strand
[1] "Negative strand"

$chromosome
[1] "chr-11"

$assembly
[1] "GRCm39"

$definition
[1] "gene 10090/Brca1 encoding [A0A087WP26_MOUSE A0A087WPE1_MOUSE A0A087WPK5_MOUSE BRCA1_MOUSE]"

$alt_gene_sources
[1] "http://identifiers.org/ensembl/ENSMUSG00000017146.13" "http://identifiers.org/ncbigene/12189"      
```

Functions:

| Function              | Domain                               |
|-----------------------|--------------------------------------|
| getCRM_info           | Cis-Regulatory Module (enhancer)     |
| getCRM_add_info       | Cis-Regulatory Module (enhancer)     |
| getCRMs_by_coord      | Cis-Regulatory Module (enhancer)     |
| getGene_info          | Gene                                 |
| getGenes_by_coord     | Gene                                 |
| getPhenotype          | Phenotype                            |
| getProtein_info       | Protein                              |
| getTAD_info           | Topologically Associating Domain     |
| getTAD_add_info       | Topologically Associating Domain     |
| getTADs_by_coord      | Topologically Associating Domain     |
| type_data             | Biological type domain               |


- **Functions to retrieve relationships between domains**. These functions provide the user information about one biological domain using another domain as input. That is, you can explore the relationship between different biological entities. Example: What proteins does the Brca1 gene encode in mice? In which cellular components is it found?
```r
gene2prot("Brca1", "Mus musculus")
```
```
#Output:
[1] "A0A087WP26_MOUSE" "A0A087WPE1_MOUSE" "A0A087WPK5_MOUSE" "BRCA1_MOUSE"
```
```r
prot2cc("BRCA1_MOUSE")
```
```
#Output:
        cc_id                     cc_label     relation_label database      articles
1  GO:0070531              BRCA1-A complex P48754--GO:0070531      GOA PMID:20656689
2  GO:0001741                      XY body P48754--GO:0001741      GOA PMID:31839538
3  GO:0005813                   centrosome P48754--GO:0005813      GOA PMID:10855792
4  GO:0005694                   chromosome P48754--GO:0005694      GOA PMID:22549958
5  GO:0005694                   chromosome P48754--GO:0005694      GOA PMID:23039116
6  GO:0000793         condensed chromosome P48754--GO:0000793      GOA PMID:12913077
7  GO:0000794 condensed nuclear chromosome P48754--GO:0000794      GOA PMID:26490168
8  GO:0000794 condensed nuclear chromosome P48754--GO:0000794      GOA PMID:20551173
9  GO:0005737                    cytoplasm P48754--GO:0005737      GOA PMID:11172592
10 GO:0000800              lateral element P48754--GO:0000800      GOA  PMID:9774970
11 GO:0001673       male germ cell nucleus P48754--GO:0001673      GOA PMID:31839538
12 GO:0005634                      nucleus P48754--GO:0005634      GOA PMID:20656689
13 GO:0005634                      nucleus P48754--GO:0005634      GOA PMID:22369660
14 GO:0005634                      nucleus P48754--GO:0005634      GOA PMID:18171670
15 GO:0032991   protein-containing complex P48754--GO:0032991      GOA PMID:16951165
16 GO:1990904    ribonucleoprotein complex P48754--GO:1990904      GOA PMID:18809582
```

Functions:

| Function              | Input Domain                                  | Output domain                              |
|-----------------------|-----------------------------------------------|--------------------------------------------|
| crm2gene              | Cis-Regulatory Module (enhancer)              | Target gene                                |
| gene2crm              | Gene                                          | Cis-Regulatory Module (enhancer)           |
| crm2tfac              | Cis-Regulatory Module (enhancer)              | Protein (Binding Transcription Factor)     |
| tfac2crm              | Protein (Binding Transcription Factor)        | Cis-Regulatory Module (enhancer)           |
| gene2tfac             | Gene                                          | Protein (regulatory Transcription Factor)  |
| tfac2gene             | Protein (regulatory Transcription Factor)     | Gene                                       |
| crm2phen              | Cis-Regulatory Module (enhancer)              | Phenotype associated                       |
| phen2cm               | Phenotype                                     | Cis-Regulatory Module associated (enhancer)|
| phen2gene             | Phenotype                                     | Gene                                       |
| gene2phen             | Gene                                          | Phenotype                                  |
| gene2prot             | Gene                                          | Protein (encoded)                          |
| prot2gene             | Protein                                       | Gene (encoding)                            |
| bp2prot               | Biological process                            | Protein                                    |
| prot2bp               | Protein                                       | Biological process                         |
| cc2prot               | Cellular component                            | Protein                                    |
| prot2cc               | Protein                                       | Cellular component                         |
| mf2prot               | Molecular function                            | Protein                                    |
| prot2mf               | Protein                                       | Molecular function                         |
| prot_regulated_by     | Protein                                       | Protein (regulatory)                       |
| prot_regulates        | Protein                                       | Protein (regulated)                        |
| prot2prot             | Protein                                       | Protein (molecular interaction)            |
| prot2ortho            | Protein                                       | Protein (orthologous)                      |


# Development Status
This package is currently under development within the [TECNOMOD](https://github.com/tecnomod-um) group from University of Murcia, Spain.


# License
MIT License
