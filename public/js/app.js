'use strict';

var app = angular.module('WikiLinksApp', []);

app.controller('WikiLinksController', ['$scope', '$timeout', function($scope, $timeout){
	$scope.currentlyViewing = 'startPage';
	$scope.searchInput = '';
	$scope.currentDistance = 0;
	$scope.optimumDistance = 5;
	$scope.showOptimumDistance = false;
	$scope.links  = [];

	$scope.start = function(){
		$scope.currentlyViewing = 'inputPage';
	}
	function addOption(){
		$scope.currentDistance++;
	}
	$scope.addOption = addOption;
	// start;

	function hideButton(){
		$scope.showOptimumDistance = true;

		$timeout(showButton, 5000);
	}
	$scope.hideButton = hideButton;

	function showButton(){
		$scope.showOptimumDistance = false;
	}

	window.sc = $scope;
}]);