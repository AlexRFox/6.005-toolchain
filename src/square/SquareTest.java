package square;

import org.junit.Test;
import static org.junit.Assert.*;

public class SquareTest {

    /**
     * Tests Square.double()
     */
    @Test
    public void calculateTwoSquared() {
        assertEquals(4, Square.square(2));
    }
}
