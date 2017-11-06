#' @export
geom_clone <- function(...) {
  structure(list(...), class = "clone")
}

clone_layer <- function(layer, params) {
  layer_new <- rlang::env_clone(layer)
  class(layer_new) <- class(layer)
  layer_new$aes_params <- rlang::modify(layer_new$aes_params, !!! params)
  layer_new
}

#' @export
ggplot_add.clone <- function(object, plot, object_name) {
  plot$layers <- append(plot$layers, lapply(plot$layers, clone_layer, params = object))
  plot
}
