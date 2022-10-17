library(argparse)
library(ggplot2)
library(plyr)

parser<-ArgumentParser()
parser$add_argument('-i', '--input', metavar='input', help='Input directory', default="K:/docs/gc_plots")
parser$add_argument('-o', '--output', metavar="OUTPUT", help="Output file name", default="gc_content_plot.pdf")

args <- parser$parse_args()

set.seed(666)

fnames <- sub("_gcf.txt", "", list.files(args$input, full.names=TRUE, pattern="*_gcf.txt"))

number_files <- length(fnames)

sample_size <- min(length(fnames), 500)

fnames <- sample(fnames, size=sample_size)

gcf_data <-
  ldply(fnames, function(fname) { data.frame(fn=fname, read.table(paste0(fname, "_gcf.txt"), sep="\t", header=FALSE)) })

gcl_data <-
  ldply(fnames, function(fname) { data.frame(fn=fname, read.table(paste0(fname, "_gcl.txt"), sep="\t", header=FALSE)) })

pdf(args$output, 7,5)

theme_update(plot.title=element_text(hjust=0.5))

p <- ggplot() +
     geom_line(data=gcf_data, aes(x=V1, y=V2, group=fn, color="First")) +
     geom_line(data=gcl_data, aes(x=V1, y=V2, group=fn, color="Last", alpha=I(0.4))) +
     scale_color_manual(name="Strand", values = c("black", "orange")) +
     ggtitle(paste0("GC distribution - Sample Size: ", sample_size, " of ", number_files)) +
     xlab("Mean GC content (%)") +
     ylab("")

plot(p)

invisible(dev.off())
