"use strict";

// WARNING: 新しいDynamic Routeを追加する度に更新の必要がある
// NOTE: Static RouteはDynamic Routeより先に検証する必要がある
module.exports = [
  "/index",
  "/page1",
  // NOTE: ネストしたルーティングは先に書く必要がある
  "/dynamics/[id]/nested",
  "/dynamics/[id]",
];
