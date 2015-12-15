import std.getopt, std.conv, std.stdio;

version (unittest) {}
 else {
   void main(string[] args)
   {
     // Parsing the command line options
     bool add = false;
     GetoptResult helpInfo;

     try {
       helpInfo = getopt(args, "add", "Create addition table", &add);
     }
     catch(GetOptException e) {
       stderr.writeln(e.msg ~ "\nCheck -h/--help option.");
       return;
     }

     if(helpInfo.helpWanted) {
       defaultGetoptPrinter("Some information about the program.",
                           helpInfo.options);
       return;
     }

     auto x = args[1].to!int;
     auto y = args[2].to!int;

     if (x < 1 || y < 1) {
       stderr.writeln("Error: Argumants must be positive.");
     }

     auto table = createTable(x, y ,add);

     foreach (row; table) {
       foreach (elem; row) {
	 write(elem, " ");
       }
       writeln;
     }
  }
 }


int[][] createTable(int x, int y, bool add)
{
  auto table = new int[][](x, y);
  
  if (add) {
    foreach (i; 0..x)
      foreach (j; 0..y)
	table[i][j] = (i+1) + (j+1);
  }
  else {
    foreach (i; 0..x)
      foreach (j; 0..y)
	table[i][j] = (i+1) * (j+1);    
  }

  return table;
}


unittest
{
  auto x = 2;
  auto y = 3;

  assert (createTable(x, y, false) == [[1, 2, 3], [2, 4, 6]], 
	  createTable(x, y, false).to!string);

  assert (createTable(x, y, true) == [[2, 3, 4], [3, 4, 5]], 
	  createTable(x, y, true).to!string);
}
