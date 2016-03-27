# firebase-haskell-client

_DEVELOPMENT_
- an environment variable is needed called "FIREBASE_CONF". It points to a file where you have
  - as a first line your Firebase Secret key
  - as a second line your Firebase root URL complete with a trailing slash
- you need to add a JSON to your root as `{"haskell":"awesome"}` to pass the integration test

Meeting 20160301:

* stack or cabal? stack
* sync or async? sync for now
* wreq or something more lightweight?
* what does it return? let's start with a string
* validate user input (for POSTs and such)

Possible modules:
* Auth
* REST operations
* JSON handling

Basic Use Case:
The library user has
* auth information (probably wrapped inside a JSON Object)
* a URL
* a HTTP Operation that he wants to perform
* EITHER a JSON Object that he wants to insert / update
* OR an identifier or range of identifiers (in JSON format?) for Objects he wants to retrieve.

He expects as a result either
* An confirm message in case of an insert/update
* an error message
* the requested object(s) in JSON format
