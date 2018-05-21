
var app = angular.module("AnunciosVideos",[]);

app.controller('PrincipalCtrl', [ '$scope', '$http', function($s, $http){
  $s.anuncioVideo = {
    index:0,
    getPlaylist: function(video){
      $http({
        method: 'GET',
        url: '/playlist',
      }).then(function successCallback(resp) {
        $s.anuncioVideo.index++;
        if($s.anuncioVideo.index >resp.data.playlist_length-1) {
          $s.anuncioVideo.index = 0;
        };
        video.src = "http://localhost:3001/video?id="+$s.anuncioVideo.index;
      }, function errorCallback(error) {
        console.log('Error :$');
      });
    }
  }
}]);
