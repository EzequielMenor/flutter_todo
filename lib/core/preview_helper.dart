class Preview {
  const Preview({this.device, this.width, this.height});
  final PreviewDevice? device;
  final double? width;
  final double? height;
}

class PreviewDevice {
  const PreviewDevice._();
  static const PreviewDevice phone = PreviewDevice._();
}
