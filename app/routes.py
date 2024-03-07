from app import app
from flask import render_template, flash, redirect, request, url_for,session,jsonify
from app.models import *
import re
from datetime import datetime


@app.route("/")
def home():
    return render_template('index.html')

@app.route("/food-ordering" , methods=['GET','POST'])
def food_ordering():
    return render_template('food-ordering.html')

@app.route("/checkout", methods=['GET','POST'])
def checkout():
    return render_template('checkout.html')

@app.route("/get-menu-items")
def get_menu_items():
    menu_items = MenuItem.query.all()
    menu_items_list = []
    for menu_item in menu_items:
        menu_items_list.append(menu_item.serialize())
    return jsonify(menu_items_list)


@app.route('/checkout-payment', methods=['GET', 'POST'])
def checkout_payment():
    message = ""
    if request.method == 'POST':
        if request.form.get('emailOrId'):
            email_or_id = request.form.get('emailOrId')
            table_number = request.form.get('tableNumber')

            patron = None
            if '@' in email_or_id:
                patron = Patron.query.filter_by(Email=email_or_id).first().PatronID
            else:
                patron = Reservation.query.filter_by(ReservationID=email_or_id).first().PatronID

            
            if not patron:
                message = "No reservation or patron records found. Please try again."
                return render_template('checkout.html', modal='active' , message = message)
        else:
            first_name = request.form.get('firstName')
            last_name = request.form.get('lastName')
            phone_number = request.form.get('phoneNumber')
            email_address = request.form.get('emailAddress')
            address = request.form.get('address')
            table_number = request.form.get('tableNumber2')


            patron = Patron.query.filter_by(Email=email_address).first()
            if not patron:
                Patron.add_patron(first_name, last_name, address, phone_number, email_address)
            patron = Patron.query.filter_by(Email=email_address).first().PatronID

        
        cc_name = request.form.get('ccName')
        cc_number = request.form.get('ccNumber')
        cc_expiration = request.form.get('ccExpiration')
        cc_cvv = request.form.get('ccCvv')
        total_amount = float(request.form.get('totalAmount')[1:])

        # validate credit card number
        card_validated= False if not re.match(r'^[0-9]{12,19}$', cc_number) else True
        date_confirmed = False if not re.match(r'^[0-9]{2}/[0-9]{2}$', cc_expiration) else True
        date_validated = False if (int("20"+cc_expiration.split('/')[1]) < datetime.now().year) or (int("20"+cc_expiration.split('/')[1]) == datetime.now().year and int(cc_expiration.split('/')[0]) < datetime.now().month) else True


        if card_validated and date_confirmed and date_validated:
            order_id =Order.add_order(patron, total_amount, 'Paid', 'Pending', table_number)
            Payment.add_payment(order_id, total_amount, 'credit card')
            message = "Payment Successful. Order has been placed. Order Number: #6712{}".format(order_id)
            return render_template('index.html', modal='active' , message = message, success=True)
        else:
            message = "Invalid credit card information. Please try again."
            return render_template('checkout.html', modal='active' , message = message)
    return render_template('checkout.html', modal='' , message = message)


@app.route('/search-order', methods=['GET', 'POST'])
def search_order():
    if request.method == 'POST':
        order_number = request.form.get('orderNumber')[4:]
        print(order_number)
        order = Order.query.filter_by(OrderID=order_number).first()
        if order:
            return render_template('food-ordering.html', order=order, show_results=True)
    return render_template('food-ordering.html', show_results=False)

@app.route('/employee-login', methods=['GET', 'POST'])
def employee_login():
    return render_template('staff/employee-login.html', error=False)

@app.route('/employee-reset-password', methods=['GET', 'POST'])
def employee_reset_password():
    if request.method == 'POST':
            return render_template('staff/employee-login.html', error=True)
    return render_template('staff/employee-login.html', error=False)

@app.route('/logout')
def logout():
    session['logged_in'] = False
    session['user_id'] = None
    return render_template('staff/employee-login.html', error=False)

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        user = request.form.get('user').lower()
        password = request.form.get('password')
        user = User.query.filter_by(Username=user, password=password).first()
        if user:
            session['user_id'] = user.UserID
            session['logged_in'] = True
            if user.UserType == 'chef':
                return redirect(url_for('chef'))
            elif user.UserType == 'waiter':
                return redirect(url_for('waiter-dashboard'))
    return render_template('staff/employee-login.html', error=True)

@app.route('/chef', methods=['GET', 'POST'])
def chef():
    return render_template('staff/chef.html', error=False)

@app.route('/waiter', methods=['GET', 'POST'])
def waiter():
    return render_template('staff/waiter.html', error=False)


@app.route('/waiter-dashboard')
def view_orders():
    all_orders = Order.query.all()
    orders_with_details = []

    for order in all_orders:
        order_items = OrderItem.query.filter_by(OrderID=order.OrderID).all()
        item_details = []
        for item in order_items:
            menu_item = MenuItem.query.get(item.MenuItemID)
            if menu_item:
                item_details.append({
                    'name': menu_item.Name,
                    'quantity': item.Quantity,
                    'price': menu_item.Price,
                    'subtotal': item.Subtotal
                })

        orders_with_details.append({
            'order_id': order.OrderID,
            'table_number': order.tableNumber,
            'total_amount': order.TotalAmount,
            'items': item_details
        })
    # print(orders_with_details.items)
    return render_template('staff/waiter.html', order=orders_with_details)
