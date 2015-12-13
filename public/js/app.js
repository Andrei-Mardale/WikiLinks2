'use strict';

var app = angular.module('WikiLinksApp', []);

app.controller('WikiLinksController', ['$scope', '$timeout','$http', function($scope, $timeout,$http){
	$scope.currentlyViewing = 'startPage';
	$scope.currentDistance = 0;
	$scope.optimumDistance = 0;
	$scope.showOptimumDistance = false;
	$scope.links  = [];
	$scope.source="";
	$scope.destination="";
	$scope.visited=[];
	$scope.currentLocation='';
	$scope.playing = true;
	$scope.percentage = 0;
	$scope.shortDist=[];
	$scope.corect = 0;

	$scope.chosen = [];
	var pleaseWaitDiv = $('<div class="modal" id="pleaseWaitDialog" data-backdrop="static" data-keyboard="false"><div class="modal-header" style="color:white"><h1>Processing...</h1></div><div class="modal-body"><div class="progress-bar"></div></div></div>');

	$scope.start = function(){
		$scope.currentlyViewing = 'inputPage';

		pleaseWaitDiv.modal();

		$http.get('/random')
          .success(function(data, status, headers, config) {
            $scope.source =  data["names"][0];
            $scope.destination =  data["names"][1];
            $scope.links = data["links"];
            $scope.optimumDistance = data["distance"];
            console.log(data);
            $scope.shortDist = data["path"];

           	pleaseWaitDiv.modal('hide');
            $scope.currentLocation = $scope.source;
          })
          .error(function(data, status, headers, config) {
            console.log('Error .');
          });
         
	}
	function addOption(){
		$scope.currentDistance++;

	}
	$scope.addOption = addOption;

	function hideButton(){
		$scope.showOptimumDistance = true;
		$timeout(showButton, 2000);
	}
	$scope.hideButton = hideButton;

	function showButton(){
		$scope.showOptimumDistance = false;
	}

	function choice(link){
		if($scope.destination === link){
			$scope.currentDistance++;
			$scope.visited.push(link);
			$scope.percentage=100;

			$scope.playing = false;
		}
		else{
			$scope.currentLocation = link;
			$scope.links = [];
			var endpoint = '/' + link;

		//console.log('endpoint'+endpoint);
		var i;
		for (i = 0; i < $scope.shortDist.length; ++i) {
			if (link === $scope.shortDist[i] && $scope.chosen[i] != 1 ) {
				$scope.corect++;
				$scope.chosen[i]=1;

				break;
			}
		}

		$http.get(endpoint)
		.success(function(data, status, headers, config) {
			$scope.links = data;
		})
		.error(function(data, status, headers, config) {
			console.log('Error .');
		});
		$scope.percentage = $scope.corect / $scope.optimumDistance * 100;

		$scope.currentDistance++;

		$scope.visited.push(link);
	}
}
	$scope.choice = choice;

	function restart(){
		$scope.playing = true;
		$scope.currentDistance = 0;
		$scope.optimumDistance = 0;
		$scope.showOptimumDistance = false;
		$scope.links  = [];
		$scope.source="";
		$scope.destination="";
		$scope.visited=[];
		$scope.currentLocation='';
		$scope.playing = true;
		$scope.percentage = 0;
		$scope.shortDist=[];
		$scope.corect = 0;
		$scope.chosen = [];

		this.start();
	}
	$scope.restart = restart;

	window.sc = $scope;
}]);