package com.example.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.example.model.Circle;
import com.example.model.JamaExpert;
import com.example.model.SmallestCircle;
import com.example.model.Point;

@WebServlet("/calcMLServlet")
public class calcMLServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public calcMLServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("application/x-json; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		JSONParser parser = new JSONParser();
		JSONArray arr = null;
		JSONObject obj = null;
		 
		try {
		     arr = (JSONArray)parser.parse(request.getParameter("locations"));
		} catch (ParseException e) {
		     System.out.println("변환에 실패");
		     e.printStackTrace();
		}
				
		List<Point> points = new ArrayList<>();
		Point p = null;
		
		for(int i = 0; i < arr.size(); i++) {
			obj = (JSONObject)arr.get(i);
			
			p = new Point((double)obj.get("lat"), (double)obj.get("lng"));
			points.add(p);
		}
		
		if(points.size()==2) {
			p.x = (points.get(0).x + p.x)/2;
			p.y = (points.get(0).y + p.y)/2;
		} else if(points.size()!=1){
			SmallestCircle expert = new SmallestCircle();
			Circle resultCircle = expert.makeCircle(points);
			p = resultCircle.c;
		}
		
		out.println("{ \"lat\" : "+p.x+", \"lng\" : "+p.y+"}");
	}

}
