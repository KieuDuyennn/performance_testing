# S8: Final Reflection

Reflection on team collaboration, technical learning, testing design trade-offs, and how AI support affected quality and efficiency (~300 words).

Before this seminar, "performance testing" was mostly a term we knew from slides, not
something we had actually done. The rule we set for ourselves early on was that every
member had to go through the same steps alone first, from a one-VU smoke test all the
way to a real baseline and spike run, and only compare notes afterward. It felt slower
at first, honestly a bit redundant, but it meant that when one of us hit something
strange, like the API suddenly returning 429s or an account getting locked after two
wrong passwords, we weren't just taking that person's word for it. Someone else had
usually hit the same wall independently, so by the time we wrote those down as failure
modes, we already trusted them.

The biggest thing we actually learned has almost nothing to do with k6 or JMeter
specifically. It is that the numbers you get out of a load test are only as good as the
workload you fed in. Cranking up the VU count felt like the obvious lever to pull, but
what actually changed our results was getting the browse, search, cart and checkout mix
and the think time right. Building that same workload twice, once in JMeter and once in
k6, ended up teaching us more than reading either tool's documentation would have. It
also made the tradeoff obvious in a way we couldn't have just been told: JMeter's GUI is
genuinely nicer for showing someone else what the test is doing, while k6's script felt
easier to actually reason about and adjust once we knew what we were doing.

AI was useful, but not in the way we expected going in. It was great for getting a first
draft of the report or the tool comparison out of a blank page. It was not great, and
sometimes confidently wrong, whenever we asked it something specific about how EShop
itself behaves, like its database concurrency or which auth method it used. We learned
to treat anything AI told us about our own system as a guess to verify, not a fact to
copy in.
