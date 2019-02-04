public class IntStack 
{
	private int[] Stack;
	private int top = -1;
	
	public IntStack(int size)
	{
		Stack = new int [size];
	}
	
	public void push(int element)
	{
		top++;
		Stack[top] = element;
	}
	
	public void pop()
	{
		top--;
	}
	
	public boolean isEmpty()
	{
		return top == -1;
	}
	
	public int top()
	{
		return Stack[top];
	}
}