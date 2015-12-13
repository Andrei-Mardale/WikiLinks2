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

	var pleaseWaitDiv = $('<div class="modal" id="pleaseWaitDialog" data-backdrop="static" data-keyboard="false"><div class="modal-header"><h1>Processing...</h1></div><div class="modal-body"><div class="progress-bar"></div></div></div>');

	$scope.start = function(){
		$scope.currentlyViewing = 'inputPage';

		pleaseWaitDiv.modal();

		$http.get('/random')
          .success(function(data, status, headers, config) {
            $scope.source =  data["names"][0];
            $scope.destination =  data["names"][1];
            $scope.links = data["links"];
            console.log(data);

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

		console.log('endpoint'+endpoint);

		$http.get(endpoint)
          .success(function(data, status, headers, config) {
            $scope.links = data;
          })
          .error(function(data, status, headers, config) {
            console.log('Error .');
          });

        $scope.currentDistance++;

        $scope.visited.push(link);
	}
	$scope.choice = choice;

	window.sc = $scope;
}]);