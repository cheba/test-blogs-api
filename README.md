# API test application

This is a simple API implementation with access control on a model level.

## Notes

* This is a very primitive implementation. I tried to achieve this in the least
  possible time — 5.5h in total — thus many features that are common or nice to
  have in an API have been left out.
* There's no real request/response format or protocol in this implementation.
  For a real API I'd go for [JSON API](http://jsonapi.org/).
* Error reporting is rudimentary.
* No scoping for `index` action.
* No scoping for "nested" resources.
* No filtering, sorting, or pagination.
* Only integration tests because that's enought for this kind of project (dumb
  models, simplistic controllers, etc.).
* No documentation. See tests for examples of use.
