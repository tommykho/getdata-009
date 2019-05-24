getdata-009
===========

Coursera Course Project: Getting and Cleaning Data (getdata-009)
ROOT folder

Written by tommyho510@gmail.com
===========
Please read the `README.md` in the `UCI HAR Dataset` folder

## Example of displaying htmlwidgets on a Github pages site

```{r}
# Source: http://www.htmlwidgets.org/showcase_plotly.html
library(plotly)
p <- ggplot(data = diamonds, aes(x = cut, fill = clarity)) +
            geom_bar(position = "dodge")
ggplotly(p)
```
