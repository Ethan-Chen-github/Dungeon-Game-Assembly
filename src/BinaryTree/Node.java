package BinaryTree;

public class Node 
{
	int x;
	
	Node left;
	
	Node right;
	
	static int [] arr;
	
	static int i;
	
	public Node (int x)
	{
		this.x = x;
	}
	
	public int count()
	{
		int count = 1;
		if(left != null)
		{
			count += left.count();
		}
		if(right != null)
		{
			count += right.count();
		}
		return count;
		
	}
	
	public int max()
	{
		int max;
		if(right != null)
			max = right.max();
		else
			return this.x;
		return max;
	}
	
	
	
	public int height()
	{
		int leftCount = 0;
		int rightCount = 0;
		if (left != null)
		{
			leftCount += left.height();
		}
		if (right != null)
		{
			rightCount += right.height();
		}
		return Math.max(leftCount, rightCount) + 1;
	}
	
	
	public int min()
	{
		int min;
		if(left != null)
			min = left.min();
		else
			return this.x;
		return min;
	}
	
	public void print()	//print in accesding order
	{
		if(left!= null)
		{
			left.print();
		}
		System.out.print(x + " ");
		if(right != null)
		{
			right.print();
		}
	}
	
	/*public Node search(int key)
	{
		Node theNode = null;
		if(x == key)
		{
			return this;
		}
		if(left!= null && key < x)
		{
			theNode =  left.search(key);
		}
		if(right != null && key > x)
		{
			theNode =  right.search(key);
		}
		return theNode;
	}*/
	
	public Node search (int key)
	{
		if(key == x)
			return this;
			
	    if ((key > x) && (right != null))
	    	return right.search (key);
	   
	    if ((key < x) && (left  != null))
	    	return left.search  (key);

	   return null;
	}

	
	public void insert(int key)
	{
		if(key < x)
		{
			if (left != null )
				left.insert(key);
			else
				left = new Node(key);
		}
			
		if(key > x)
		{
			if (right != null)
				right.insert(key);
			else
				right = new Node(key);
		}
	}
	
	/////////// /////////////////////////////balance
	
	public void insert(int key, Node root)
	{
		if(key < x)
		{
			if (left != null )
				left.insert(key);
			else
				left = new Node(key);
		}
			
		if(key > x)
		{
			if (right != null)
				right.insert(key);
			else
				right = new Node(key);
		}
	}
	
	public void inorder()
	{
		if(left!= null)
		{
			left.inorder();
		}
		arr[i] = x;
		i++;
		if(right != null)
		{
			right.inorder();
		}
		
	}
	
	
	public void balance()
	{
		i = 0;  //initialize to 0 everytime i called it
		arr = new int[count()];
	}
	
	
	
}
