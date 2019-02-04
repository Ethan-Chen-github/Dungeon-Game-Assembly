package LinkedList;

public class LinkedList 
{
	int D = -1;
	
	Node head = new Node(D, null);
	
	Node prev;
	
	public LinkedList()
	{
		head.next = head;
	}
	
	public void InsertBeforeCurr(int x)
	{
		prev.next = new Node(x, prev.next);
	}
	
	public void InsertAfterCurr(int x)
	{
		prev = prev.next;
		
		InsertBeforeCurr(x);
	}
	
	public void RemoveCurrent()
	{
		if(prev.next == head)
			prev.next = head;
		else
			prev.next = prev.next.next;
	}
	
}
