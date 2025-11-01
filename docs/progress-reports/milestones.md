---
marp: true
size: 4:3
paginate: true
---

# Sprint 1

---

- Feature # 1 Users can see a list of series (Deadline: 09/26)
  - Requirement # 1
    - Display list of recent series in a Home Page so users will be able to select a series
  - Plan: Call the MangaDex API to get the most recent list of series

---

- Feature # 2 Users are able to select a manga/manwha/manhua series and select a chapter to read(Deadline: 10/03)

  - Requirement # 1

    - Show details of a series

  - Requirement # 2
    - List of chapters when you press a series and able to select to read
  - Plan: Call the MangaDex API to get the list of chapters of the series

---

- Feature # 3 Users are able to search for manga (Deadline: 10/17 )
  - Requirement # 1
    - Search button that users can use to enter series then shows list of series
  - Plan: Call the MangaDex API show the listof search results in search page

---

- Feature # 4 Users can add new manga series to their library(locally in their device) (Deadline: 10/24)
  - Requirement # 1
    - Add a "Add in Library" Button when you are in the detail page(saves locally in their device)
  - Plan: Get the manga_id, image_url, description, and number of chapters. Store this in SQLite

---

# Sprint 2

---

## Week 1

### Feature #4 — Add Manga to Library

**Requirement #1**

- Add an "Add in Library" button on the detail page (saves locally in the device)

**Plan:**  
Get the `manga_id`, `image_url`, `description`, and `number_of_chapters`.  
Store this information in **SQLite**.

---

### Feature #5 — Library Page

**Requirement #1**

- Display list of added series from SQLite

**Requirement #2**

- Enable navigation using bottom navbar

**Requirement #3**

- Design the UI for the library page

---

## Week 2

### Feature #6 — Home Page UI Design

**Requirement #1**

- Improve bottom navigation bar

**Requirement #2**

- Create card-style design for list of series

**Requirement #3**

- Add pagination

---

### Feature #7 — Detail Page UI Design

**Requirement #1**

- Improve list of chapters UI design

**Requirement #2**

- Improve cover image and overview layout on detail page

**Requirement #3**

- Improve Add to Library section

---

## Week 3

### Feature #8 — Settings Page

**Requirements**

- Add switch tile for light mode to dark mode
- Add import file option for library data
- Add download file option for library data
- Add backup frequency setting and notifications (Work Manager)

---

### Feature #9 — Chapter Page UI Improvements

**Requirement #1**

- Allow switching between horizontal and vertical reading modes

**Requirement #2**

- Hide top and bottom app bars when user performs a one-tap gesture

**Requirement #3**

- Add next and previous chapter buttons in bottom app bar

---

## Week 4

### General Improvements

- Improve overall UI of the app
