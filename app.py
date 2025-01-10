from flask import Flask, render_template, request, redirect, url_for

app = Flask(__name__)

# In-memory list to store to-do items (for demonstration)
todos = []

@app.route('/')
def index():
    return render_template('index.html', todos=todos)

@app.route('/add', methods=['POST'])
def add_item():
    item_name = request.form.get('item')
    if item_name and item_name.strip():
        # Add new item to the todo list
        todos.append({'name': item_name, 'completed': False})
        return redirect(url_for('index'))
    else:
        # If no item or invalid input, show error
        return render_template('index.html', todos=todos, error="Please enter a valid to-do item!")

@app.route('/complete/<int:item_id>')
def complete_item(item_id):
    if 0 <= item_id < len(todos):
        todos[item_id]['completed'] = True
    return redirect(url_for('index'))

@app.route('/remove/<int:item_id>')
def remove_item(item_id):
    if 0 <= item_id < len(todos):
        todos.pop(item_id)
    return redirect(url_for('index'))

if __name__ == '__main__':
    app.run(debug=True)
