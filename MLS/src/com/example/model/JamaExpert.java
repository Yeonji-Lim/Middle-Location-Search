package com.example.model;

import Jama.Matrix;

public class JamaExpert {
	public double getResult(double[][] x) {
						
		Matrix A = new Matrix(4, 3);
		double ad[][] = A.getArray();
		
		for(int i = 0; i < 4; i++) {
			ad[i][0] = 1;
			ad[i][1] = x[i][0];
			ad[i][2] = x[i][1];
		}
//		ad[0][1] = 1;
//		ad[0][2] = 1;
//		ad[1][1] = 3;
//		ad[1][2] = -1;
//		ad[2][1] = 0;
//		ad[2][2] = 4;
//		ad[3][1] = 5;
//		ad[3][2] = 6;
		
		Matrix b = new Matrix(4, 1);
		double ad2[][] = b.getArray();
		for(int i = 0; i < 4; i++) {
			ad2[i][0] = Math.pow(ad[i][1], 2)+Math.pow(ad[i][2], 2); 
		}
				
		//c = (A^T*A)^(-1)*A^T*b -> 사이즈는 3, 1
		Matrix c = A.transpose().times(A).inverse().times(A.transpose()).times(b);
		
		double res[][] = c.getArray();
		double x_c = res[1][0]/2;
		double y_c = res[2][0]/2;
		double r_c = Math.sqrt(res[0][0] + Math.pow(x_c, 2) + Math.pow(y_c, 2));
		
		return(r_c);
	}
}
