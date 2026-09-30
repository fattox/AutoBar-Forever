# AutoBar Forever test build

This is an experimental port of AutoBar to the WoW Forever beta. It loads Classic-era category and spell data on the client's modern addon API. Mage food and water conjuring and basic bars have been tested in game; other classes still need in-game checks.

Install the `AutoBar` folder from the release ZIP in WoW Forever's `Interface/AddOns` directory. At the character selection screen, enable AutoBar Forever. In game, use `/abfstatus` and `/abfwarnings` to check startup. Send the first Lua error in full if one appears. Keep your current AutoBar saved variables when updating from an earlier Forever test build.

The ZIP is built with `python3 tools/package_forever.py OUTPUT.zip` from the repository root. The build installs the Forever TOC as `AutoBar/AutoBar.toc` and bundles only the shared engine, bundled libraries, and Classic content data.
