# CohesionWebKit

The Swift package the Cohesion Mac and iPad apps use to pair with `cohesiond`
and show its web UI.

It stands in for the page's session API that `cohesion open` provides
(`#token=`, `/client`, `/connect?token=` and the `WebSocket` the page uses),
so a change to that API changes this package, `cohesion open` and `web/` in
[cohesionhq/cohesion](https://github.com/cohesionhq/cohesion) together. See
`docs/serving-the-webui.md` there.
