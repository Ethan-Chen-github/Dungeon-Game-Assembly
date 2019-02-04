import java.util.*;
public class SelectionSort 
{
	public static void main(String[] args)
	{

		int [] arr = {15, 13 , 9 , 19 , 15 , 3 , 6};
		SelSort(arr);
	}
	
	public static void SelSort(int[] arr)
	{
		if (arr.length == 0 || arr.length == 1)
		{
			System.out.println("U dumb?");
			return;
		}
		
		int insertPos;
		for (insertPos = 0 ; insertPos < arr.length - 1; insertPos++)
		{
			// min
			int min = insertPos;
			for (int j = insertPos + 1 ; j < arr.length; j++)
			{
				if(arr[j] < arr[min])
				{
					min = j;
				}
			}
			
			//swap
			int swap = arr[min];
			arr[min] = arr[insertPos];
			arr[insertPos] = swap;
			
		}
		
		 /*int n = arr.length;
		 
	        // One by one move boundary of unsorted subarray
	        for (int i = 0; i < n-1; i++)
	        {
	            // Find the minimum element in unsorted array
	            int min_idx = i;
	            for (int j = i+1; j < n; j++)
	                if (arr[j] < arr[min_idx])
	                    min_idx = j;
	 
	            // Swap the found minimum element with the first
	            // element
	            int temp = arr[min_idx];
	            arr[min_idx] = arr[i];
	            arr[i] = temp;
	        }*/
		
		
		for (int i = 0; i < arr.length ; i++)
		{
			System.out.print(arr[i] + " ");
		}
	}
}
