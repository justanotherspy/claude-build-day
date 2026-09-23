# Working demo 3: A four-stroke engine built from equations

Build me an interactive, visually stunning simulation of a four-stroke car engine, from first principles. Compute the thermodynamics live: fuel burning, pressure on the pistons, torque, and the exhaust pulses turned into engine sound. Pressure must come from the gas state each step (ideal gas, finite-rate combustion, adiabatic compression and expansion), not a pre-computed loop. Engine speed should evolve from net torque against friction and a simple load, so RPM settles to a steady value for each throttle position.

Draw the engine as a big animated cutaway — pistons, connecting rods, crankshaft, valves, the spark and the flame — with the pressure–volume loop drawn in real time next to it, work per cycle integrated live from the area inside the loop.

Give me a throttle slider, an RPM readout, and a way to switch between 1, 4 and 8 cylinders, and make it beautiful. Browsers block audio until a click, so start the sound on the first click and include a visible mute button. A single HTML file, no external libraries, 60 fps, correct the first time it opens.

Save it as `demo/four-stroke-engine.html`, check it renders with a headless screenshot, then serve it with `./sprite-url.sh demo/four-stroke-engine.html` and give me the URL.
