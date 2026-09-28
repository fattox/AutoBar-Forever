"""Package the Forever test target as an installable AutoBar addon folder."""

import sys
from pathlib import Path
from zipfile import ZIP_DEFLATED, ZipFile


def main() -> None:
    if len(sys.argv) != 2:
        raise SystemExit("usage: python3 tools/package_forever.py OUTPUT.zip")
    root = Path(__file__).resolve().parents[1]
    toc = root / "forever" / "AutoBar.toc"
    output = Path(sys.argv[1]).resolve()

    # Check all Lua/XML files referenced directly by the manifest.
    files = set()
    for line in toc.read_text(encoding="utf-8").splitlines():
        entry = line.strip()
        if entry and not entry.startswith("#"):
            path = root / entry
            assert path.is_file(), f"missing TOC entry: {entry}"
            files.add(path)

    for directory in ("libs", "classic", "locale", "Textures"):
        files.update(p for p in (root / directory).rglob("*") if p.is_file())

    with ZipFile(output, "w", ZIP_DEFLATED) as archive:
        archive.write(toc, "AutoBar/AutoBar.toc")
        archive.write(root / "forever" / "README.md", "AutoBar/FOREVER-README.md")
        for path in sorted(files):
            archive.write(path, "AutoBar/" + path.relative_to(root).as_posix())
    with ZipFile(output) as archive:
        assert archive.testzip() is None
    print(output)


if __name__ == "__main__":
    main()
