library(ggplot2)
theme_set(theme_gray())

url <- "/home/kaiser145/IST - LEIC-T/Projects-Live/PE/countries of the world.xlsx"
data <- readxl::read_xlsx(url)
variable <- "Literacy (%)"
nbins <- nclass.Sturges(data[[variable]])

ggplot(data, aes(
    x = .data[[variable]],
    y = cumsum(after_stat(count)) / nrow(data)
)) +
    geom_histogram(
        bins = nbins, fill = "cornflowerblue",
        color = "cornflowerblue", boundary = 0
    ) +
    geom_freqpoly(bins = nbins, color = "magenta", boundary = 0) +
    labs(
        title = paste("Distribution of", variable, "in 227 countries"),
        y = "Cumulative relative frequency"
    )

ggsave("Ex2plot.pdf", plot = last_plot(), path = "Projects-Live/PE/")