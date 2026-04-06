# LP3 - Minggu 4 (State Management BLoC/Cubit)

## Diagram Event-State

```text
LoadTasks  -> TaskLoading -> TaskLoaded
AddTask    -> TaskLoading -> TaskLoaded
UpdateTask -> TaskLoading -> TaskLoaded
DeleteTask -> TaskLoading -> TaskLoaded

Jika gagal pada aksi apa pun:
Action -> TaskLoading -> TaskError
```

## Daftar Event/Aksi yang Diimplementasikan

- `loadTasks()`
- `addTask({title, description})`
- `updateTask({id, title, description, status})`
- `deleteTask({id})`

## Daftar State yang Diimplementasikan

- `TaskInitial`
- `TaskLoading`
- `TaskLoaded`
- `TaskError`

## Bukti UI Reaktif

- Halaman task menampilkan loading saat state `TaskLoading`.
- Halaman task menampilkan list saat state `TaskLoaded`.
- Halaman task menampilkan snackbar saat state `TaskError`.
