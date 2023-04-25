## Flatness

Measuring the flatness in an image and obtaining a region where the image is flat.

### Description

GetFlatness calculates a flatness measure for each pixel in an image. A pixel with a value close to zero means approximate coplanarity with its neighbors. The algorithm fits a plane to a local neighborhood around each pixel and gives out the maximum deviation from the plane over all pixels in the neighborhood.
GetFlatRegion returns the region where this flatness measure is within a given threshold.

### How to Run

Starting this sample is possible either by running the App (F5) or
debugging (F7+F10). Setting breakpoint on the first row inside the 'main'
function allows debugging step-by-step after 'Engine.OnStarted' event.
Results can be seen in the image viewer on the DevicePage.
Restarting the Sample may be necessary to show images after loading the web-page.
To run this Sample a device with SICK Algorithm API and AppEngine >= V2.11.0 is
required.

### Topics

algorithm, image-2d, filtering, arithmetic, sample, sick-appspace
