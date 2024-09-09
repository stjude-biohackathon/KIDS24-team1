#' Create barplot
#'
#' @param plot_df 
#' @param ylim 
#' @param x_value 
#' @param use_palette 
#' @param xtitle
#' 
#'
#' @return
#' @export
#'
#' @examples
#' 
create_barplot <- function(plot_df, ylim, x_value, use_palette, xtitle) {
  
  # Rename legend 
  legend <- x_value
  
  # Plot 
  p <- print(ggplot(plot_df, aes(x = x_value, 
                                y = n, 
                                fill = legend)) +  
               geom_col(position = position_stack(reverse = TRUE)) +
               geom_bar(stat = "identity", width = 0.5) + 
               scale_fill_manual(values = use_palette) + 
               theme_Publication() + 
               theme(axis.text.x = element_text(angle = 85, 
                                                hjust = 1, 
                                                vjust = 1)) + 
               #labs(title = paste("Number of samples with assay information")) + 
               labs(x = xtitle, y = "Number of assays") +
               ylim(0, ylim)) 
  return(p)
}


#' Create stacked_barplot
#'
#' @param plot_df 
#' @param ylim 
#' @param x_value 
#' @param use_palette 
#' @param xtitle
#' 
#'
#' @return
#' @export
#'
#' @examples
#' 
create_stacked_barplot <- function(plot_df, x_value, use_palette, xtitle, legend) {

  # Rename legend 
  #legend <- x_value

  # Plot 
  p <- print(ggplot(plot_df, aes(x = cancer_type_brain, 
                                 y = n,
                                 fill = legend)) +  
               #geom_col(position = position_stack(reverse = TRUE), col = "black", size = 0.4) +
               geom_bar(position="fill", stat="identity") +
               scale_fill_manual(values = use_palette) + 
               theme_Publication() + 
               theme(axis.text.x = element_text(angle = 85, 
                                                hjust = 1, 
                                                vjust = 1)) + 
               #labs(title = paste("Number of samples with assay information")) + 
               #facet_wrap(~cancer_type_brain) +

               #scale_y_continuous(labels = function(x) paste0(100*x/max(x),'%')) +
               #scale_y_continuous(breaks = scales::pretty_breaks(n = 6), 
               #                   limits = c(0, ylim)) +
               labs(x = xtitle, y = "Count")) 
  return(p)
}






#' Create stacked_barplot - GROUPED
#'
#' @param plot_df 
#' @param ylim 
#' @param x_value 
#' @param use_palette 
#' @param xtitle
#' 
#'
#' @return
#' @export
#'
#' @examples
#' 
create_stacked_barplot_GROUPED <- function(plot_df, x_value, use_palette, xtitle, legend) {

  # Rename legend 
  #legend <- x_value

  # Plot 
  p <- print(ggplot(plot_df, aes(x = cancer_type_brain, 
                                 y = n,
                                 fill = legend)) +  
               #geom_col(position = position_stack(reverse = TRUE), col = "black", size = 0.4) +
               geom_bar(position="dodge", stat="identity") +
               scale_fill_manual(values = use_palette) + 
               theme_Publication() + 
               theme(axis.text.x = element_text(angle = 85, 
                                                hjust = 1, 
                                                vjust = 1)) + 
               #labs(title = paste("Number of samples with assay information")) + 
               #facet_wrap(~cancer_type_brain) +

               #scale_y_continuous(labels = function(x) paste0(100*x/max(x),'%')) +
               #scale_y_continuous(breaks = scales::pretty_breaks(n = 6), 
               #                   limits = c(0, ylim)) +
               labs(x = xtitle, y = "Count")) 
  return(p)
}

