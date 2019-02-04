import java.util.*;
public class Queue 
{
	private int front, rear, size;
	final private int capac;
	private int[] A;
	
	public void display()
	{
		for (int i = 0 ; i < A.length ; i ++)
		{
			System.out.print("| " + A[i] + " ");
		}
		System.out.println("|		Size = " + size + " Front = " + front + " Rear = " + rear);
		
	}
	
	public Queue(int capac)
	{
		size = 0 ;
		this.capac = capac;
		A = new int [capac];
	}
	
	public boolean isFull()
	{
		return size == capac;
	}
	
	public boolean isEmpty()
	{
		return size == 0;
	}
	public void dequeue()
	{
		if (!isEmpty())
		{
			for (int i = 0 ; i < A.length -1 ; i++)
			{
				A[i] = A[i+1];
			}
			size--;
			A[size] = 0;
			front = A[0];
			rear = A[size-1];
		}
		else
			System.out.println("Queue Empty");
		
		
		display();
		
	}
	
	public void enqueue(int x)
	{
		if (!isFull())
		{
			A[size] = x;
			size++;
			rear = x;
			front = A[0];
		}
		else
			System.out.println("Queue Full");
		
		
		display();
			
	}
	
	public void getFront()
	{
		System.out.println(A[0]);
	}
	
	public void getRear()
	{
		System.out.println(rear);
	}
	
	public static void main(String[] args)
	{
		Queue q1 = new Queue(10);
		q1.dequeue();
		
		
	}
}

