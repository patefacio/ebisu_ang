var connect = require('connect')
var express = require('express')
var http = require('http')
var app = connect()

console.log("Hello World");


app.use('/x', function fooMiddleware(req, res, next) {
    // req.url starts with "/foo"
    console.log(req);
    console.log("Trying food");
    res.writeHead(200, {"Content-Type": "text/plain"});
    res.end("Hello World\n");    
    //next();
});


app.use(express.static('project'));

http.createServer(app).listen(5000);

