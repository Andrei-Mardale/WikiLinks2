'use strict';

var app = angular.module('WikiLinksApp', []);

app.controller('WikiLinksController', ['$scope', '$timeout', function($scope, $timeout){
	$scope.currentlyViewing = 'startPage';
	$scope.searchInput = '';
	$scope.currentDistance = 0;
	$scope.optimumDistance = 5;
	$scope.showOptimumDistance = false;
	$scope.links  = [];
	$scope.source="";
	$scope.destination="";
	$scope.start = function(){
		$scope.currentlyViewing = 'inputPage';
		$http.get('/random')
          .success(function(data, status, headers, config) {
            $scope.source =  data["names"][0][0]["title"];
            $scope.destination =  data["names"][1][0]["title"];

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
		$timeout(showButton, 3000);
	}
	$scope.hideButton = hideButton;

	function showButton(){
		$scope.showOptimumDistance = false;
	}

	window.sc = $scope;
}]);