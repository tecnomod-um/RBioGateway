#' Get CRMs by overlap (getCRMs_by_overlap)
#'
#' Function to obtain the human cis-regulatory modules (CRMs) that completely overlap with a specific position or a specific range of genomic coordinates.
#'
#' @param chromosome chromosome name (string). Example: "chr-1".
#' @param start start position (integer).
#' @param end end position (integer). Default: NULL
#'
#' @return A data.frame of overlapping CRMs.
#'
#' @examples
#' \dontrun{
#' getCRMs_by_overlap("chr-1", 52565276)
#' }
#'
#' @export

getCRMs_by_overlap <- function(chromosome, start, end = NULL) {
  # Endpoint SPARQL
  endpoint_sparql <- "https://semantics.inf.um.es/biogateway"

  # Obtain the ID of the chromosome
  chromosome_ncbi <- translate_chr(chromosome)

  # Query building
  if (is.null(end)){end <- start}
  query <- sprintf(
    "
    PREFIX skos: <http://www.w3.org/2004/02/skos/core#>
    PREFIX obo: <http://purl.obolibrary.org/obo/>
    PREFIX nuccore: <https://www.ncbi.nlm.nih.gov/nuccore/>
    SELECT DISTINCT ?crm_name ?start ?end
    WHERE {
        GRAPH <http://rdf.biogateway.eu/graph/crm> {
            ?crm obo:GENO_0000894 ?start ;
                 skos:prefLabel ?crm_name ;
                 obo:GENO_0000895 ?end ;
                 obo:BFO_0000050 nuccore:%s .
            FILTER (?start <= %s && ?end >= %s)
        }
    }
    ",
    chromosome_ncbi, start, end
  )

  # Run query
  results <- SPARQL(endpoint_sparql, query)$results

  # Check results
  if (nrow(results) == 0) {
    return("No data available for the introduced genomic coordinates.")
  } else {
    # Order by coordinates
    results_sorted <- results[order(results$start, results$end), ]
    rownames(results_sorted) <- NULL
    return(results_sorted)
  }
}
