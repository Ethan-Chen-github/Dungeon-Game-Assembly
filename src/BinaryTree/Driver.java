package BinaryTree;

public class Driver 
{
	
	public static void main(String[] args)
	{
		///////////////////////////////////////////////////////////////////////////////
		BST bst = new BST();
		
		bst.insert(6);
		
		bst.insert(3);
		
		bst.insert(1);
		
		bst.insert(4);
		
		bst.insert(5);
		
		bst.insert(8);
		
		bst.insert(10);
		
		bst.insert(7);
		
		System.out.println(bst.isBalanced());
		
		bst.print();
		
		System.out.println();
		
		System.out.println(bst.max());
		
		System.out.println(bst.min());
		
		System.out.println(bst.search(3));
		///////////////////////////////////////////////////////////////////////////////
		//balance   a very unbalance tree
	
		/*BST bst = new BST();
		 
		bst.root = new Node(10);
		
		bst.root.left = new Node (9);
		
		bst.root.left.left = new Node (6);
		
		bst.root.left.left.left = new Node (5);
		
		bst.root.left.left.right = new Node (7);
		
		bst.root.left.left.left.left = new Node (4);
		
		System.out.println(bst.root.count());
		
		System.out.println(bst.root.height());
		
		
		bst.balance();
		
		bst.count();
		
		System.out.println(bst.root.height());*/
		
		
		
		
		
		
		
		
		
		
		
		///////////////////////////////////////////////////////////////////////////////
		/*Node n = new Node(6);
		
		bst.root.left = new Node (3);
		
		bst.root.left.left = new Node (1);
		
		bst.root.left.right = new Node (4);
		
		bst.root.left.right.right = new Node (5);
		
		bst.root.right = new Node (8);
		
		bst.root.right.right = new Node (10);
		
		System.out.println(bst.root.count());
		
		System.out.println(bst.root.max());
		
		System.out.println(bst.root.min());
		
		System.out.println(bst.root.height());
		
		bst.root.print();
		
		System.out.println();
		
		System.out.println(bst.root.search(4).x);
		
		bst.root.insert(2);
		
		System.out.println();*/
		
		
	}
}
