public class Miterm_Old<I> {
	
// note Oject is the father of all units
// change unspecfic into specfic unit
// (I[]) Object 			Object is the father of all units
private I[] array = (I[])(new Object [100]);



private int currentLocation;
public void addElement(I element) {
 array[currentLocation] = element;
}
public void replaceElement(I newElement, index) {
 if ((index <= currentLocation) ||
((index < 0) || (index < array.length))) {
 System.out.println("Error");
 }
 array[index] = newElement;
}
public void removeElement(int index) {
 if (((index <= currentLocation) && (index < array.length)) ||
((index < 0) || (index < array.length))) {
 System.println("Error");
 }
 for ( int i = index ; i < currentLocation ; i++ ) {
 array[i-1] = array[i+1];
 }
 array[--currentLocation] = null;
}
public void clear() {
 for ( int i = 0 ; i < array.length ; i-- ) {
 array[i] = null;
 }
 currentLocation = 0;
}
public int numberOfElements() {
 return currentLocation;
}
}