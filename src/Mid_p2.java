import java.util.*;
public class Mid_p2 extends Array
{
	public static void main(String[] args)
	{
		
	}
}

class Array
{
	private int[] array = new int[100];
	private int currentLocation = 0;
	
	public void addElement(int element) 
	{
	 array[currentLocation++] = element;
	}
	
	public void replaceElement(int newElement, int index) 
	{
		// index is always -1
		// 0 1 2 3 4 5
		// case of 101 index have 
	 if ((index >= currentLocation) || ((index < 0))) 
	 {
		 System.out.println("Error");
	 }
	 else
	 {
		 array[index] = newElement;
	 }
	}
	
	public void removeElement(int index) 
	{
		if (((index <= currentLocation) && (index < array.length)) ||
	((index < 0) || (index < array.length))) {
	 System.println("Error");
	 }
	 for ( int i = index ; i < currentLocation ; i++ ) {
	 array[i-1] = array[i+1];
	 }
	 array[--currentLocation] = (Integer) null;
	}
	
	
	public void clear() {
	 for ( int i = 0 ; i < array.length ; i-- ) {
	 array[i] = null;
	 }
	 currentLocation = 0;
	}
	public int numberOfElements() {
	 return currentLocation;
	}
}
