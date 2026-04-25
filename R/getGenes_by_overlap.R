#' Get genes by ovelap (getGenes_by_overlap)
#'
#' Function to retrieve human genes that completely overlap with a specific position or a specific range of genomic coordinates, with the option to filter them by strand orientation.
#'
#' @param chr Chromosome name (string). Example: "chr-1".
#' @param start Start position (integer).
#' @param end End position (integer). Default: NULL
#' @param strand Strand orientation (string), or NULL if not specified. Possible values: "ForwardStrandPosition", "ReverseStrandPosition" and NULL. Default: NULL.
#'
#' @return A data.frame containing gene names, start, end, and strand for overlapping genes. If no data is available, a message is returned.
#'
#' @examples
#' \dontrun{
#' getGenes_by_overlap("chr-16", 52565276)
#' }
#'
#' @export

getGenes_by_overlap <- function(chr, start, end = NULL, strand = NULL) {
  # Define the SPARQL endpoint
  endpoint_sparql <- "https://semantics.inf.um.es/biogateway"

  # Translate chromosome name to NCBI ID
  chr_ncbi <- translate_chr(chr)

  # Case when strand is NULL
  if (is.null(strand)) {
    template <- "
      PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
      PREFIX obo: <http://purl.obolibrary.org/obo/>
      PREFIX nuccore: <https://www.ncbi.nlm.nih.gov/nuccore/>
      SELECT DISTINCT ?gene_name ?start ?end ?strand
      WHERE {
          GRAPH <http://rdf.biogateway.eu/graph/gene> {
              ?gene obo:GENO_0000894 ?start ;
                    skos:prefLabel ?gene_name ;
                    obo:GENO_0000895 ?end ;
                    obo:BFO_0000050 nuccore:%s ;
                    obo:GENO_0000906 ?str ;
                    obo:RO_0002162 ?taxon .
              ?str skos:prefLabel ?strand .
              # Filter by the specified chromosome and coordinate range
              FILTER (xsd:integer(?start) <= %s && xsd:integer(?end) >= %s)
          }
      }
      "

    if (is.null(end)){end <- start}
    query <- sprintf(template, chr_ncbi, start, end)

    # Execute the SPARQL query
    results <- SPARQL(endpoint_sparql, query)$results
  }

  # Case when strand is specified
  else {
    template <- "
      PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
      PREFIX obo: <http://purl.obolibrary.org/obo/>
      PREFIX nuccore: <https://www.ncbi.nlm.nih.gov/nuccore/>
      PREFIX strand: <http://biohackathon.org/resource/faldo#>
      SELECT DISTINCT ?gene_name ?start ?end
      WHERE {
          GRAPH <http://rdf.biogateway.eu/graph/gene> {
              ?gene obo:GENO_0000894 ?start ;
                    skos:prefLabel ?gene_name ;
                    obo:GENO_0000895 ?end ;
                    obo:BFO_0000050 nuccore:%s ;
                    obo:GENO_0000906 strand:%s ;
                    obo:RO_0002162 ?taxon .
              # Filter by the specified chromosome and coordinate range
              FILTER (xsd:integer(?start) <= %s && xsd:integer(?end) >= %s)
          }
      }
      "

    if (is.null(end)){end <- start}
    query <- sprintf(template, chr_ncbi, strand, start, end)

    # Execute the SPARQL query
    results <- SPARQL(endpoint_sparql, query)$results
  }

  # Check if there are any results
  if (nrow(results) == 0) {
    return("No data available for the introduced genomic coordinates.")
  } else {
    # Sort the results by gene name
    results_sorted <- results[order(results$gene_name), ]
    rownames(results_sorted) <- NULL
    return(results_sorted)
  }
}
