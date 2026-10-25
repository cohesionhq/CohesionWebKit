# CLAUDE.md

CohesionWebKit: the Swift package the Cohesion Mac and iPad apps use to pair
with `cohesiond`, connect to it, and show its web UI. `README.md` describes
how it serves the UI. Its consumers are
[cohesion-mac](https://github.com/cohesionhq/cohesion-mac) and
[cohesion-ipad](https://github.com/cohesionhq/cohesion-ipad), which use it as
a local package from a sibling checkout; the daemon and web UI live in
[cohesionhq/cohesion](https://github.com/cohesionhq/cohesion).

## The page's side is a stable API

This package stands in for what `cohesion open` gives the page: the token in
`#token=`, `GET /client` and its status, `/connect?token=` on the page's own
host, and the parts of `WebSocket` the page uses (the bridge's stand-in
implements those and no more). Change them together with `cohesion open` and
`web/` in cohesionhq/cohesion, or not at all; see "The page's side is a
stable API" in its `docs/serving-the-webui.md`.

## Design principles

- **One copy for both apps.** Pairing, connections, the bundle and the
  bridge live here once; an app adds only what is its own.
- **Lean on the type system.** An enum rather than a string or a pair of
  bools; fields that only make sense for one case live in that case.
- **No speculative generality.** No options or layers with one caller.

## Ask before deciding

Jackson would rather answer a question than review a guess. Ask, with a
short recommendation, before an architecture decision (a new dependency,
public API, or a change to the stable API above or to what pairing trusts),
and before UI strings or docs prose whose wording is open: offer two or
three candidates that follow "Copy" in cohesionhq/cohesion's
`web/README.md`.

## Trust model

Before pairing only `/register` with the setup code is open; after it the
server's key is pinned and the server is trusted. The token is fresh for
each load and checked on `/client` and `/connect`. Validate there and
nowhere else.

## Conventions

- Main actor by default with approachable concurrency, as the apps build
  (`Package.swift`).
- Match the surrounding comment density and naming.

## Building

```sh
swift build
```

Build both apps too after changing a public API.
