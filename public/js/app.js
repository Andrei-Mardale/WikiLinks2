'use strict'

var app = angular.module('WikiLinks', []);

app.controller('WikiLinksController', ['$scope', function($scope){
	$scope.crrentlyViewing = 'startPage';

	function start(){
		$scope.currentlyViewing = 'inputPage';
	}

	$window.sc = $scope;
}]);