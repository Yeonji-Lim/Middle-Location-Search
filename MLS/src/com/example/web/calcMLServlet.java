package com.example.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.example.model.JamaExpert;


/**
 * Servlet implementation class calcMLServlet
 */
@WebServlet("/calcMLServlet")
public class calcMLServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public calcMLServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		//String json_str = request.getParameter("locations");
		String json_str = "[{ \"lat\": \"1\", \"lng\":\"1\" }, { \"lat\": \"3\", \"lng\":\"-1\" }, { \"lat\": \"0\", \"lng\":\"4\" }, { \"lat\": \"5\", \"lng\":\"6\" },]";
		JSONParser parser = new JSONParser();
		JSONArray arr = null;
		JSONObject obj = null;
		 
		try {
		     arr = (JSONArray)parser.parse(json_str);
		} catch (ParseException e) {
		     System.out.println("변환에 실패");
		     e.printStackTrace();
		}
		
		double [][] data = new double[arr.size()][2];
		
		for(int i = 0; i < arr.size(); i++) {
			obj = (JSONObject)arr.get(i);
			data[i][0] = Double.parseDouble((String)obj.get("lat"));
			data[i][1] = Double.parseDouble((String)obj.get("lng"));
		}
		
		double x = Double.parseDouble(request.getParameter("latlng"));
		JamaExpert j = new JamaExpert();
		
		double result = j.getResult(data);
		out.println(result);
	}

}
