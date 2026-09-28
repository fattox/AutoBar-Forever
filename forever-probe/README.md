# AutoBar Forever Probe

This is a diagnostic addon for the WoW Forever beta. It does not replace AutoBar or create usable bars. Its `/abforever` command reports the client version, available APIs, bag access and whether a secure snippet executes. The secure snippet check is skipped during combat.

Install the `AutoBarForeverProbe` folder from the ZIP into the Forever client's `Interface/AddOns` directory. Enable it on the character selection AddOns screen, log in, type `/abforever` out of combat, and send the chat report or a screenshot. Turn on Lua errors with `/console scriptErrors 1` and reload if the addon does not load.

The probe is kept separate from the original AutoBar addon so a beta API failure cannot disrupt an existing AutoBar installation.
