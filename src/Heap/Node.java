package Heap;

public class Node 
{
	int x;
	
	Node left = null;
	
	Node right = null;
	
	public Node(int x)
	{
		this.x = x;
	}
	
	public void insert(int x)
	{
		if(left != null)
		{
			left.insert(x);
		}
		else
		{
			left = new Node(x);
		}
		if(right != null)
		{
			right.insert(x);
		}
		else
		{
			right = new Node(x);
		}
	}
}
