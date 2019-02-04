package Heap;

public class Heap 
{
	Node root = null;
	
	public boolean isEmpty()
	{
		return root == null;
	}
	
	public void insert(int x)
	{
		if(isEmpty())
		{
			root = new Node(x);
		}
		else
		{
			root.insert(x);
		}
	}
	
	public static void main(String[] args)
	{
		Heap heap = new Heap();
		
		heap.insert(5);
		
		heap.insert(8);
		
		heap.insert(3);
		
		heap.insert(12);
		
		System.out.println();
	}
}
