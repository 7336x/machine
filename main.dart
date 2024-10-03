import 'dart:io'; 
 
// Q1
class Item {
  String name; // Attributes
  double price; 

  Item(this.name, this.price); // Constructor and I put this in order to use the same names

  String displayItem() {
    return "$name - \$${price.toStringAsFixed(2)}"; // Returns a string to display the name and price of the item
  }
}

// Q2
class ItemStock 
{
  Item item;
  int stock;

  ItemStock(this.item, this.stock);
    
  bool isInStock() {
    return stock > 0;
  }

  String toDisplayItemStock() {
    return "${item.displayItem()} (Stock: $stock)";
  }
}

// Q3 with features
class VendingMachine {
  List<ItemStock> items;
  double balance;

  VendingMachine(this.items, this.balance);

  void addItem(Item item, int stock) {
    items.add(ItemStock(item, stock)); 
  }

  void displayItems() {
    print("Items Available:");
    for (var itemStock in items) {
      String stockInfo = itemStock.isInStock() 
          ? itemStock.toDisplayItemStock() 
          : "${itemStock.item.name} - \$${itemStock.item.price.toStringAsFixed(2)} (Out of stock)";
      print(stockInfo);
    }
  }

  void insertMoney() {
    stdout.write("Insert money: "); 
    double amount = double.parse(stdin.readLineSync()!); 
    balance += amount;
    print("Current balance: \$${balance.toStringAsFixed(2)}");
  }

  void selectItem(String itemName) {
    for (var itemStock in items) {
      if (itemStock.item.name == itemName) {
        if (itemStock.isInStock()) {
          print("\nSelect item: $itemName");
          dispenseItem(itemStock);
        } else {
          print("$itemName is out of stock.");
        }
        return;
      }
    }
    print("$itemName not found.");
  }

  void dispenseItem(ItemStock itemStock) {
    print("Dispensing ${itemStock.item.name}...");
    if (balance < itemStock.item.price) {
      print('Insufficient balance. Please insert more money.');
      return;
    }
    balance -= itemStock.item.price;
    itemStock.stock--;
    print("Remaining balance: \$${balance.toStringAsFixed(2)}");
  }

  double getChange() {
    double change = balance;
    balance = 0;
    return change;
  }
}

void main() {
  // now i will create the style  Welcome message
  print("Welcome to the Vending Machine!");
  print(" ");
   // those are  the items that  i create .
  Item cacao = Item('Cacao', 2.50);
  Item chips = Item('Chips', 1.50);
  Item water = Item('Water', 1.00);

  // here  did the item stocks
  ItemStock cacaoStock = ItemStock(cacao, 10);
  ItemStock chipsStock = ItemStock(chips, 5);
  ItemStock waterStock = ItemStock(water, 0); 

  // Create vending machine
  VendingMachine machine = VendingMachine([cacaoStock, chipsStock, waterStock], 0.0);

  //  i want to display initial items
  machine.displayItems();

  // for user actions i try to did that
  machine.insertMoney(); // Prompt for money
  stdout.write("Select item: "); // Prompt user to select item
  String? itemName = stdin.readLineSync(); // Read the item name
  if (itemName != null) {
    machine.selectItem(itemName); // Process the item selection
  }

  // here for another action
  stdout.write("\nDo you want another item? (yes/no): "); // Ask for another item
  String? response = stdin.readLineSync(); // Read user input

  if (response?.toLowerCase() == 'yes') {
    stdout.write("Select item: "); // Prompt again for item selection
    String? nextItemName = stdin.readLineSync(); // Read the next item name
    if (nextItemName != null) {
      machine.selectItem(nextItemName); // Process the next item selection
    }
  } else {
    //  final thing is that  for Returning change i use get 
    double change = machine.getChange();
    print("Returning change: \$${change.toStringAsFixed(2)}");
    print("Thank you for using the vending machine!");
  }
}
