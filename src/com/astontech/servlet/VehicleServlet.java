package com.astontech.servlet;

import Common.Helpers.ServletHelper;
import com.astontech.bo.Vehicle;
import com.astontech.bo.VehicleMake;
import com.astontech.bo.VehicleModel;
import com.astontech.dao.VehicleDAO;
import com.astontech.dao.VehicleMakeDAO;
import com.astontech.dao.VehicleModelDAO;
import com.astontech.dao.mysql.VehicleDAOImpl;
import com.astontech.dao.mysql.VehicleMakeDAOImpl;
import com.astontech.dao.mysql.VehicleModelDAOImpl;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;


@WebServlet(name = "VehicleServlet")
public class VehicleServlet extends HttpServlet {

    final static Logger logger = Logger.getLogger(VehicleServlet.class);
    private static VehicleDAO vehicleDAO = new VehicleDAOImpl();
    private static VehicleMakeDAO vehicleMakeDAO = new VehicleMakeDAOImpl();
    private static VehicleModelDAO vehicleModelDAO = new VehicleModelDAOImpl();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //submitting anything, post back

        switch(request.getParameter("formName")) {

            case "addVehicle":
                addVehicle(request);
                break;

            case "updateOrDeleteVehicle":
               if (request.getParameter("update") != null) {
                   updateVehicle(request);
               }
               else if (request.getParameter("delete") != null) {
                   deleteVehicle(request);
               }
               break;

            default:
                break;

        }

        List<Vehicle> vehicleList = vehicleDAO.getVehicleList();
        for(Vehicle vehicle : vehicleList) {
            VehicleModel vehicleModel = vehicleModelDAO.getVehicleModelById(vehicle.getVehicleModelId());
            vehicle.setVehicleMakeId(vehicleModel.getVehicleMakeId());
        }

        request.setAttribute("vehicleMakeList", vehicleMakeDAO.getVehicleMakeList());
        request.setAttribute("vehicleModelList", vehicleModelDAO.getVehicleModelList());
        request.setAttribute("vehicleList", (vehicleList));
        request.getRequestDispatcher("./vehicle.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //first time you hit a page

        List<Vehicle> vehicleList = vehicleDAO.getVehicleList();
        for(Vehicle vehicle : vehicleList) {
            VehicleModel vehicleModel = vehicleModelDAO.getVehicleModelById(vehicle.getVehicleModelId());
            vehicle.setVehicleMakeId(vehicleModel.getVehicleMakeId());
        }

        request.setAttribute("vehicleModelList", vehicleModelDAO.getVehicleModelList());
        request.setAttribute("vehicleMakeList", vehicleMakeDAO.getVehicleMakeList());
        request.setAttribute("vehicleList", (vehicleList));
        request.getRequestDispatcher("./vehicle.jsp").forward(request, response);
    }

    private static void addVehicle(HttpServletRequest request) {
        logger.info("Form 1 Form Name=" + request.getParameter("formName"));
        ServletHelper.logRequestParams(request);

        String selectedVehicleMakeId = request.getParameter("selectMake");
        VehicleMake selectedVehicleMake = vehicleMakeDAO.getVehicleMakeById(Integer.parseInt(selectedVehicleMakeId));

        logger.info("Vehicle Make details: " + selectedVehicleMake.toString());

        String selectedVehicleModelId = request.getParameter("selectModel");
        VehicleModel selectedVehicleModel = vehicleModelDAO.getVehicleModelById(Integer.parseInt(selectedVehicleModelId));

        logger.info("Vehicle Model details: " + selectedVehicleModel.toString());

        Vehicle addedVehicle = new Vehicle();
        initialRequestToVehicle(request, addedVehicle);

        logger.info(addedVehicle.toString());

        if(vehicleDAO.insertVehicle(addedVehicle) > 0)
            request.setAttribute("addSuccessful", "Vehicle added to Database Successfully!");
        else
            request.setAttribute("addSuccessful", "Vehicle add FAILED!");

    }

    private static void updateVehicle(HttpServletRequest request) {
        logger.info("form 2 - form name=" + request.getParameter("formName"));
        ServletHelper.logRequestParams(request);

        Vehicle updatedVehicle = new Vehicle();
        updateRequestToVehicle(request, updatedVehicle);

        if(vehicleDAO.updateVehicle(updatedVehicle))
            request.setAttribute("updateSuccessful", "Vehicle updated in Database successfully!");
        else
            request.setAttribute("updateSuccessful", "Vehicle update FAILED!");
    }

    private static void deleteVehicle(HttpServletRequest request) {
        logger.info("form 3 - form name=" + request.getParameter("formName"));
        ServletHelper.logRequestParams(request);

        if(vehicleDAO.deleteVehicle(Integer.parseInt(request.getParameter("vehicleId"))))
            request.setAttribute("deleteSuccessful", "Vehicle deleted successfully!");
        else
            request.setAttribute("deleteSuccessful", "Vehicle delete FAILED!");
    }

    private static void initialRequestToVehicle(HttpServletRequest request, Vehicle vehicle) {
        vehicle.setLicensePlate(request.getParameter("licensePlate"));

        if(request.getParameter("VIN").isEmpty())
            vehicle.setVIN(Integer.parseInt("0"));
        else
            vehicle.setVIN(Integer.parseInt(request.getParameter("VIN")));

        if(request.getParameter("year").isEmpty())
            vehicle.setYear(Integer.parseInt("0"));
        else
            vehicle.setYear(Integer.parseInt(request.getParameter("year")));

        vehicle.setColor(request.getParameter("color"));
        vehicle.setVehicleModelId(Integer.parseInt(request.getParameter("selectModel")));

    }

    private static void updateRequestToVehicle(HttpServletRequest request, Vehicle vehicle) {
        vehicle.setVehicleId(Integer.parseInt(request.getParameter("vehicleId")));
        vehicle.setVehicleModelId(Integer.parseInt(request.getParameter("selectModel")));

        if(request.getParameter("licensePlate") != null)
            vehicle.setLicensePlate(request.getParameter("licensePlate"));
        else
            vehicle.setLicensePlate(null);

        if(request.getParameter("VIN").isEmpty())
            vehicle.setVIN(Integer.parseInt("0"));
        else
            vehicle.setVIN(Integer.parseInt(request.getParameter("VIN")));

        if(request.getParameter("year").isEmpty())
            vehicle.setYear(Integer.parseInt("0"));
        else
            vehicle.setYear(Integer.parseInt(request.getParameter("year")));

        if(request.getParameter("color") != null)
            vehicle.setColor(request.getParameter("color"));
        else
            vehicle.setColor(null);
    }


    }



































