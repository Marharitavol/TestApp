# Post App 📱

Test assignment for developing an iOS application that fetches a post feed, processes dynamic content, and displays details for each post.

---

## 🏗 Architecture & Technologies

The following stack was chosen to ensure scalability and clean code:

* **Architecture**: `MVVM` (Model-View-ViewModel).
* **UI Layout**: 
    * `UICollectionViewCompositionalLayout` + `UICollectionViewDiffableDataSource` — for flexible construction of tables and collections with smooth updates.
* **Networking**: `URLSession` for API communication.
* **Image Loading**: `Kingfisher` for asynchronous image loading and caching.

---

## 🛠 Engineering Decisions

1. **Adaptive Layout**: `Auto Layout` is used to allow the system to automatically determine object sizes based on content (Self-sizing cells).
2. **Date Formatting**: `DateFormatter` is implemented to convert server-side data into a readable, localized format.
