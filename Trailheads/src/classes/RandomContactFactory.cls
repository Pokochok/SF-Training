public class RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer contactsNumber, String lastName){
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 1; i <= contactsNumber; i++){
            contacts.add(new Contact(FirstName = 'Test ' + i, LastName = lastName));
        }
        return contacts;
    }
}