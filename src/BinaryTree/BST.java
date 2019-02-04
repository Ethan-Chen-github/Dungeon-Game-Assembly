package BinaryTree;

public class BST 
{
	Node root = null;
	
	public void temp()
	{
		root = null;
	}
	
	public boolean isEmpty()
	{
		return root == null;
	}
	public boolean isBalanced()
	{
		if(!isEmpty())
		{
			int h = height();
			int c= count();
			
			int lower = (int) (Math.pow(2, h-1));
			int upper = (int) (Math.pow(2, h) - 1);
			
			return (c >= lower && c <= upper);
			
		}
		return true;
	}
	
	public int count()
	{
		if(isEmpty())
			return 0;
		return root.count();
	}
	
	public int height()
	{
		if(isEmpty())
			return 0;
		
		return root.height();
	}
	
	public int max()
	{
		return root.max();
	}
	
	public int min()
	{
		return root.min();
	}
	
	public void insert(int key)
	{
		if(isEmpty())
		{
			root = new Node(key);
		}
		else
		{
			root.insert(key);
		}
	}
	
	public void print()
	{
		root.print();
	}
	
	public Node search(int key)
	{
		if (isEmpty())
			return null;
		return root.search(key);
	}
	
	public void balance()
	{
		if(!isEmpty())
			root.balance();
			root.inorder();
			root = null;
			bisectionInsert(0, root.arr.length -1 , root.arr);
	}
	
	public void bisectionInsert(int first, int last, int[] arr)
	{
		if (first <= last)
		{
			int mid = (first + last) / 2;
			insert(arr[mid]);
			bisectionInsert(first, mid - 1, arr);
			bisectionInsert(mid + 1, last, arr);
		} 
	}
}
