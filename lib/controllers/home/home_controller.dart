String getStringSizeLengthFile(int length) {
  double size = length.toDouble();

  double sizeKb = 1024.0;
  double sizeMb = sizeKb * sizeKb;
  double sizeGb = sizeMb * sizeKb;
  double sizeTerra = sizeGb * sizeKb;

  if (size < sizeMb)
    return (size / sizeKb).toString() + " Kb";
  else if (size < sizeGb)
    return (size / sizeMb).toString() + " Mb";
  else if (size < sizeTerra) return (size / sizeGb).toString() + " Gb";

  return "";
}