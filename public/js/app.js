'use strict';

var app = angular.module('WikiLinksApp', []);

app.controller('WikiLinksController', ['$scope', '$timeout','$http', function($scope, $timeout,$http){
	$scope.currentlyViewing = 'startPage';
	$scope.searchInput = '';
	$scope.currentDistance = 0;
	$scope.optimumDistance = 5;
	$scope.showOptimumDistance = false;
	$scope.links  = [];
	$scope.source="";
	$scope.destination="";
	$scope.visited=[];
	$scope.currentLocation='';
	$scope.percentage = 0;
	$scope.shortDist=[];
	$scope.corect = 0;
	$scope.start = function(){
		$scope.currentlyViewing = 'inputPage';
		$http.get('/random')
          .success(function(data, status, headers, config) {
            $scope.source =  data["names"][0];
            $scope.destination =  data["names"][1];
            $scope.links = data["links"];
            $scope.optimumDistance = data["distance"];
            console.log(data);
            $scope.shortDist = data["path"];
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
	// start;

	function hideButton(){
		$scope.showOptimumDistance = true;
		$timeout(showButton, 2000);
	}
	$scope.hideButton = hideButton;

	function showButton(){
		$scope.showOptimumDistance = false;
	}

	function choice(link){
		$scope.currentLocation = link;
		$scope.links = [];
		var endpoint = '/' + link;

		//console.log('endpoint'+endpoint);
		var i;
		for (i = 0; i < $scope.shortDist.length; ++i) {
			if (link === $scope.shortDist[i]) {
				$scope.corect++;	
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
	$scope.choice = choice;

	window.sc = $scope;
}]);