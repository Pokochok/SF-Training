public class StringArrayTest {
    public static List<String> generateStringArray(Integer listSize){
        List<String> listOfStrings = new List<String>();
        for(Integer i = 0; i < listSize; i++){
            listOfStrings.add('Test ' + i);
        }
        return listOfStrings;
    }
}