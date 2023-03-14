# Measure diameters of microparticles

This repository may be useful for data analysis on large datasets of microscopic images of microparticles.

Consider a case where you have to manually measure the diameters of microparticles in ImageJ. Here, we converted images to .png format. From there, we cropped out the scale bar. Then we created a binary image showing only microparticles. The outlines of each microparticle were then filled in. We created a labeling matrix to count the number of objects. Next, the diameters were measured. This required converting the measurements from pixels to micrometers. The outlier diameters caused by errors in thresholding were removed. This GUI displays the diameters for each image in a histogram.
