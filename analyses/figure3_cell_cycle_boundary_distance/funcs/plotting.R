# Helpers Functions for plotting Columbus results

## Layout Plotting Functions
### Heatmap
plot_heatmap <-
  function(table,
           property,
           discrete_property = T,
           legend,
           title) {
    layout_plot <- ggplot(
      table,
      aes(
        x = column,
        y = row,
        fill = {{ property }},
      )
    ) +
      geom_tile(color = "grey30") +
      scale_y_reverse(breaks = 1:16, labels = LETTERS[1:16]) +
      scale_x_continuous(breaks = 0:24) +
      coord_equal() +
      labs(
        x = "Column",
        y = "Row",
        title = title
      )

    if (discrete_property) {
      layout_plot + scale_fill_tableau(name = legend)
    } else {
      layout_plot + scale_fill_viridis_c(legend)
    }
  }

### Textmap
plot_textmap <-
  function(table,
           property,
           font_size = 1,
           legend,
           title) {
    ggplot(
      table,
      aes(
        x = column,
        y = row,
        label = {{ property }},
      )
    ) +
      geom_text(size = font_size) +
      scale_y_reverse(breaks = 1:16, labels = LETTERS[1:16]) +
      scale_x_continuous(breaks = 0:24) +
      coord_equal() +
      labs(
        x = "Column",
        y = "Row",
        title = title
      )
  }

## Single Cell Plotting Functions
### Density for bio replicates
plot_density <-
  function(table,
           property,
           property_trans = "identity",
           property_legend,
           title) {
    density_plot <- ggplot(
      table,
      aes(
        x = {{ property }},
        color = sync,
        linetype = fct(bio_rep)
      )
    )

    density_plot + geom_density(alpha = 0.3) +
      scale_x_continuous(property_legend, trans = property_trans) +
      scale_color_tableau(name = "Sync") +
      scale_linetype("Bio. Rep.") +
      facet_wrap(vars(sirna)) +
      labs(
        x = property_legend,
        y = "Density",
        title = title
      )
  }

### Density for cell cycle phases
plot_density_cc <-
  function(table,
           property,
           property_trans = "identity",
           property_legend,
           title) {
    density_plot <- ggplot(
      table,
      aes(
        x = {{ property }},
        color = cc_edu_phase,
        linetype = fct(bio_rep)
      )
    )
    
    density_plot + geom_density(alpha = 0.3) +
      scale_x_continuous(property_legend, trans = property_trans) +
      scale_color_tableau(name = "Cell Cycle\nPhase") +
      scale_linetype("Bio. Rep.") +
      facet_wrap(vars(sirna)) +
      labs(
        x = property_legend,
        y = "Density",
        title = title
      )
  }

### Boxplot
plot_boxplot <-
  function(table,
           property,
           property_trans = "identity",
           property_legend,
           title) {
    ggplot(
      table,
      aes(
        x = {{ property }},
        y = interaction(fct(bio_rep), fct_rev(sync), sep = "-"),
        color = sync,
      )
    ) +
      geom_boxplot(outlier.shape = NA) +
      scale_x_continuous(property_legend, trans = property_trans) +
      scale_color_tableau(name = "Sync") +
      facet_wrap(vars(sirna)) +
      labs(
        x = property_legend,
        y = "Bio. Rep-Sync",
        title = title
      )
  }

### Histogram
plot_histogram <-
  function(table,
           cc = F,
           property,
           property_legend,
           bin_width,
           limits,
           title) {

      ggplot(
        table,
        aes(
        x = {{ property }},
        y = after_stat(density)
      )) +
      geom_histogram(
        binwidth = bin_width,
        color = "grey70",
        fill = "darkblue"
      ) +
      coord_cartesian(xlim = limits) +
      labs(
        x = property_legend,
        y = "Density",
        title = title
      ) +
      if (cc) {
        facet_grid(vars(table$cc_edu_phase),
          vars(table$well),
          scales = "free_y"
        )
      } else {
        facet_wrap(vars(table$well))
      }
  }

## Well level plots
### Crossbar

plot_crossbars <- function(table,
                           property,
                           property_legend,
                           title) {
  ggplot(table, aes(
    x = sirna,
    y = {{ property }},
    color = sync
  )) +
    geom_point(alpha = 0.5) +
    stat_summary(
      fun.data = "mean_sdl",
      fun.args = list(mult = 1),
      geom = "crossbar",
      width = 0.6,
    ) +
    scale_color_tableau(name = "Sync.") +
    labs(
      y = property_legend,
      x = "siRNA",
      title = title
    ) +
    theme(axis.text.x = element_text(size = rel(0.5)))
}
