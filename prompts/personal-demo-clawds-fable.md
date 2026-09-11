# Personal demo: Clawd's Fable, a pixel-art platformer

Build me a cute, cheeky, funny 2D side-scrolling platformer called **Clawd's Fable**. It is a little storybook tale about Clawd, the Claude Code mascot, running right through one short level and stomping out the "AI slop": shambling, zombie-like blobs of broken output that mindlessly repeat AI writing tics. One self-contained HTML file, no libraries, no external assets, no network requests; every sprite, sound and font effect is generated in code so it runs from any static web server.

The whole run must be **beatable in about 90 seconds** by someone who has played it twice, and never longer than two minutes. Short, generous and fun beats long and hard. This is shown live at the end of a demo.

## The hero

Clawd is the playable character and must look like the actual Claude Code mascot, which in the terminal is drawn as:

```
 ▐▛███▛█
▝▜██████▀
  ▝▝ ▝▝
```

Read that as: a squat, slightly rounded rectangular body in Claude's brand terracotta orange (#D97757), a small notch cut into the top-left corner, two small dark rectangular eyes sitting where the gaps in the top row are, and four tiny stubby legs underneath. Build him as a pixel-art sprite roughly 16 to 20 pixels tall with a 3 to 4 frame run cycle where the little legs scurry, a jump pose, a squash frame on landing, and a blink every few seconds. Face him the direction he is moving.

Clawd talks. He has his own small speech bubble that pops up for about a second and a half at key moments, drawn from these lines (pick randomly within each group, never repeat the same one twice in a row):

- First sighting of a slop monster on screen: "ah, not more slop." / "oh no. it's writing again." / "who let this ship?"
- Stomping one: "concise." / "deleted." / "edited for clarity." / "shorter." / "that's a hyphen now." / "cut."
- Combo of three or more: "one sentence. one idea." / "reviewing... approved." / "clean diff."
- Taking a hit: "ouch. that's a lot of words." / "too verbose!" / "my context!"
- Losing a life: "context window exceeded." / "retrying..." / "rate limited."
- Collecting ten tokens: "tokens are cheap, taste isn't."
- Reaching the checkpoint: "checkpoint created." (with a tiny save icon)
- Meeting the boss: "great. a paragraph."
- Beating the boss: "TL;DR: no."
- Idling for five seconds: "waiting for input..." / "shall I proceed?" / "(thinking)"

## The slop monsters

Every enemy is a **slop blob**: a lumpy, droopy, zombie-like blob of "output" that looks like something went wrong in the render. They shamble slowly toward Clawd with little arms held out, heads lolling, eyes as mismatched glitchy pixels, and a permanent dopey open mouth. They are not scary, they are pathetic and funny.

Make them visibly broken and constantly changing:

- Their body cycles through wrong colour combinations every second or so (sickly green to washed-out purple to a corporate blue gradient to a static-noise grey), sometimes tearing horizontally like a dropped video frame, sometimes momentarily rendering as garbage pixels, then reforming.
- Their silhouette morphs too: a blob, then briefly a rectangular "text box" shape with fake grey lines in it, then a lumpy pile with a bullet-point pip, then a blob again. A few pixels always dribble off the bottom like they are leaking.
- Occasionally one hiccups out a tiny black em dash glyph (`—`) that floats up and fades, like a cough. Purely decorative on normal blobs.
- They walk into walls and turn around, fall into pits and keep walking, and never notice anything. Mindless.

Their speech bubbles carry the joke. Pixel-styled bubbles with a wobbly border and a little tail, drawn at display resolution so the text is crisp, in a slightly monotone all-lowercase style with trailing dots to sell the zombie mumble: "worth sitting with..." They mutter a new phrase every three or four seconds. Different blobs on screen must say different things. Add a faint low groan sound when a new phrase appears while the blob is on screen.

Variants (same blob DNA, small differences):

1. **Shambler**: the basic slow walker. One stomp.
2. **Hedger**: hops in place saying only hedging phrases ("it depends...", "to some extent...", "arguably..."). Jumps at Clawd if he stands next to it. One stomp.
3. **Big Chunk**: twice the size, waddles, splits into two Shamblers when stomped. Its bubble text is twice as long.
4. **The Great Question** (boss): a huge blob at the end of the level whose bubble opens with "great question!" and then cycles the longest, most pompous phrases. Two stomps to beat. After the first stomp it shrinks, flashes, and says "you're absolutely right!" then speeds up. Between stomps it coughs em dashes that arc across the arena and must be jumped over.

When a monster is stomped, it bursts into glitchy square particles, its bubble pops with a little "pop", and a small plain-English correction floats up and fades (see pairs below). Everything else just gets a punchy score popup.

## Speech bubble phrases (use these, not invented ones)

Short mumbles for Shamblers and Big Chunks:

"it's not this, it's that..." / "worth sitting with..." / "that's the tell..." / "here's where it gets interesting..." / "this is load-bearing..." / "that's the whole game..." / "let's double-click on that..." / "let's unpack this..." / "at the end of the day..." / "lean into it..." / "paradigm shift..." / "the physics are different here..." / "the risk lives in the gap..." / "tension is the engine..." / "this is where it hits hardest..." / "let me surface that..." / "the point is..." / "and that matters..." / "that's the right question..." / "i can't stop thinking about this..." / "leverage the throughline..." / "lessons learned..." / "hold that thought..." / "carry this with you..." / "everything points the same way..." / "that stays yours..." / "worth a look..." / "honestly? it compounds..." / "the word is doing the work..." / "it's quietly doing the work..." / "nobody handed you that..." / "here's where i landed..." / "we've seen this movie before..." / "nothing is settled..." / "it rides along..." / "it struck a chord..." / "the shape of the trend..." / "names the move..." / "a quieter version of this..." / "which brings me back to..." / "i'll leave you with this..." / "i felt it in my chest..." / "the real problem is..." / "a more mature version..." / "the only thing that changed..." / "sit with that..." / "reaching for gravitas..." / "it's not a bug, it's a feature..." / "so-and-so matters the most..." / "delve..." / "in today's fast-paced world..." / "certainly!..."

Hedger lines: "it depends..." / "to some extent..." / "arguably..." / "in many ways..." / "it's nuanced..." / "both are valid..."

Boss lines: "great question!" / "the question i keep coming back to..." / "i didn't plan it, but i can't unsee it..." / "dispatches from the frontier..." / "first wave of a multi-year transition..." / "most people i've talked to agree..." / "the thing that got me was..." / "here's the analogy that clicked for me..." / "the one that surprised me most..." / "the best thing you can do is..." / "what i want you to see is..." / "you're absolutely right!"

Correction pairs (stomped phrase, floating reply): "that's the whole game..." > "it's one part" / "it's quietly doing the work..." > "it works" / "this is load-bearing..." > "it's important" / "let's unpack this..." > "let's look" / "the risk lives in the gap..." > "the risk is here" / "that's the tell..." > "it's a clue" / "worth sitting with..." > "think about it" / "honestly? it compounds..." > "it adds up" / "let me surface that..." > "here it is" / "paradigm shift..." > "a change" / "delve..." > "look" / "certainly!..." > "ok"

## Extra gags

- Collectibles are **tokens**: little spinning coins with a `>` prompt glyph. The HUD counts them as "tokens: 37". At the end the bonus line reads "tokens spent wisely".
- Bounce blocks are marked "TODO". Hitting one from below changes it to "DONE" and drops a token. One block in the level is marked "FIXME" and drops three.
- Wooden pixel signs along the way with cheeky text: "slop ahead", "you've got this (you didn't need to be told that)", "please do not feed the slop", "no em dashes beyond this point", and near the boss "in conclusion".
- The checkpoint is a flag reading "v1". Touching it says "checkpoint created."
- The pause screen (P) shows a spinning pixel spinner and the word "thinking..." with a randomly chosen fake status underneath: "reticulating splines", "counting tokens", "considering the shape of the problem", "removing em dashes".
- Game over screen: "rate limit reached." with a "try again in 0s" line and "press enter".
- The level-clear storybook page ends with "The End." and a small line beneath: "(no notes.)"
- Intro storybook text, three short lines, something like: "Once upon a time, the internet filled up with slop. / It was not this. It was that. / One small orange creature had had enough." then "press Enter".

## Controls and feel

- Left and right arrow keys run, space bar (or up arrow) jumps. Holding jump longer jumps higher, releasing early cuts the jump short. Coyote time after leaving a ledge and a small jump buffer, so it feels forgiving.
- Fixed-timestep physics (for example 120 updates per second with an accumulator) rendered via requestAnimationFrame, so movement is identical at 60, 120 or 144 Hz and stays smooth at any refresh rate.
- Momentum with a little acceleration and skid, so Clawd feels bouncy and alive.
- Landing on top of an enemy stomps it and gives a small bounce. Touching one from the side costs a life and knocks Clawd back with brief invincibility flashes.
- Falling in a pit costs a life. Three lives, instant respawn at the last checkpoint (no long death animation), and losing all lives restarts from the checkpoint too, with the score reset. The player should never be stuck.

## The level (short!)

Original art, paced like a classic first level but compressed to about 90 seconds of play: a flat start with one Shambler to learn stomping, three floating TODO blocks, a pillar to hop, a small pit, a stretch with three Shamblers and a Hedger, the v1 checkpoint flag about halfway, a Big Chunk on a raised platform, one wide pit needing a running jump, a short staircase up to the boss arena, The Great Question, and a glowing terminal window with a blinking cursor that Clawd runs into to finish. Roughly 12 to 15 enemies total. No backtracking, no hidden requirements.

## Score, timer, HUD

- Pixel HUD across the top: score, tokens, lives shown as tiny Clawd heads, and a countdown timer starting at 150 that ticks once per second. Timer at zero costs a life and resets to 150 at the checkpoint.
- Stomps score 100, combo multiplier for consecutive stomps without touching the ground (200, 400, 800). Tokens 50. Boss 1000. Remaining seconds convert to bonus points at the end under the label "time saved".
- Level clear: Clawd hops into the terminal, the screen irises out, a storybook page shows the score breakdown, then "The End." and "(no notes.)", and Enter to play again.

## Look

- Pixel art throughout. Render the world to a small internal canvas (around 480 by 270) and scale up with nearest-neighbour filtering and integer scaling to fit the window, keeping pixels crisp. HUD and speech bubbles may be drawn at display resolution for legibility but should still look pixel-styled.
- Three or four parallax background layers: a soft sky gradient with a sun, far hills made of tiny terminal windows, nearer trees or dangling cables, and foreground ground with grass tufts. Each scrolls at a different rate; a slow cloud layer drifts on its own.
- A warm, limited palette built around the terracotta orange with soft creams and a deep ink navy for outlines. The slop gets the ugly colours: sickly green, washed purple, corporate gradient blue, static grey.
- Minor particle effects: dust puffs when landing and turning, glitch bursts on stomps, sparkles on tokens, confetti at the goal, little drips under every blob.
- Title screen framed like a storybook cover: "Clawd's Fable", subtitle "a small tale of defeating the slop", Clawd idling and blinking, one blob shambling past in the background muttering, and "press Enter to begin".

## Sound

Synthesize everything with the Web Audio API, no audio files: a short chirpy jump, a squelchy stomp with rising pitch on combos, a bright ping for tokens, a low glitchy buzz for hits, a soft zombie groan when a blob mutters, a tiny fanfare at the checkpoint, a longer one at the goal, and a gentle looping chiptune melody, quiet by default. Browsers block audio until a user gesture, so start the audio context on the first key press. M toggles mute and the HUD shows the mute state.

## Quality bar

- Runs at the display's refresh rate with no jitter, no console errors, and works in a fresh Chromium tab with nothing but the keyboard.
- Handles window resize and pauses when the tab loses focus.
- Keep the code in one readable file with clear sections: config, sprites, level data, entities, physics, rendering, audio, dialogue, and game states.

Save it as `demo/clawds-fable.html`, check it renders with a headless screenshot of the title screen and of the level after a simulated Enter and a few seconds of holding the right arrow, then serve it with `./sprite-url.sh demo/clawds-fable.html` and give me the URL.
