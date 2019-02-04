import java.util.*;
public class BinarySearch 
{
	public static void main(String[] args)
	{
		int [] arr = {0,3,5,7,8,11,13,17};
		
		System.out.println(binSearch(arr,13));
		RecBinSearch(arr,13);
	}
	
	
	public static int binSearch(int[] arr, int target)
	{
		int high = arr.length - 1;
		int low = 0;
		
		while (low <= high)
		{
			int mid = (high + low )/2;
			// tar = 11
			if (arr[mid] < target)
				low = mid + 1;
			//tar = 3 
			else if (arr[mid] > target)
				high = mid - 1; // minus 1 cause if it is 2 , it is the ans
			else if (arr[mid] == target)
				return mid;
		}
		return -1;
		
	}
	
	public static void RecBinSearch (int[]arr, int target)
	{
		RecBinSearch(arr, target, arr.length -1 ,0, 0);
	}
	
	public static void RecBinSearch (int[]arr, int target, int high , int low, int mid)
	{
		if (low <= high)
		{
			mid = (high + low )/2;
			if (arr[mid] < target)
			{
				low = mid + 1;
				RecBinSearch (arr, target, high, low , mid);
			}
			else if (arr[mid] > target)
			{
				high = mid - 1;
				RecBinSearch (arr, target, high, low , mid);
			}
			else if (arr[mid] == target)
				System.out.println(mid);
		}
		else
		{
			System.out.println(-1);
		}
	}
	
}
