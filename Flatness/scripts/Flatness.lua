
--Start of Global Scope---------------------------------------------------------

print('AppEngine Version: ' .. Engine.getVersion())

local DELAY = 2000 -- ms between visualization steps for demonstration purpose

-- Create a viewer
local v = View.create()

local imageDec=View.ImageDecoration.create():setRange(0, 10)

local pixelRegionDec=View.PixelRegionDecoration.create():setColor(0, 127, 195, 120)

local pixelRegionDec2=View.PixelRegionDecoration.create():setColor(200, 127, 0, 120)

--End of Global Scope-----------------------------------------------------------

--Start of Function and Event Scope---------------------------------------------
local function handleOnStarted()
  --Load a heightmap image
  local heightmap = Object.load('resources/heightmap.json')

  -- Select what should be considered noise
  local noiseThreshold = 2.0 -- mm

  -- Select a kernel size for the algorithm neighborhood
  local kernelSize = 15

  -- There is one faster and one more precise algorithm to chose from
  local useFast = true

  -- Pre-processing by smoothing is sometimes a good idea, but not required.
  -- For this image the noise levels are low enough without.
  -- heightmap = Image.gauss(heightmap, 5)

  -- Show the original heightmap
  v:clear()
  v:addImage(heightmap)
  v:present()
  Script.sleep(DELAY) -- for demonstration purpose only

  --Create a flatness image
  local flatnessImage = Image.getFlatness(heightmap, kernelSize, useFast)

  -- Show the flatness image
  v:clear()
  v:addImage(flatnessImage, imageDec)
  v:present()
  Script.sleep(DELAY) -- for demonstration purpose only

  --Threshold the flatness image and obtain a pixelregion for visualization purposes
  local flatnessRegionFromImage = flatnessImage:threshold(0, noiseThreshold)

  -- Show the flat region as overlay on the input image
  v:clear()
  v:addImage(heightmap, imageDec)
  v:addPixelRegion(flatnessRegionFromImage, pixelRegionDec)
  v:present()
  Script.sleep(DELAY) -- for demonstration purpose only

  -- Run getFlatRegion on a part of the input image
  local rect=Shape.createRectangle(Point.create(40,80), 50, 50)
  local rectPixReg=rect:toPixelRegion(heightmap, true)

  --Create a flatness pixel region inside the input pixelregion
  local flatnessRegion = Image.getFlatRegion(heightmap, noiseThreshold, kernelSize, useFast, rectPixReg)

  v:clear()
  v:addImage(heightmap, imageDec)
  v:addPixelRegion(flatnessRegionFromImage, pixelRegionDec)
  v:addPixelRegion(flatnessRegion, pixelRegionDec2)
  v:present()

  print('App finished.')
end
Script.register('Engine.OnStarted', handleOnStarted)

--End of Function and Event Scope--------------------------------------------------
