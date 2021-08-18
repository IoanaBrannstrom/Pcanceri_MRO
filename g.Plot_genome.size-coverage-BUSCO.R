#author: Ioana Onut Brännström

### script inspired from https://www.r-graph-gallery.com/320-the-basis-of-bubble-plot.html


# Libraries
library(ggplot2)
#library(dplyr)
#library(hrbrthemes)
#library(viridis)
#library(gridExtra)
#library(cowplot)


setwd("~/Dropbox/Project_Ascetosporea/Project_Paramykrocistos/Pcanceri_Figures/R_scripts/")
filename <- "Coverage_vs_assembly_size.csv"
my_data <- read.table(filename, sep=";", header=TRUE)


setwd("~/Dropbox/Project_Ascetosporea/Project_Paramykrocistos/Pcanceri_Figures/R_scripts/")
filename <- "Coverage_vs_assembly_size.csv"

#### Select a file and read the data into a data-frame
my_data <- read.table(filename, sep=";", header=TRUE)

### Bubbleplot BUSCO for each assembly
my_data2 <- my_data                                                 # Replicate original data
my_data2$assembly <- factor(my_data2$assembly,                                    
                            levels = my_data2$assembly[order(my_data2$BUSCO, decreasing = TRUE)]) # Factor levels in decreasing order
#levels = my_data2$assembly[order(my_data2$BUSCO)]) # Factor levels in increasing order


#### PLOT BUSCO

p1 <-ggplot (my_data2, aes(x=assembly, y=BUSCO, fill=assembly))+
  geom_bar(stat = "identity", alpha = 8/10, width=0.7) +
  scale_fill_manual(values=c('#666333','#b8e186','#cccc33','#4d9221', '#eb00eb', '#330066','#663399','#cc99ff')) + #this a good color blind frendly scheme
  xlab("Assembly") + 
  ylab("BUSCO %") +
  ylim(0, 100) +
  guides(fill=guide_legend(title="BUSCO values of each assembly")) +
  theme(legend.title = element_text(color = "black", size = 12, face = "bold"),
  axis.text.x = element_text(size = 10), axis.title.x = element_text(size = 10, face = "bold"),
  axis.text.y = element_text(size = 0), axis.title.y = element_text(size = 10, face = "bold"),
  legend.text = element_text(color = "black", size = 11),
  plot.margin = margin(1, 1, 1, 1, "cm"))+
  theme(legend.position = "none") +
  coord_flip()
p1

#base size = is the size of the y axis and x axis values

### Bubbleplot coverage, genome size, BUSCO

p2 <- ggplot(my_data, aes(x=assembly.size, y=coverage, size = BUSCO, color=assembly)) +
  geom_point(alpha=0.8)+
  geom_point(alpha=0.5, shape=21, color="black") +
  scale_size(range = c(6, 16), name="BUSCO percentage")+
  scale_color_manual(values=c( '#b8e186','#4d9221','#cccc33','#666333','#eb00eb','#330066','#cc99ff', '#663399'))+
  ylim(-2, 800) +
  xlim(-2, 5000) +
  theme(legend.title = element_text(color = "black", size = 12, face = "bold"),
        axis.text.x = element_text(size = 12), axis.title.x = element_text(size = 10, face = "bold"),
        axis.text.y = element_text(size = 12), axis.title.y = element_text(size = 10, face = "bold"),
        legend.text = element_text(color = "black", size = 11),
        plot.margin = margin(1, 1, 1, 1, "cm"))+
  ylab("Read coverage") +
  xlab("Assembly size (Mb)") 
p2


plot_grid(p1, p2, labels = "AUTO", rel_widths = c(1, 4), rel_heights = c(1, 1),  ncol=2)




ggsave('Fig.X.Busco_coverage_assembly.size.svg', plot=last_plot(), device=svg, bg='white', 
        path='~/Dropbox/Project_Ascetosporea/Project_Paramykrocistos/Pcanceri_Figures/R_scripts/', height = 150, width = 420, units = 'mm')


#666333 olive
#4d9221 verde 
#cccc33 mustar
#b8e186 verde deschis
#eb00eb magenta
#330066 mov inchis
#663399 mov mai deschis
#cc99ff lavanda

#theme_ipsum(base_size=19, base_family = "Arial", axis_title_size = 19, plot_margin = margin(30, 30, 30, 30), 
#grid=TRUE, grid_col = "#999999", axis_col="#666666", axis = TRUE, plot_title_size = 22)  +


