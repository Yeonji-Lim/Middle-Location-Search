import java.util.Random;
import Jama.Matrix;

public class jama {

	public static void main(String[] args) {
		Matrix mat = random(5,2); 
        mat.print(5, 5);
        Matrix matInv=mat.inverse();
        matInv.print(5, 5);
        matInv.times(mat).print(5, 5);
	}
	
	public double getResult(double i) {
		return (i);
	}
	
	public static Matrix random(int i, int j) {
        Matrix matrix = new Matrix(i, j);
        double ad[][] = matrix.getArray();
        Random rn = new Random();
        for(int k = 0; k < i; k++) {
            for(int l = 0; l < j; l++) ad[k][l] = rn.nextInt()%100;
        }
        return matrix;
    }

}
