"use strict";

const routes = require("./routes");

const isEndSlash = (route) => {
  const filename = route.split("/").pop();

  return !filename;
};
const notHtmlPath = (route) => {
  const routeStrArr = route.split(".");
  routeStrArr.shift();
  const extension = routeStrArr.pop();
  return !!extension && !extension.match(/html?$/);
};
const dynamicRouting = (url) => {
  if (url === "/") return "/index.html";
  for (let route of routes) {
    if (url === route) return `${route}.html`;
    const rulePlaceHolder = /\[[^/].*\]/g;
    if (!route.match(rulePlaceHolder)) continue;
    const matchCase = new RegExp(route.replace(rulePlaceHolder, "[^/].*"));
    if (url.match(matchCase)) {
      return `${url.replace(matchCase, route)}.html`;
    }
  }
  return "/404.html";
};
exports.handler = (event, _context, callback) => {
  const request = event.Records[0].cf.request;
  if (isEndSlash(request.uri)) {
    const response = {
      status: "302",
      statusDescription: "Found",
      headers: {
        location: [
          {
            key: "Location",
            value: request.uri.replace(/\/*$/, "") || "/",
          },
        ],
      },
    };
    callback(null, response);
    return;
  }
  if (notHtmlPath(request.uri)) {
    callback(null, request);
    return;
  }
  request.uri = dynamicRouting(request.uri.replace(".html", ""));
  callback(null, request);
  return;
};
