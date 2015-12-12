'use strict';

var app = angular.module('WikiLinksApp', []);

app.controller('WikiLinksController', ['$scope', function($scope){
	$scope.currentlyViewing = 'startPage';
	$scope.currentDistance = 0;
	$scope.start = function(){
		$scope.currentlyViewing = 'inputPage';
	}
	function addOption(){
		$scope.currentDistance++;
	}
	$scope.addOption = addOption;
	// start;

	window.sc = $scope;
}]);