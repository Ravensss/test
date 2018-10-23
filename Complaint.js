/**
 * Created by cy on 2016-12-21.
 */
var complain = angular.module('complain', ['laAir', 'ngFileUpload']);
complain.controller('laAir_Infomation_ComplaintPageCtl', ['$filter', '$document','$http', '$scope', '$window', 'Upload', 'laUserService', 'laOrderService', 'laFlightService', 'laGlobalLocalService', function ($filter, $document,$http, $scope, $window, Upload, laUserService, laOrderService, laFlightService, laGlobalLocalService) {

    $scope.title = "投诉与建议";
    $document[0].title = $scope.title;
    /**
     * 设置导航栏ClassName
     * @type {boolean}
     */
    $scope.isHomeNav = true;
    $scope.complaintType = 1;
    $(".compKey div").find("p").click(function () {
        if ($(this).hasClass("comcheckbg")) {
            $(this).removeClass("comcheckbg");
        } else {
            $(this).addClass("comcheckbg");
        }
    });
    $scope.citys = [];

    $scope.selectCityClick = function (name, szm) {
        $("#CityList").hide();
        $("#InputDiv").show();
        if ($("#cityType").val() == "1") {
            $("#from").val(szm);
            $("#fromDisplay").val(name);
        }
        else {
            $("#to").val(szm);
            $("#toDisplay").val(name);
        }
    };

    function GetCityInfo() {
        $http.post('/Flight/GetAirportInfos').success(function (data) {
            $scope.citys = data;
        }).error(function (data) {
            //alert(data);
        });
    }

    GetCityInfo();
    $scope.complaint = function (event, comptype) {
        $(event.target).addClass("comcheckbg").parent().siblings().find("p").removeClass("comcheckbg");
        $scope.complaintType = comptype;
    }
    $scope.verifyCode = "";
    $scope.ImgVerifyCode = '';
    $scope.sessionId;
    $scope.userInfo = new laEntityUser();
    $scope.foIdTypeOptions = laEntityEnumfoIdTypeOptions;
    $scope.userInfo.FoidType = 1;
    /**
     * 设置导航栏ClassName
     * @type {boolean}
     */
    $scope.isSelfSrvNav = true;
    $scope.ParaCreateComplaint = {
        SaleChannel: 2,
        complain: {
            FeedbackType: 1,
            Keyword: "",
            TicketNo: "",
            FlightDate: "",
            FlightNo: "",
            PassengerName: "",
            MobilePhone: "",
            FOIDType: "",
            FOIDNumber: "",
            FromCity: "",
            ToCity: "",
            EMail: "",
            EventDesc: "",
            Enclosure: ""
        }
    };
    GetImageVerifyCode();
    $scope.btnResClick = function () {
        $("#compFlightNo").val("");
        $("#compName").val("");
        $("#compPhone").val("");
        $("#compDescribe").val("");
        $("#compMail").val("");
        $("#compFoldNo").val("");
        $("#compTickNo").val("");
    };
    $scope.btnChangeVerifyCode = function () {
        GetImageVerifyCode();
    };
    function GetImageVerifyCode() {
        $scope.ImgVerifyCode = '';
        laOrderService.ClientImageVerifyCodeForQueryOrderInfoWithoutLogin(function (backData, status) {
            var rs = backData;
            if (rs.Code == laGlobalProperty.laServiceCode_Success) {
                $scope.ImgVerifyCode = backData.ImageVerifyCode;
                $scope.sessionId = rs.SessionID;
            }
        });
    }

    $scope.btnQueryTicketClick = function () {
        var postdata = {
            FeedbackType: $scope.complaintType,
            Keyword: "",
            TicketNo: "891-" + $("#compTickNo").val(),
            FlightDate: $("#startTime").val(),
            FlightNo: "GJ"+$("#compFlightNo").val(),
            PassengerName: $("#compName").val(),
            MobilePhone: $("#compPhone").val(),
            FOIDType: $scope.userInfo.FoidType,
            FOIDNumber: $("#compFoldNo").val(),
            FromCity: $("#fromDisplay").val(),
            ToCity: $("#toDisplay").val(),
            //FromCity: "杭州",
            //ToCity: "北京",
            EMail: $("#compMail").val(),
            EventDesc: $("#compDescribe").val(),
            Enclosure: ""
        };
        //校验步骤
        if (laGlobalLocalService.CheckStringIsEmpty(postdata.PassengerName)) {
            bootbox.alert('请输入姓名');
            return;
        }
        if (laGlobalLocalService.CheckStringIsEmpty(postdata.MobilePhone) || !laGlobalLocalService.CheckStringLength(postdata.MobilePhone, 11)) {
            bootbox.alert('请输入正确的手机号');
            return;
        }
        if (laGlobalLocalService.CheckStringIsEmpty(postdata.FOIDNumber)) {
            bootbox.alert('请输入证件号');
            return;
        }
        if (postdata.FOIDType == 1) {
            if (!laGlobalLocalService.IdentityCodeValid(postdata.FOIDNumber)) {
                bootbox.alert('您的证件号码有误！请核对后再输入');
                return;
            }
        }
        if (laGlobalLocalService.CheckStringIsEmpty(postdata.EventDesc)) {
            bootbox.alert('请对该事件做一个描述！');
            return;
        }
        $scope.verifyCode = $("#compValidaImgCode").val();
        if (laGlobalLocalService.CheckStringIsEmpty($scope.verifyCode)) {
            bootbox.alert('请输入验证码');
            return;
        } if ($scope.complaintType == 3 || $scope.complaintType == 4) {
            if (laGlobalLocalService.CheckStringIsEmpty(postdata.FromCity)) {
                bootbox.alert('请输入出发城市');
                return;
            }
            if (laGlobalLocalService.CheckStringIsEmpty(postdata.ToCity)) {
                bootbox.alert('请输入到达城市');
                return;
            }
        }
       
        var keyLength = $(".compKey div").length;
        for (var i = 0; i < keyLength; i++) {
            if ($(".compKey div").eq(i).find("p").hasClass("comcheckbg")) {
                postdata.Keyword = postdata.Keyword + (i + 1) + ","
            }
        }
        $scope.ParaCreateComplaint.complain = postdata;



        $scope.ParaCreateComplaint.complain.Enclosure = "";
        laUserService.ClientSendCreateComplaint($scope.ParaCreateComplaint, $scope.verifyCode, $scope.sessionId, function (dataBack, status) {
            var rs = dataBack;
            if (rs.Code == '0000') {
                bootbox.alert("提交成功！", function (result) {
                    if (result) {
                        $window.location.href = 'Complaintsuggestions';
                    } else {
                        $window.location.href = 'Complaintsuggestions';
                    }
                });
            }
            else {
                bootbox.alert(dataBack.Message);
            }
        })




        if (document.getElementById("Pregnant_file").files != undefined || document.getElementById("Pregnant_file").files != null) {
            Upload.upload({
               //服务端接收
                //url: '/Flight/UploadEnclosure',
                url: 'ServiceQualityUploadEnclosure.ashx',
                //上传的同时带的参数
                data: { file: document.getElementById("Pregnant_file").files }
            }).success(function (data, status, headers, config) {
                $scope.ParaCreateComplaint.complain.Enclosure = data.FileGuid;
                laUserService.ClientSendCreateComplaint($scope.ParaCreateComplaint, $scope.verifyCode, $scope.sessionId, function (dataBack, status) {
                    var rs = dataBack;
                    if (rs.Code == '0000') {
                        bootbox.alert("提交成功！", function (result) {
                            if (result) {
                                $window.location.href = 'Complaintsuggestions';
                            } else {
                                $window.location.href = 'Complaintsuggestions';
                            }
                        });
                    }
                    else {
                        bootbox.alert(dataBack.Message);
                    }
                })
            }).error(function (data, status, headers, config) {
                bootbox.alert("失败！");
            });
        } else {
            $scope.ParaCreateComplaint.complain.Enclosure = "";
            laUserService.ClientSendCreateComplaint($scope.ParaCreateComplaint, $scope.verifyCode, $scope.sessionId, function (dataBack, status) {
                var rs = dataBack;
                if (rs.Code == '0000') {
                    bootbox.alert("提交成功！", function (result) {
                        if (result) {
                            $window.location.href = 'Complaintsuggestions';
                        } else {
                            $window.location.href = 'Complaintsuggestions';
                        }
                    });
                }
                else {
                    bootbox.alert(dataBack.Message);
                }
            })
        }


    };
}]);
function SelectCityFrom() {
    $("#CityList").show();
    $("#InputDiv").hide();
    $("#cityType").val("1");
}

function SelectCityTo() {
    $("#CityList").show();
    $("#InputDiv").hide();
    $("#cityType").val("2");
}
