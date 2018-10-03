print("Starting Test File...");

print("\nColors");
for colors in Color.allColors{
  print("\(colors): \(colors.rawValue)")
}

print("\nValues");
for values in Value.allValues{
  print("\(values): \(values.rawValue)")
}

print("\nFinished Tests");