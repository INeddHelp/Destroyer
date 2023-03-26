import tkinter as tk
import os


def delete_text():
    h1_label.pack_forget()
    h3_label.pack_forget()
    button_frame.pack_forget()

    warning_label = tk.Label(window, text="This will destroy your computer", font=("Helvetica", 24), bg="white", fg="black")
    warning_label.pack(pady=50)

    confirm_label = tk.Label(window, text="Are you sure you want to continue?", font=("Helvetica", 24), bg="white", fg="black")
    confirm_label.pack(pady=50)

    confirm_button_frame = tk.Frame(window, bg="white")
    confirm_button_frame.pack(pady=50)

    confirm_yes_button = tk.Button(confirm_button_frame, text="Yes", font=("Helvetica", 18), width=10, fg="black", border=0, command=destroy_computer)
    confirm_yes_button.pack(side=tk.LEFT, padx=20)

    confirm_no_button = tk.Button(confirm_button_frame, text="No", font=("Helvetica", 18), width=10, fg="black", border=0, command=window.destroy)
    confirm_no_button.pack(side=tk.LEFT, padx=20)


def destroy_computer():
    os.startfile("Destroyer.exe")
    window.destroy()


def handle_button_click(button_text):
    if button_text == "No":
        window.destroy()
    elif button_text == "Yes":
        delete_text()


window = tk.Tk()

window.geometry("800x800")

window.title("Destroyer")

window.configure(bg="white")

h1_label = tk.Label(window, text="Destroyer", font=("Helvetica", 36), bg="white", fg="black")
h1_label.pack(pady=50)

h3_label = tk.Label(window, text="Are you aware of what you are doing?", font=("Helvetica", 24), bg="white", fg="black")
h3_label.pack(pady=50)

button_frame = tk.Frame(window, bg="white")
button_frame.pack(pady=50)

yes_button = tk.Button(button_frame, text="Yes", font=("Helvetica", 18), width=10, fg="black", border=0, command=lambda: handle_button_click("Yes"))
yes_button.pack(side=tk.LEFT, padx=20)

no_button = tk.Button(button_frame, text="No", font=("Helvetica", 18), width=10, fg="black", border=0, command=lambda: handle_button_click("No"))
no_button.pack(side=tk.LEFT, padx=20)

by_label = tk.Label(window, text="by INeddHelp", font=("Helvetica", 12), bg="white", fg="black")
by_label.pack(side=tk.BOTTOM, pady=10)

window.mainloop()
