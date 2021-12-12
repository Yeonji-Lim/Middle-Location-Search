package com.example.model;

public final class Point {
	public double x;
	public double y;
	
	public Point(double x, double y) {
		this.x = x;
		this.y = y;
	}
	
	public Point subtract(Point p) {
		return new Point(x - p.x, y - p.y);
	}
	
	public double distance(Point p) {
		return Math.hypot(x - p.x, y - p.y);
	}
	
	// Signed area / determinant thing
	public double cross(Point p) {
		return x * p.y - y * p.x;
	}
	
	public String toString() {
		return String.format("Point(%g, %g)", x, y);
	}
}
