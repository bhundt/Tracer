# Tracer
Ray-Tracer written in Swift based on the Book of Jamis Buck

## TODO
- refactor Tuple: currently we have one struct which can be a Point or a Vector. The problem is that this distinction is not made via the Swift type system but only via the value of the "w" component. We should also replace our custom implementation with an SIMD accelerated one...
- add Lightning protocol: currently lights are note really abstracted in any way. We need to fix that to allow different types of light sources

## Ideas
- use Metal: https://developer.apple.com/videos/play/wwdc2020/10012/, https://www.willusher.io/graphics/2020/12/20/rt-dive-m1
- load scenes
- load Meshes
- Textures
- Normal Mapping
- UI for scene creation
