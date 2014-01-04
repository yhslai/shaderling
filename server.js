//setup Dependencies
var connect = require('connect')
    , express = require('express')
    , io = require('socket.io')
    , port = (process.env.PORT || 8080)
    , fs = require('fs')
    , path = require('path')
    , connectAssets = require('connect-assets')
    ;

//Setup Express
var server = express.createServer();
server.configure(function(){
    server.set('views', __dirname + '/views');
    server.set('view options', { layout: false });
    server.use(connect.bodyParser());
    server.use(express.cookieParser());
    server.use(express.session({ secret: "shhhhhhhhh!"}));
    server.use(connectAssets({
      src: 'static',
    }))
    server.use(connect.static(__dirname + '/static'));
    server.use(server.router);
});

//setup the errors
server.error(function(err, req, res, next){
    if (err instanceof NotFound) {
        res.render('404.jade', { locals: { 
                  title : '404 - Not Found'
                 ,description: ''
                 ,author: ''
                 ,analyticssiteid: 'XXXXXXX' 
                },status: 404 });
    } else {
        res.render('500.jade', { locals: { 
                  title : 'The Server Encountered an Error'
                 ,description: ''
                 ,author: ''
                 ,analyticssiteid: 'XXXXXXX'
                 ,error: err 
                },status: 500 });
    }
});
server.listen( port);

/*
//Setup Socket.IO
var io = io.listen(server);
io.sockets.on('connection', function(socket){
  console.log('Client Connected');
  socket.on('message', function(data){
    socket.broadcast.emit('server_message',data);
    socket.emit('server_message',data);
  });
  socket.on('disconnect', function(){
    console.log('Client Disconnected.');
  });
});
*/


///////////////////////////////////////////
//              Routes                   //
///////////////////////////////////////////

/////// ADD ALL YOUR ROUTES HERE  /////////

server.get('/', function(req,res){
  function render(templates, models) {
    res.render('index.jade', {
      locals : { 
        title : 'Shaderling | The Shader Editor in HTML5',
        description: 'An open-source, web-based GPU shader program editor.',
        author: 'Raincole Lai',
        analyticssiteid: 'XXXXXXX',
        templates: templates,
        models: models,
      }
    });
  }

  function mapDir(dir, mapping, callback) {
    fs.readdir(dir, function(err, files) {
      if(err) throw err;

      var count = 0;
      var results = [];

      files.forEach(function(filename) {
        count++;
        fs.readFile(dir + filename, 'utf-8', function(err, content) {
          if(err) throw err;

          results.push(mapping(filename, content))
          count--;
          if(count === 0) callback(results);
        });
      });
    });
  }


  mapDir('./views/templates/', function(filename, content) {
    return {
      name: path.basename(filename, '.html'),
      html: content,
    }
  }, function(templates) {
    mapDir('./views/models/', function(filename, content) {
      return {
        name: path.basename(filename, '.json'),
        model: content,
      }
    }, function(models) {
      render(templates, models);
    });
  });

});


//A Route for Creating a 500 Error (Useful to keep around)
server.get('/500', function(req, res){
    throw new Error('This is a 500 Error');
});

//The 404 Route (ALWAYS Keep this as the last route)
server.get('/*', function(req, res){
    throw new NotFound;
});

function NotFound(msg){
    this.name = 'NotFound';
    Error.call(this, msg);
    Error.captureStackTrace(this, arguments.callee);
}


console.log('Listening on http://0.0.0.0:' + port );
