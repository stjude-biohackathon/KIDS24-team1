#' Create barplot
#'
#' @param plot_df 
#' @param ylim 
#' @param x_value 
#' @param use_palette 
#' @param xtitle
#' @param title_value
#' 
#'
#' @return
#' @export
#'
#' @examples
#' 
create_barplot <- function(plot_df, ylim, x_value, use_palette, xtitle, title_value) {
  
  # Rename legend 
  legend <- x_value
  
  # Plot 
  p <- print(ggplot(plot_df, aes(x = x_value, 
                                y = n, 
                                fill = legend)) +  
               geom_col(position = position_stack(reverse = TRUE)) +
               geom_bar(stat = "identity", width = 0.5) + 
               scale_fill_manual(values = use_palette) + 
               theme_Publication(base_size = 10) + 
               theme(axis.text.x = element_text(angle = 85, 
                                                hjust = 1, 
                                                vjust = 1)) + 
               labs(title = title_value,
                    x = xtitle, 
                    y = "Number of assays") +
               ylim(0, ylim)) 
  return(p)
}


#' Create stacked_barplot
#'
#' @param plot_df 
#' @param x_value 
#' @param use_palette 
#' @param xtitle
#' @param legend
#' @param title_value
#' 
#'
#' @return
#' @export
#'
#' @examples
#' 
create_stacked_barplot <- function(plot_df, x_value, use_palette, xtitle, legend, title_value) {

  # Plot 
  p <- print(ggplot(plot_df, aes(x = cancer_type_brain, 
                                 y = n,
                                 fill = legend)) +  
               geom_bar(position="fill", stat="identity") +
               scale_fill_manual(values = use_palette) + 
               theme_Publication(base_size = 9) + 
               theme(axis.text.x = element_text(angle = 85, 
                                                hjust = 1, 
                                                vjust = 1)) + 
               labs(title = title_value,
                    x = xtitle, 
                    y = "Percent assays")) 
  return(p)
}




