import '../../features/review/domain/entities/review.dart';

List<ReviewEntity> sampleReviews = [
  ReviewEntity(
    reviewId: "R1",
    userId: "U1",
    tourId: "TOUR-1",
    content:
        "Amazing tour! The guide was very friendly and the views were breathtaking. Amazing tour! The guide was very friendly and the views were breathtaking.",
    rating: 5.0,
    createdAt: DateTime.now().subtract(const Duration(seconds: 3)),
    updatedAt: null,
    images: const [
      "https://th.bing.com/th/id/R.dd21d63169902d40baec0b8766fe0b48?rik=FtLIp5D3lCmg3Q&pid=ImgRaw&r=0",
      "image2.jpg",
      "image3.jpg"
    ],
  ),
  ReviewEntity(
    reviewId: "R2",
    userId: "U2",
    tourId: "TOUR-2",
    content:
        "Great experience, but the transportation could have been smoother.",
    rating: 4.0,
    createdAt: DateTime(2024, 8, 11),
    updatedAt: null,
    images: ["image3.jpg"],
  ),
  ReviewEntity(
    reviewId: "R3",
    userId: "U3",
    tourId: "TOUR-1",
    content: "Loved the activities, but the food was not great.",
    rating: 3.5,
    createdAt: DateTime(2024, 8, 12),
    updatedAt: null,
    images: [],
  ),
  ReviewEntity(
    reviewId: "R4",
    userId: "U4",
    tourId: "TOUR-3",
    content: "The itinerary was well-planned and the guide was knowledgeable.",
    rating: 4.5,
    createdAt: DateTime(2024, 8, 13),
    updatedAt: null,
    images: ["image4.jpg", "image5.jpg"],
  ),
  ReviewEntity(
    reviewId: "R5",
    userId: "U5",
    tourId: "TOUR-5",
    content: "The trip was fantastic! The local cuisine was a highlight.",
    rating: 5.0,
    createdAt: DateTime(2024, 8, 14),
    updatedAt: null,
    images: ["image6.jpg"],
  ),
  ReviewEntity(
    reviewId: "R6",
    userId: "U6",
    tourId: "TOUR-1",
    content: "Nice tour, but the accommodation was a bit disappointing.",
    rating: 3.0,
    createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    updatedAt: null,
    images: [],
  ),
  ReviewEntity(
    reviewId: "R7",
    userId: "U7",
    tourId: "TOUR-7",
    content: "Enjoyed the trip, especially the hiking part!",
    rating: 4.0,
    createdAt: DateTime(2024, 8, 16),
    updatedAt: null,
    images: ["image7.jpg"],
  ),
  ReviewEntity(
    reviewId: "R8",
    userId: "U8",
    tourId: "TOUR-2",
    content: "A bit rushed, but the locations were stunning.",
    rating: 3.8,
    createdAt: DateTime(2024, 8, 17),
    updatedAt: null,
    images: ["image8.jpg", "image9.jpg"],
  ),
  ReviewEntity(
    reviewId: "R9",
    userId: "U9",
    tourId: "TOUR-2",
    content: "Had a relaxing and peaceful experience, highly recommended.",
    rating: 5.0,
    createdAt: DateTime(2024, 8, 18),
    updatedAt: null,
    images: ["image10.jpg"],
  ),
  ReviewEntity(
    reviewId: "R10",
    userId: "U10",
    tourId: "TOUR-5",
    content: "The tour was good, but the bus ride was too long.",
    rating: 3.5,
    createdAt: DateTime(2024, 8, 19),
    updatedAt: null,
    images: [],
  ),
  ReviewEntity(
    reviewId: "R11",
    userId: "U11",
    tourId: "TOUR-11",
    content: "The guide was excellent and the landscapes were beautiful.",
    rating: 4.8,
    createdAt: DateTime(2024, 8, 20),
    updatedAt: null,
    images: ["image11.jpg", "image12.jpg"],
  ),
  ReviewEntity(
    reviewId: "R12",
    userId: "U12",
    tourId: "TOUR-1",
    content: "The tour was decent, but some activities felt too rushed.",
    rating: 3.8,
    createdAt: DateTime.now().subtract(const Duration(minutes: 3)),
    updatedAt: null,
    images: ["image13.jpg"],
  ),
  ReviewEntity(
    reviewId: "R13",
    userId: "U13",
    tourId: "TOUR-1",
    content: "The itinerary was packed, but overall an enjoyable trip.",
    rating: 4.0,
    createdAt: DateTime(2024, 8, 22),
    updatedAt: null,
    images: [],
  ),
  ReviewEntity(
    reviewId: "R14",
    userId: "U14",
    tourId: "TOUR-12",
    content: "Wonderful experience! Loved every moment of it.",
    rating: 5.0,
    createdAt: DateTime(2024, 8, 23),
    updatedAt: null,
    images: ["image14.jpg"],
  ),
  ReviewEntity(
    reviewId: "R15",
    userId: "U15",
    tourId: "TOUR-17",
    content: "A great trip, but it could have been more organized.",
    rating: 3.9,
    createdAt: DateTime(2024, 8, 24),
    updatedAt: null,
    images: ["image15.jpg", "image16.jpg"],
  ),
  ReviewEntity(
    reviewId: "R16",
    userId: "U16",
    tourId: "TOUR-12",
    content: "The activities were fun, but the hotel was below average.",
    rating: 3.5,
    createdAt: DateTime(2024, 8, 25),
    updatedAt: null,
    images: [],
  ),
  ReviewEntity(
    reviewId: "R17",
    userId: "U17",
    tourId: "TOUR-12",
    content: "Great cultural experience, and the food was incredible.",
    rating: 4.7,
    createdAt: DateTime(2024, 8, 26),
    updatedAt: null,
    images: ["image17.jpg"],
  ),
  ReviewEntity(
    reviewId: "R18",
    userId: "U18",
    tourId: "TOUR-15",
    content: "The tour was good, but the weather wasn't great.",
    rating: 3.6,
    createdAt: DateTime(2024, 8, 27),
    updatedAt: null,
    images: ["image18.jpg", "image19.jpg"],
  ),
  ReviewEntity(
    reviewId: "R19",
    userId: "U19",
    tourId: "TOUR-10",
    content: "An enjoyable trip with a great group of people.",
    rating: 4.5,
    createdAt: DateTime(2024, 8, 28),
    updatedAt: null,
    images: ["image20.jpg"],
  ),
  ReviewEntity(
    reviewId: "R20",
    userId: "U20",
    tourId: "TOUR-10",
    content: "The trip was okay, but not as exciting as expected.",
    rating: 3.2,
    createdAt: DateTime(2024, 8, 29),
    updatedAt: null,
    images: [],
  ),
];
