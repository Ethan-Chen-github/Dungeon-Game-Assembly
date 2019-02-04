
public class InfixToPostfix 
{
	static ArrayStack opValue;
	static ArrayStack operator;
	static ArrayStack result;
	
	public static void op_value(int x)
	{
		if (opValue.isEmpty())
			opValue.push(x);
	}
	
	public static void operator(String op)
	{
		if (operator.isEmpty())
			operator.push(op);
		
	}
	public static void InToPost(String str)
	{
		operator = new ArrayStack(str.length());
		
		opValue = new ArrayStack(str.length());
		
		result = new ArrayStack (str.length());
		
		for (int i = 0 ; i < str.length() ; i++)
		{
			char op = str.charAt(i);
			
			switch(op)
			{
			
			case '*': 
				op_value(2);
			
			break;
				
			case '+': 
			break;
			
			default: //num
				result.push(op);
			}
		}
		
		
		
	}
	
	public static void main (String[] args)
	{
		InToPost("2+3*4");
	}
}
