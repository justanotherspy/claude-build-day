# Working demo 1: Model a realistic star system

Show a top-down animated model of a fictional star system: one star and six planets with invented names, distinct colours and orbits of clearly different sizes (outermost roughly ten times the innermost, so every orbit stays visible), at least one noticeably elliptical, and make it look like an elegant museum exhibit readable from across a room.

Beside the view show a live table per planet: semi-major axis, orbital period measured from the simulation itself once an orbit completes, the period predicted by Kepler's third law from the star's mass, and the percentage difference, highlighting a row green when they agree within one percent; also show total system energy with its relative drift since start as a percentage. Keep planet masses tiny compared to the star so the Kepler prediction is meaningful.

Let me click a planet to follow it, scroll to zoom, drag a time-speed slider, and press a button to add a new random planet on a bound orbit that doesn't cross the others, which starts being measured too and resets the energy-drift baseline.

Draw thin fading orbit trails on a dark starfield with a soft glow on the star, and start running immediately, framed to fit. Choose a default speed where the innermost planet completes an orbit in a few seconds and the outermost within about thirty seconds. Move the planets with real Newtonian gravity using a symplectic integrator (velocity Verlet), not pre-computed ellipses; change speed by varying simulation steps per frame with a fixed timestep, so energy stays conserved at every slider setting. Create it as one self-contained HTML file, no external libraries or assets.

Save it as `demo/star-system.html`, check it renders with a headless screenshot, then serve it with `./sprite-url.sh demo/star-system.html` and give me the URL.
