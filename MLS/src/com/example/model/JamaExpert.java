package com.example.model;

import Jama.Matrix;

public class JamaExpert {
	public double[] calculateML(double[][] x) {
						
		int loc_num = x.length;
		Matrix A = new Matrix(loc_num, 3);
		double[][] ad = A.getArray();
		
		for(int i = 0; i < loc_num; i++) {
			ad[i][0] = 1;
			ad[i][1] = x[i][0];
			ad[i][2] = x[i][1];
		}
		
		Matrix b = new Matrix(loc_num, 1);
		double[][] ad2 = b.getArray();
		for(int i = 0; i < loc_num; i++) {
			ad2[i][0] = Math.pow(ad[i][1], 2)+Math.pow(ad[i][2], 2); 
		}
				
		//c = (A^T*A)^(-1)*A^T*b -> 사이즈는 3, 1
		Matrix c = A.transpose().times(A).inverse().times(A.transpose()).times(b);
		
		double[][] ad3 = c.getArray();
		double x_c = ad3[1][0]/2;
		double y_c = ad3[2][0]/2;
		double r_c = Math.sqrt(ad3[0][0] + Math.pow(x_c, 2) + Math.pow(y_c, 2));
		
		double[] result = {x_c, y_c, r_c};
		
		return(result);
	}
}
