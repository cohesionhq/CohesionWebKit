# CohesionWebKit

The Swift package the Cohesion Mac and iPad apps use to pair with `cohesiond`
and show its web UI.

It stands in for the page's session API that `cohesion open` provides
(`#token=`, `/client`, `/connect?token=` and the `WebSocket` the page uses),
so a change to that API changes this package, `cohesion open` and `web/` in
[cohesionhq/cohesion](https://github.com/cohesionhq/cohesion) together. See
`docs/serving-the-webui.md` there.

## How it serves the web UI

The package pairs with a server, keeps the bundle and serves it with no loopback
server at all:

- **Pairing** registers with `/register` as the iPhone app does, and keeps the
  certificate and key in the keychain (`PairingStore`). On a Mac running
  its own cohesiond, the app is instead a local client on the Unix socket,
  with a local key kept in the keychain beside it.
- **The bundle** is fetched with `webBundle` over a session of the app's
  own and unpacked under the app's caches directory, in a directory named
  by its hash, which a later launch reuses while `hello` carries the same
  hash.
- **Files** are served at `cohesion://app/` by a `URLSchemeHandler`, which
  also answers `GET /client`.
- **`/connect`** is carried by a script the web view runs before the page:
  it replaces `WebSocket` for that one URL with a stand-in that posts to a
  script message handler (`SocketBridge`), which opens a session for each
  socket and relays text frames both ways, as `cohesion open` relays them.
- **The token** is fresh for each load, handed over as `#token=` in the URL
  the page is opened at, and checked on `/client` and `/connect` as the
  proxy checks it.

The package exports ready-made views: `PairingForm` and `PairingView` for
pairing, `WebUIView` for a loaded UI, and `CohesionWebUI`, which shows
whichever of those a route calls for.
