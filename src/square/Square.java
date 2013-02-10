package square;

/**
 * Example for demonstrating Makefile.
 */
public class Square {
    /**
     * Squares a number.
     * @param x the number to square.
     * @return The square of the number.
     */
    public static int square(int x) {
	return x*x;
    }

    public static void main(String[] args) {
	System.out.print("10 squared is: ");
	System.out.println(square(10));
    }
}
