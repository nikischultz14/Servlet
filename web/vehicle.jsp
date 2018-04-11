<%--
  Created by IntelliJ IDEA.
  User: nikitaschultz
  Date: 2/8/18
  Time: 10:05 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>

<head>
    <link rel="stylesheet" href="./static/css/site.css" />
    <style>
        <%@ include file="./static/css/site.css"%>
    </style>
    <%--<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>--%>
    <title>Vehicle Information</title>
</head>

<body>

<div class="border">
<form name="addVehicle" action="./vehicle" method="post">
    <input type="hidden" name="formName" value="addVehicle" />
    <input type="hidden" name="vehicleId" value="${vehicleId}" />


    <%--<script>--%>
        <%--var vehicleModels = [];--%>

        <%--<c:forEach var="vm" items="${vehicleModelList}" varStatus="status">--%>
        <%--var model = {--%>
            <%--id:${vm.vehicleModelId}, name:"${vm.vehicleModelName}", make:${vm.vehicleMakeId}--%>
        <%--};--%>
        <%--vehicleModels.push(model);--%>
        <%--</c:forEach>--%>
        <%--console.log(vehicleModels);--%>

        <%--var vehicleMakes = [];--%>

        <%--<c:forEach var="vmm" items="${vehicleMakeList}" varStatus="status">--%>
        <%--var make = {--%>
            <%--id:${vmm.vehicleMakeId},  name:"${vmm.vehicleMakeName}"--%>
        <%--};--%>
        <%--vehicleMakes.push(make);--%>
        <%--</c:forEach>--%>
        <%--console.log(vehicleMakes);--%>

    <%--function showModels(str) {--%>
        <%--if (window.XMLHttpRequest) {--%>
            <%--var carModels = new XMLHttpRequest();--%>
        <%--} else {--%>
            <%--carModels = new ActiveXObject("Microsoft.XMLHTTP");--%>
        <%--}--%>

        <%--if (str == "") {--%>
            <%--document.getElementById("vehicleModels").innerHTML = "";--%>
            <%--return;--%>
        <%--}--%>
        <%--carModels.onreadystatechange = function() {--%>
            <%--if (this.readyState == 4 && this.status == 200) {--%>
                <%--document.getElementById("vehicleModels").innerHTML = this.responseText;--%>
            <%--}--%>
        <%--};--%>
        <%--carModels.open("GET", "VehicleServlet", true);--%>
        <%--carModels.send();--%>
    <%--}--%>


<%--</script>--%>


    <select name="selectMake" id="selectMake" onchange="showModels(str)" >
    <option value='0'>(Select Make)</option>
        <c:forEach var="vehicleMake" items="${vehicleMakeList}">
            <c:choose>
                <c:when test="${vehicleMake.vehicleMakeId == vehicleMakeId}">
                    <option selected value="${vehicleMake.vehicleMakeId}">${vehicleMake.vehicleMakeName} </option>
                </c:when>
                <c:otherwise>
                    <option value="${vehicleMake.vehicleMakeId}">${vehicleMake.vehicleMakeName} </option>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </select>
    ${selectMake}
    <br>
    <br>

    <%--<select name="selectModel" id="selectModel" >--%>

        <%--<option >(Please Select Make First) </option>--%>
    <%--</select>--%>


    <select name="selectModel" id="selectModel">
    <option value='0'>(Select Model)</option>
        <c:forEach var="vehicleModel" items="${vehicleModelList}" >
            <c:choose>
                <c:when test="${vehicleModel.vehicleModelId == vehicleModelId}">
                    <option selected value="${vehicleModel.vehicleModelId}">${vehicleModel.vehicleModelName} </option>
                </c:when>
                <c:otherwise>
                    <option value="${vehicleModel.vehicleModelId}">${vehicleModel.vehicleModelName} </option>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </select>
    ${selectModel}


<br>
    <br>
        <input type="hidden" name="formName" value="${vehicleId}" />

        <div>
            Plate: &nbsp;  <input type="text" name="licensePlate" value="${LicensePlate}" placeholder="License Plate" />
        </div>
        <br>
        <div>
            VIN: &emsp;   <input type="text" name="VIN" value="${VIN}" placeholder="VIN" />
        </div>
        <br>
        <div>
            Year: &ensp;  <input type="text" name="year" value="${Year}" placeholder="year" />
        </div>
        <br>
        <div>
            Color: &nbsp;  <input type="text" name="color" value="${Color}" placeholder="color" />
        </div>
        <br>


        <button type="submit">Add Vehicle</button>

        <br>
        ${addSuccessful}

    </form>

</div>

<br>
<br>

<div class="border2">

    <div class ="names">Plate &ensp; &ensp; VIN &ensp; &ensp; &ensp; Year &emsp; Color &ensp; Make  &nbsp; &emsp; &emsp; Model </div>


    <c:forEach var="vehicle" items="${vehicleList}" >
    <form name="updateOrDeleteVehicle" action="./vehicle" method="post">
        <input type="hidden" name="formName" value="updateOrDeleteVehicle" />
        <input type="hidden" name="vehicleId" value="${vehicle.vehicleId}" />
        <div>
            <input type="text" name="licensePlate"  size="15px" placeholder="${vehicle.licensePlate}" />
            <input type="text" name="VIN"  size="20px" placeholder="${vehicle.VIN}" />
            <input type="text" name="year"  size="10px" placeholder="${vehicle.year}" />
            <input type="text" name="color"  size="10px" placeholder="${vehicle.color}" />

        <select name="selectMake">
            <option value='0'>(Select Make)</option>
            <c:forEach var="vehicleMake" items="${vehicleMakeList}" >
                <c:choose>
                    <c:when test="${vehicleMake.vehicleMakeId == vehicle.vehicleMakeId}">
                        <option selected value="${vehicleMake.vehicleMakeId}">${vehicleMake.vehicleMakeName} </option>
                    </c:when>
                    <c:otherwise>
                        <option value="${vehicleMake.vehicleMakeId}">${vehicleMake.vehicleMakeName} </option>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </select>

        <select name="selectModel">
            <option value='0'>(Select Model)</option>
            <c:forEach var="vehicleModel" items="${vehicleModelList}" >
                <c:choose>
                    <c:when test="${vehicleModel.vehicleModelId == vehicle.vehicleModelId}">
                        <option selected value="${vehicleModel.vehicleModelId}">${vehicleModel.vehicleModelName} </option>
                    </c:when>
                    <c:otherwise>
                        <option value="${vehicleModel.vehicleModelId}">${vehicleModel.vehicleModelName} </option>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </select>

            <button type="submit" name="update">Update</button>
             <input type="hidden" name="formName" value="updateVehicle" />

            <button type="submit" name="delete">Delete</button>
            <input type="hidden" name="formName" value="deleteVehicle" />
        </div>
    </form>

    </c:forEach>
    ${updateSuccessful}
    ${deleteSuccessful}

    &nbsp;etc....

</div>

</body>

</html>



