# Personal demo: Clawd's Fable, a pixel-art platformer

Build me a cute, fun 2D side-scrolling platformer called **Clawd's Fable**. It is a little storybook tale about Clawd, the Claude Code mascot, running right through a level and stomping out "AI slop" monsters, the glitchy creatures who speak only in AI writing tics. One self-contained HTML file, no libraries, no external assets, no network requests; every sprite, sound and font effect is generated in code so it runs from any static web server.

## The hero

Clawd is the playable character and must look like the actual Claude Code mascot, which in the terminal is drawn as:

```
 ▐▛███▛█
▝▜██████▀
  ▝▝ ▝▝
```

Read that as: a squat, slightly rounded rectangular body in Claude's brand terracotta orange (#D97757), a small notch cut into the top-left corner, two small dark rectangular eyes sitting where the gaps in the top row are, and four tiny stubby legs underneath. Build him as a pixel-art sprite roughly 16 to 20 pixels tall with a 3 to 4 frame run cycle where the little legs scurry, a jump pose, a squash frame on landing, and a blink every few seconds. Face him the direction he is moving.

## Controls and feel

- Left and right arrow keys run, space bar (or up arrow) jumps. Holding jump longer jumps higher, releasing early cuts the jump short. Allow a short coyote-time window after leaving a ledge and a small jump buffer.
- Fixed-timestep physics (for example 120 updates per second with an accumulator) rendered via requestAnimationFrame, so movement is identical at 60, 120 or 144 Hz and feels smooth at any refresh rate.
- Momentum with a little acceleration and skid, so he feels bouncy and alive rather than stiff.
- Landing on top of an enemy stomps it. Touching one from the side or below costs a life and knocks Clawd back with brief invincibility flashes.
- Falling in a pit costs a life. Three lives, respawn at the last checkpoint flag. Game over screen offers restart with Enter.

## The slop monsters

Weird, glitchy, slightly wrong-looking pixel creatures, each carrying a pixel-styled speech bubble with a short AI slop phrase from the list below. Bubbles should be crisp and readable on screen, so draw them at display resolution rather than the tiny internal pixel grid, with a pixel-style border and a little tail pointing at the creature. Cycle to a new phrase every few seconds, and pick randomly per spawn so no two nearby monsters say the same thing.

At least four types:

1. **Slop Blob**: a lumpy walker that patrols and turns at ledges. Its body colour flickers between two off tones and a few pixels tear sideways every second like a bad video frame. One stomp.
2. **Em Dash**: a flying, elongated black bar (the em dash glyph `—`) that drifts in a sine wave and darts at Clawd when he gets close. Its bubble only ever says "—". One stomp.
3. **Bullet Stack**: a stationary spiky column of bullet points. Cannot be stomped, must be jumped over. Bubble cycles "Firstly.", "Secondly.", "In conclusion.".
4. **Big Slop**: a level-end boss, three times the size, needs three stomps, gets faster and glitchier after each hit, and cycles the longest, most pompous phrases. Defeating it ends the level.

When a monster is stomped, it bursts into a shower of glitchy square particles, its bubble pops, and a small plain-English correction floats up and fades, for example stomping "That's the whole game." floats up "it's one part". Include eight to ten such pairs. Everything else just gets a punchy score popup.

## Speech bubble phrases (use these, not invented ones)

Short ones for small monsters:

"It's not this, it's that." / "Worth sitting with." / "That's the tell." / "Here's where it gets interesting." / "This is load-bearing." / "That's the whole game." / "Let's double-click on that." / "Let's unpack this." / "At the end of the day..." / "Lean into it." / "Paradigm shift!" / "The physics are different here." / "The risk lives in the gap." / "Tension is the engine." / "This is where it hits hardest." / "Let me surface that." / "The point is..." / "And that matters." / "That's the right question." / "I can't stop thinking about this." / "Leverage the throughline." / "Lessons learned." / "Hold that thought." / "Carry this with you." / "Everything points the same way." / "That stays yours." / "Worth a look." / "Honestly? It compounds." / "The word is doing the work." / "It's quietly doing the work." / "Nobody handed you that." / "Here's where I landed." / "We've seen this movie before." / "Nothing is settled." / "It rides along." / "It struck a chord." / "The shape of the trend." / "Names the move." / "A quieter version of this." / "Which brings me back to..." / "I'll leave you with this." / "I felt it in my chest." / "The real problem is..." / "A more mature version." / "The only thing that changed..." / "Sit with that." / "Reaching for gravitas." / "It's not a bug, it's a feature." / "So-and-so matters the most."

Longer ones for the boss:

"The question I keep coming back to..." / "I didn't plan it, but I can't unsee it." / "Dispatches from the frontier." / "First wave of a multi-year transition." / "Most people I've talked to agree." / "The thing that got me was..." / "Here's the analogy that clicked for me." / "The one that surprised me most." / "The best thing you can do is..." / "What I want you to see is..."

Correction pairs (stomp phrase, floating reply): "That's the whole game." > "it's one part" / "It's quietly doing the work." > "it's working" / "This is load-bearing." > "this is important" / "Let's unpack this." > "let's look" / "The risk lives in the gap." > "the risk is here" / "That's the tell." > "that's a clue" / "Worth sitting with." > "think about it" / "Honestly? It compounds." > "it adds up" / "Let me surface that." > "here it is" / "Paradigm shift!" > "a change"

## The level

Original art, but pace it like a classic first level: flat start to learn the controls, a few floating blocks, a first patrolling blob, a green pipe-like pillar to hop over, a small pit, a stretch with several monsters and an Em Dash overhead, a checkpoint flag halfway, a taller pillar section with a hidden bonus above, a wide pit needing a running jump, a staircase of blocks up to the boss arena, then the Big Slop, and finally a goal: a glowing terminal window with a blinking cursor that Clawd runs into to finish.

Scatter collectible **tokens**, little spinning coins with a `>` prompt glyph on them, for points. Include a few blocks that bounce when hit from below and drop a token.

## Score, timer, HUD

- Pixel HUD across the top: score, tokens, lives as tiny Clawd heads, and a countdown timer starting at 300 that ticks down once per second. Timer hitting zero costs a life.
- Stomps score 100, with a combo multiplier for consecutive stomps without touching the ground (200, 400, 800...). Tokens 50. Boss 1000. Remaining time converts to bonus points at the end.
- Level clear sequence: Clawd hops into the terminal, the screen irises out, a storybook page shows score breakdown, then the words "The End" with a small pixel Clawd, and Enter to play again.

## Look

- Pixel art throughout. Render the world to a small internal canvas (around 480 by 270) and scale it up with nearest-neighbour filtering and integer scaling to fit the window, keeping pixels crisp. HUD and speech bubbles may be drawn at display resolution for legibility but should still look pixel-styled.
- Three or four parallax background layers: distant sky gradient with a sun or moon, far hills or a city skyline of tiny terminal windows, nearer trees or cables, and foreground ground with grass tufts. Each scrolls at a different rate; a slow cloud layer drifts on its own.
- A warm, limited palette built around the terracotta orange with soft creams and a deep ink navy for outlines, and one sickly glitch green reserved for the slop.
- Minor particle effects: dust puffs when landing and turning, glitch bursts on stomps, sparkles on token pickup, confetti at the goal.
- Title screen framed like a storybook cover: "Clawd's Fable", a subtitle along the lines of "a small tale of defeating the slop", Clawd idling, and "press Enter to begin". Two or three lines of storybook intro text scroll before the level starts and can be skipped.

## Sound

Synthesize all sounds with the Web Audio API, no audio files: a short chirpy jump, a squelchy stomp with a rising pitch for combos, a bright ping for tokens, a low glitchy buzz for hits, a tiny fanfare at the checkpoint and a longer one at the goal, and a gentle looping chiptune melody, quiet by default. Browsers block audio until a user gesture, so start the audio context on the first key press. M toggles mute and the HUD shows the mute state.

## Quality bar

- Runs at the display's refresh rate with no jitter; no console errors; works in a fresh Chromium tab with no interaction required beyond the keyboard.
- Handles window resize, and pauses when the tab loses focus (P also pauses).
- Keep the code in one readable file with clear sections: config, sprites, level data, entities, physics, rendering, audio, and game states.

Save it as `demo/clawds-fable.html`, check it renders with a headless screenshot of the title screen and of the level after a simulated key press, then serve it with `./sprite-url.sh demo/clawds-fable.html` and give me the URL.
