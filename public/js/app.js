'use strict'

var app = angular.module('WikiLinks', []);

app.controller('WikiLinks', ['$scope', function($scope){
	$scope.crrentlyViewing = 'startPage';
}]);