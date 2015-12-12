'use strict';

var app = angular.module('WikiLinksApp', []);

app.controller('WikiLinksController', ['$scope', function($scope){
	$scope.currentlyViewing = 'startPage';

	$scope.start = function(){
		$scope.currentlyViewing = 'inputPage';
	}

	// start;

	window.sc = $scope;
}]);