# AutoBar Forever test build

This is an experimental port of AutoBar to the WoW Forever beta. It loads Classic-era category and spell data on the client's modern addon API. The beta has only been checked with the separate API probe; the full addon has not yet been tested in game.

Install the `AutoBar` folder from the release ZIP in WoW Forever's `Interface/AddOns` directory. Do not install the entire repository or the `forever-probe` directory as AutoBar. At the character selection screen, enable AutoBar Forever. In game, use `/console scriptErrors 1`, reload, then try `/autobar config` and `/abfstatus`. The scriptErrors command has no confirmation message; it enables Lua error popups. Send the first Lua error in full, along with whether the bar and food, water and hearthstone buttons appear. Do not use old AutoBar saved variables for this test.

The ZIP is built with `python3 tools/package_forever.py OUTPUT.zip` from the repository root. The build installs the Forever TOC as `AutoBar/AutoBar.toc` and bundles only the shared engine, bundled libraries, and Classic content data.
