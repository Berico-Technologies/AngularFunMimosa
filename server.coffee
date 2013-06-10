express = require 'express'
engines = require 'consolidate'
_       = require 'lodash'

exports.startServer = (config, callback) ->

  nextId = 0
  people = [
    {"id": "#{nextId++}", "name": "Saasha", "age": "5"}
    {"id": "#{nextId++}", "name": "Planet", "age": "7"}
  ]
  
  examples = [
    { "id": "1", "desc": "First Example"  }
    { "id": "2", "desc": "Second Example" }
  ]

  isUniqueName = (name) ->
    (name for person in people when person.name is name).length is 0

  app = express()
  server = app.listen config.server.port, ->
     console.log "Express server listening on port %d in %s mode", config.server.port, app.settings.env

  app.configure ->
    app.set 'port', config.server.port
    app.set 'views', config.server.views.path
    app.engine config.server.views.extension, engines[config.server.views.compileWith]
    app.set 'view engine', config.server.views.extension
    app.use express.favicon()
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use express.compress()
    app.use app.router
    app.use express.static(config.watch.compiledDir)

  app.configure 'development', ->
    app.use express.errorHandler()

  options =
    reload:    if config.liveReload?.enabled? then config.liveReload.enabled
    optimize:  config.isOptimize ? false
    cachebust: if process.env.NODE_ENV isnt "production" then "?b=#{(new Date()).getTime()}" else ''

  app.get '/', (req, res) -> res.render 'index', options
  app.get '/people', (req, res) -> res.json people
  app.post '/people', (req, res) ->
    name = req.body.name
    message =
      "title": "Duplicate!"
      "message": "#{name} is a duplicate.  Please enter a new name."
    return res.send(message, 403) if not isUniqueName name
    person =
      "id": "#{nextId++}"
      "name": "#{name}"
      "age": "0"
    people.push person
    res.json person

  app.get '/people/details/:id', (req, res) ->
    id = req.params.id
    current = person for person in people when parseInt(person.id, 10) is parseInt(id, 10)
    res.json current
  
  getExampleById = (id) ->
    _.find examples, (example) -> example.id is id
      
  addExample = (example) -> 
    examples.push example
    
  updateExample = (id, desc) ->
    example = _.filter examples, (example) -> example.id is id
    if example[0]?
      example[0].desc = desc
      true
    else
      false
      
  deleteExample = (id) ->
    len = examples.length
    examples = _.reject examples, (example) -> example.id is id
    len > examples.length
  
  app.get "/examples", (req, res) -> res.json examples
  
  app.get "/examples/:id", (req, res) -> 
    console.log "Retrieving example with id: #{req.params.id}"
    example = getExampleById req.params.id
    if example?
      res.json example
    else
      res.send "Example with id #{req.params.id} does not exist.", 404
  
  app.put "/examples/", (req, res) ->
    console.log "Create example with id: #{req.params.id}"
    if req.body.id? and req.body.desc?
      addExample req.body
      res.send "Success", 201
    else
      res.send "Invalid example object", 400
      
  app.put "/examples/:id", (req, res) ->
    console.log "Creating example with id: #{req.params.id}"
    if req.params.id? and req.body.desc?
      addExample { id: req.params.id, desc: req.body.desc }
      res.send "Success", 201
    else
      res.send "Invalid example object", 400
  
  app.post "/examples/:id", (req, res) ->
    console.log "Updating example with id: #{req.params.id}"
    success = updateExample req.params.id, req.body.desc
    if success
      res.send "Success", 200
    else
      res.send "Failed to update object; didn't exist.", 404 
      
  app.delete "/examples/:id", (req, res) ->
    console.log "Deleting example with id: #{req.params.id}"
    success = deleteExample req.params.id
    if success
      res.send "Success", 200
    else
      res.send "Failed to delete object; didn't exist.", 404

  callback server