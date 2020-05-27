class Book {
  final String bookTitle;
  final String authorName;
  final String description;
  final String stars;
  final String imageUrl;
  final String numPages;
  final String price;
  final String Bid;
  final String AddedBy;
  final int pQuantity;

  Book(
      {this.imageUrl,
        this.pQuantity=2,
        this.AddedBy,
      this.authorName,
      this.numPages,
      this.bookTitle,
        this.Bid,
      this.description,
      this.stars,
      this.price
      });
}
