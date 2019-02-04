import java.util.*;

abstract public class StackFunc 
{
	static final int SIZE = 3;
	static int top = 0;
	
	public static void main(String[] args)
	{
		int [] arr1 = new int[SIZE];
		int [] arr2 = new int[SIZE];
		
		/*StackArray s1 = new StackArray(arr1);
		s1.push(1);
		s1.push(2);
		s1.push(3);
		s1.pop();*/
	
	}
	
	abstract public void displayPush();
	abstract public void displayPop();
}

class StackArrayList extends StackFunc
{
	
	
	public StackArrayList(int [] arr)
	{
		List list = Arrays.asList(arr);
	}
	
	
	public void push(int x)
	{
		if (top== SIZE)
		{
			System.out.println("Stack is full");
		}
		else
		{
			arr[top++] = x;
			displayPush();
		}
	}
	
	public void pop()
	{
		if (top == 0)
		{
			System.out.println("Stack is Empty");
		}
		else
		{
			arr[--top] = 0;
			displayPop();
		}
		
	}
	
	public void clear()
	{
		System.out.println("Clear");
		top = 0;
		for (int i = 0; i < arr.length ; i++)
		{
			arr[i] = 0;
		}
		
		System.out.print("Array: { ");
		for (int i = 0; i < arr.length ; i++)
		{
			System.out.print(arr[i] + ", ");
		}
		System.out.println("} ");
	}
	
	public void displayPush() 
	{
		System.out.print("Array: { ");
		for (int i = 0; i < top ; i++)
		{
			System.out.print(arr[i] + ", ");
		}
		System.out.println("} \n" + "Push: " + arr[top-1] + "		Size: " + top);
	}
	
	public void displayPop() 
	{
		System.out.print("Array: { ");
		for (int i = 0; i < top ; i++)
		{
			System.out.print(arr[i] + ", ");
		}
		System.out.println("} \n" + "Pop " + "		Size: " + top);
	}
}








class StackArray extends StackFunc
{
	private int [] arr;
	
	
	public StackArray(int [] arr)
	{
		this.arr = arr;
	}
	
	
	public void push(int x)
	{
		if (top== SIZE)
		{
			System.out.println("Stack is full");
		}
		else
		{
			arr[top++] = x;
			displayPush();
		}
	}
	
	public void pop()
	{
		if (top == 0)
		{
			System.out.println("Stack is Empty");
		}
		else
		{
			arr[--top] = 0;
			displayPop();
		}
		
	}
	
	public void clear()
	{
		System.out.println("Clear");
		top = 0;
		for (int i = 0; i < arr.length ; i++)
		{
			arr[i] = 0;
		}
		
		System.out.print("Array: { ");
		for (int i = 0; i < arr.length ; i++)
		{
			System.out.print(arr[i] + ", ");
		}
		System.out.println("} ");
	}
	
	public void displayPush() 
	{
		System.out.print("Array: { ");
		for (int i = 0; i < top ; i++)
		{
			System.out.print(arr[i] + ", ");
		}
		System.out.println("} \n" + "Push: " + arr[top-1] + "		Size: " + top);
	}
	
	public void displayPop() 
	{
		System.out.print("Array: { ");
		for (int i = 0; i < top ; i++)
		{
			System.out.print(arr[i] + ", ");
		}
		System.out.println("} \n" + "Pop " + "		Size: " + top);
	}
}