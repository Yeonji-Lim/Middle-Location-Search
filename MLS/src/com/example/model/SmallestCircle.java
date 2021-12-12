package com.example.model;

/* 
 * Smallest enclosing circle - Library (Java)
 * 
 * Copyright (c) 2020 Project Nayuki
 * https://www.nayuki.io/page/smallest-enclosing-circle
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program (see COPYING.txt and COPYING.LESSER.txt).
 * If not, see <http://www.gnu.org/licenses/>.
 */

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;

public final class SmallestCircle {
	
	/* 
	 * Returns the smallest circle that encloses all the given points. Runs in expected O(n) time, randomized.
	 * Note: If 0 points are given, null is returned. If 1 point is given, a circle of radius 0 is returned.
	 */
	
	// 초기 호출 함수
	public static Circle makeCircle(List<Point> points) {
		// caller의 데이터를 카피, 순서를 셔플
		List<Point> shuffled = new ArrayList<>(points);
		Collections.shuffle(shuffled, new Random());
		
		// 계속해서 원에 좌표를 더하거나 원을 계산함
		Circle c = null;
		for (int i = 0; i < shuffled.size(); i++) {
			Point p = shuffled.get(i);
			if (c == null || !c.contains(p))
				c = makeCircleOnePoint(shuffled.subList(0, i + 1), p);
		}
		return c;
	}
	
	// 경계 좌표를 하나 알 경우
	private static Circle makeCircleOnePoint(List<Point> points, Point p) {
		Circle c = new Circle(p, 0);
		for (int i = 0; i < points.size(); i++) {
			Point q = points.get(i);
			if (!c.contains(q)) {
				if (c.r == 0)
					c = makeDiameter(p, q);
				else
					c = makeCircleTwoPoints(points.subList(0, i + 1), p, q);
			}
		}
		return c;
	}
	
	// 경계 좌표를 두 개 알 경우
	private static Circle makeCircleTwoPoints(List<Point> points, Point p, Point q) {
		Circle circ = makeDiameter(p, q);
		Circle left  = null;
		Circle right = null;
		
		// For each point not in the two-point circle
		Point pq = q.subtract(p);
		for (Point r : points) {
			if (circ.contains(r))
				continue;
			
			// Form a circumcircle and classify it on left or right side
			double cross = pq.cross(r.subtract(p));
			Circle c = makeCircumcircle(p, q, r);
			if (c == null)
				continue;
			else if (cross > 0 && (left == null || pq.cross(c.c.subtract(p)) > pq.cross(left.c.subtract(p))))
				left = c;
			else if (cross < 0 && (right == null || pq.cross(c.c.subtract(p)) < pq.cross(right.c.subtract(p))))
				right = c;
		}
		
		// Select which circle to return
		if (left == null && right == null)
			return circ;
		else if (left == null)
			return right;
		else if (right == null)
			return left;
		else
			return left.r <= right.r ? left : right;
	}
	
	static Circle makeDiameter(Point a, Point b) {
		Point c = new Point((a.x + b.x) / 2, (a.y + b.y) / 2);
		return new Circle(c, Math.max(c.distance(a), c.distance(b)));
	}
	
	static Circle makeCircumcircle(Point a, Point b, Point c) {
		// Mathematical algorithm from Wikipedia: Circumscribed circle
		double ox = (Math.min(Math.min(a.x, b.x), c.x) + Math.max(Math.max(a.x, b.x), c.x)) / 2;
		double oy = (Math.min(Math.min(a.y, b.y), c.y) + Math.max(Math.max(a.y, b.y), c.y)) / 2;
		double ax = a.x - ox,  ay = a.y - oy;
		double bx = b.x - ox,  by = b.y - oy;
		double cx = c.x - ox,  cy = c.y - oy;
		double d = (ax * (by - cy) + bx * (cy - ay) + cx * (ay - by)) * 2;
		if (d == 0)
			return null;
		double x = ((ax*ax + ay*ay) * (by - cy) + (bx*bx + by*by) * (cy - ay) + (cx*cx + cy*cy) * (ay - by)) / d;
		double y = ((ax*ax + ay*ay) * (cx - bx) + (bx*bx + by*by) * (ax - cx) + (cx*cx + cy*cy) * (bx - ax)) / d;
		Point p = new Point(ox + x, oy + y);
		double r = Math.max(Math.max(p.distance(a), p.distance(b)), p.distance(c));
		return new Circle(p, r);
	}
	
}
