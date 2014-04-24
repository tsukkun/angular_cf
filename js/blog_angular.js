angular.module('sampleSearchApp', ['ui.bootstrap'])

function SearchResultCtrl($scope,$http,$log){
  $scope.filteredIssues = [];
  $scope.currentPage = 1;
  $scope.numPerPage = 5;

  $scope.$on('GoSearch',function(){
    $scope.emps = [];
    // console.log("http Search Rqeuest start");

    $http.get('blog.cfc?method=getEmpList&returnformat=json')
      .success(function (response) {
        // console.log("response=>" + response);
        console.log(response);
          if (angular.isArray(response)) {
            $scope.emps = response;
            $scope.totalItems = parseInt(response.length,10);                    
            $scope.perpage = 5;

            $scope.$watch('currentPage + numPerPage', function() {
              var begin = (($scope.currentPage - 1) * $scope.numPerPage)
              , end = begin + $scope.numPerPage;
            $scope.filteredEmps = $scope.emps.slice(begin, end);
            console.log($scope.filteredEmps);
            });
          } else {
            console.log("response is not Array!");
            $scope.totalItems = 0;
            $scope.emps=[];
            $scope.filteredEmps =[];
          }
    })
      .error(function (data, status, headers, config) {
        $log.log("data : ", data);
        $log.log("status : ", status);
        $log.log("headers : ", headers);
        $log.log("config : ", config);
    });
});
}