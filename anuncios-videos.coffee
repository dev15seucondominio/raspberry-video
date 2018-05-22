############# HOW TO USE ###############
# require('./app/httpServer.coffee')
############# HOW TO USE ###############

request = require('request')

# express (like rails)
express = require 'express'
module.exports = (opt={}) ->
  # file_url = 'https://s3.amazonaws.com/rodrigo-erp/videos-exemplos-midia-indoor/RESUMO.mp4';
  # file_url = 'https://s3.amazonaws.com/rodrigo-erp/videos-exemplos-midia-indoor/COMPRAS+-+COTA%C3%87%C3%83O.mp4';
  # file_url = 'https://s3.amazonaws.com/rodrigo-erp/videos-exemplos-midia-indoor/Software+Seu+Condom%C3%ADnio-+Sistema+de+Administra%C3%A7%C3%A3o+Condominial+-+Aplicativo+de+Gest%C3%A3o+para+S%C3%ADndico.mp4';

  VIDEO_ID = 0

  download_file_httpget = (file_url)->
    options =
      port: 80
      host: url.parse(file_url).host
      path: url.parse(file_url).pathname

    file_name = url.parse(file_url).pathname.split('/').pop()
    DOWNLOAD_DIR = switch file_name.split('.').pop()
                    when 'mp4' then ENV.DOWNLOAD_VIDEOS
                    when 'jpg', 'png' then  ENV.DOWNLOAD_IMAGES
                    else console.log('FORMATO DESCONHECIDO')

    file = fs.createWriteStream( DOWNLOAD_DIR + file_name)

    http.get(options, (res)->
      res.on('data', (data)->
        file.write data
      ).on('end', ()->
        file.end()
        console.log file_name + ' downloaded to ' + DOWNLOAD_DIR
      )
    )

  check_list = (port, host)->
    params =
      port: port
      host: host
    http.get(params, (res)->
      res.on('data', (data)->
        for url in data.list
          download_file_httpget(url)
      ).on('end', ()->
        setTimeout check_list(port, host), 1000
      )
    )

  app = express()
  server = app.listen(ENV.HTTP_PORT)
  # app.use(express.static("."))
  app.use '/app/assets/javascripts', express.static(__dirname + '/app/assets/javascripts')

  console.log("HTTP #{ENV.HTTP_PORT} STARTING")

  # Resolve o erro do CROSS de Access-Control-Allow-Origin
  app.all '*', (req, res, next)->

    res.header 'Content-Type', 'application/json'
    res.header "Access-Control-Allow-Origin", "*"
    res.header 'Access-Control-Allow-Methods', 'OPTIONS,GET,POST,PUT,DELETE'
    res.header "Access-Control-Allow-Headers", "Content-Type, Authorization, X-Requested-With"
    if 'OPTIONS' == req.method
      return res.sendStatus(200)
    next()

  app.get '/', (req, res) ->
    console.log "Request GET / params: #{JSON.stringify(req.body)}"
    res.type("text/html")
    # res.send("<p>Hellow world</p>")
    res.sendFile(__dirname + '/app/assets/templates/reproduction_list/index.html')

  app.get '/public/css', (req, res) ->
    res.sendFile(__dirname + '/public/css/uikit.css')

  app.get '/app.js', (req, res) ->
    res.sendFile(__dirname + '/app/assets/templates/reproduction_list/app.js')

  app.get '/video', (req, res) ->
    VIDEO_ID = parseInt(req.query.id)
    console.log 'ID'
    console.log VIDEO_ID
    list_videos = fs.readdirSync 'downloads/videos/'
    VIDEO_ID = 0 if VIDEO_ID>=list_videos.length
    console.log list_videos
    console.log list_videos.length
    path = 'downloads/videos/' + list_videos[VIDEO_ID]
    stat = fs.statSync(path)
    fileSize = stat.size
    range = req.headers.range
    if range
      parts = range.replace(/bytes=/, '').split('-')
      start = parseInt(parts[0], 10)
      end = if parts[1] then parseInt(parts[1], 10) else fileSize - 1
      chunksize = end - start + 1
      file = fs.createReadStream(path, {start: start, end: end})
      string ="bytes #{start}-#{end}/#{fileSize}"
      head =
        'Content-Range': string
        'Accept-Ranges': 'bytes'
        'Content-Length': chunksize
        'Content-Type': 'video/mp4'
      res.writeHead 206, head
      file.pipe res
      console.log 'chunksize'
      console.log chunksize
      console.log('Começando o Video')
    else
      head =
        'Content-Length': fileSize
        'Content-Type': 'video/mp4'
      res.writeHead 200, head
      fs.createReadStream(path).pipe res
      console.log('Terminou o Video')


  app.get '/playlist', (req, res) ->
    list_videos = fs.readdirSync 'downloads/videos/'
    params =
      playlist_length: list_videos.length
    res.send JSON.stringify params

  # HTTPS
  fs = require('fs')
  url = require('url')
  http = require('http')
  https = require('https')
  httpsOpts =
    requestCert: false,
    rejectUnauthorized: false

  https.createServer(httpsOpts, app).listen ENV.HTTPS_PORT, ->
    console.log("HTTPS #{ENV.HTTPS_PORT} STARTING")
    # download_file_httpget(file_url)

