const tourSchedules = [
  {
    "day": "1",
    "date": "2024-09-20",
    "briefDesc":
        "A tour schedule for a day provides a detailed plan broken down into specific parts of the day: morning, noon, afternoon, evening, and night. Each part contains a list of activities scheduled for that time, with information about the time, location, description, transportation, and type of activity (e.g., dining, sightseeing, relaxing). This structure allows travelers to clearly see what is planned for each segment of the day and helps them manage their time and expectations efficiently throughout the tour.",
    "activities": [
      {
        "time": "08:00",
        "location": "Hanoi",
        "activity": "Depart from Hanoi by bus",
        "transportation": "Bus",
        "activityType": "transportation",
      },
      {
        "time": "10:30",
        "location": "Bai Dinh Pagoda, Ninh Binh",
        "activity": "Visit Bai Dinh Pagoda",
        "transportation": "Walking",
        "activityType": "sightseeing",
      },
      {
        "time": "12:30",
        "location": "Ninh Binh",
        "activity": "Lunch at a local restaurant",
        "transportation": "Bus",
        "activityType": "dining" // Icons.restaurant
      },
      {
        "time": "14:00",
        "location": "Trang An, Ninh Binh",
        "activity": "Boat tour at Trang An",
        "transportation": "Boat",
        "activityType": "sightseeing" // Icons.visibility
      },
      {
        "time": "17:00",
        "location": "Ninh Binh Hotel",
        "activity": "Check in hotel and rest",
        "transportation": "Bus",
        "activityType": "rest" // Icons.hotel
      }
    ]
  },
  {
    "day": "2",
    "date": "2024-09-21",
    "briefDesc":
        "A tour schedule for a day provides a detailed plan broken down into specific parts of the day: morning, noon, afternoon, evening, and night. Each part contains a list of activities scheduled for that time, with information about the time, location, description, transportation, and type of activity (e.g., dining, sightseeing, relaxing). This structure allows travelers to clearly see what is planned for each segment of the day and helps them manage their time and expectations efficiently throughout the tour.",
    "activities": [
      {
        "time": "07:00",
        "location": "Ninh Binh",
        "activity": "Breakfast at the hotel",
        "transportation": "N/A",
        "activityType": "dining" // Icons.breakfast_dining
      },
      {
        "time": "09:00",
        "location": "Hang Mua, Ninh Binh",
        "activity": "Climb Hang Mua and enjoy the view",
        "transportation": "Bus",
        "activityType": "exploring" // Icons.explore
      },
      {
        "time": "12:00",
        "location": "Ninh Binh",
        "activity": "Lunch at a local restaurant",
        "transportation": "Bus",
        "activityType": "dining" // Icons.restaurant
      },
      {
        "time": "13:30",
        "location": "Tam Coc, Ninh Binh",
        "activity": "Boat tour at Tam Coc",
        "transportation": "Boat",
        "activityType": "sightseeing" // Icons.visibility
      },
      {
        "time": "16:00",
        "location": "Hanoi",
        "activity": "Return to Hanoi",
        "transportation": "Bus",
        "activityType": "transportation" // Icons.directions_bus
      }
    ]
  },
  {
    "day": "3",
    "date": "2024-09-22",
    "briefDesc":
        "A tour schedule for a day provides a detailed plan broken down into specific parts of the day: morning, noon, afternoon, evening, and night. Each part contains a list of activities scheduled for that time, with information about the time, location, description, transportation, and type of activity (e.g., dining, sightseeing, relaxing). This structure allows travelers to clearly see what is planned for each segment of the day and helps them manage their time and expectations efficiently throughout the tour.",
    "activities": [
      {
        "time": "08:00",
        "location": "Hanoi",
        "activity": "Visit Ho Chi Minh Mausoleum",
        "transportation": "Walking",
        "activityType": "sightseeing" // Icons.visibility
      },
      {
        "time": "10:30",
        "location": "Temple of Literature",
        "activity": "Visit Temple of Literature",
        "transportation": "Walking",
        "activityType": "sightseeing" // Icons.visibility
      },
      {
        "time": "12:00",
        "location": "Old Quarter, Hanoi",
        "activity": "Lunch and explore Old Quarter",
        "transportation": "Walking",
        "activityType": "dining" // Icons.restaurant
      },
      {
        "time": "14:00",
        "location": "Hoan Kiem Lake",
        "activity": "Visit Hoan Kiem Lake and Ngoc Son Temple",
        "transportation": "Walking",
        "activityType": "sightseeing" // Icons.visibility
      },
      {
        "time": "16:00",
        "location": "Hanoi Hotel",
        "activity": "Rest at hotel",
        "transportation": "Walking",
        "activityType": "rest" // Icons.hotel
      }
    ]
  },
  {
    "day": "4",
    "date": "2024-09-23",
    "briefDesc":
        "A tour schedule for a day provides a detailed plan broken down into specific parts of the day: morning, noon, afternoon, evening, and night. Each part contains a list of activities scheduled for that time, with information about the time, location, description, transportation, and type of activity (e.g., dining, sightseeing, relaxing). This structure allows travelers to clearly see what is planned for each segment of the day and helps them manage their time and expectations efficiently throughout the tour.",
    "activities": [
      {
        "time": "07:30",
        "location": "Hanoi",
        "activity": "Depart to Sapa by bus",
        "transportation": "Bus",
        "activityType": "transportation" // Icons.directions_bus
      },
      {
        "time": "12:00",
        "location": "Sapa",
        "activity": "Arrive in Sapa, lunch and rest at the hotel",
        "transportation": "Bus",
        "activityType": "rest" // Icons.hotel
      },
      {
        "time": "14:30",
        "location": "Cat Cat Village, Sapa",
        "activity": "Visit Cat Cat Village and learn about H'Mong culture",
        "transportation": "Walking",
        "activityType": "sightseeing" // Icons.visibility
      },
      {
        "time": "17:30",
        "location": "Sapa Hotel",
        "activity": "Return to hotel and rest",
        "transportation": "Walking",
        "activityType": "rest" // Icons.hotel
      }
    ]
  },
  {
    "day": "5",
    "date": "2024-09-24",
    "briefDesc":
        "A tour schedule for a day provides a detailed plan broken down into specific parts of the day: morning, noon, afternoon, evening, and night. Each part contains a list of activities scheduled for that time, with information about the time, location, description, transportation, and type of activity (e.g., dining, sightseeing, relaxing). This structure allows travelers to clearly see what is planned for each segment of the day and helps them manage their time and expectations efficiently throughout the tour.",
    "activities": [
      {
        "time": "06:30",
        "location": "Sapa",
        "activity": "Climb Fansipan by cable car",
        "transportation": "Cable Car",
        "activityType": "exploring" // Icons.explore
      },
      {
        "time": "11:00",
        "location": "Sapa",
        "activity": "Return to Sapa center, lunch at a restaurant",
        "transportation": "Cable Car",
        "activityType": "dining" // Icons.restaurant
      },
      {
        "time": "14:00",
        "location": "Silver Waterfall, Sapa",
        "activity": "Visit Silver Waterfall",
        "transportation": "Bus",
        "activityType": "sightseeing" // Icons.visibility
      },
      {
        "time": "16:00",
        "location": "Sapa Hotel",
        "activity": "Return to hotel and rest",
        "transportation": "Bus",
        "activityType": "rest" // Icons.hotel
      }
    ]
  }
];
