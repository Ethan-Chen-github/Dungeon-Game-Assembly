import java.util.*;
public class Recur 
{
	public static void main(String[] args)
	{
		int[] x = {1,3,4,5};
		display(x, 0);
	}
	
	public static void display (int[] x, int l)
	{
		if (l == x.length)
			return;
		System.out.print(x[l] + " ");
		display(x, l + 1);
	}
}
