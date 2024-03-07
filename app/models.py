from app import *
from datetime import datetime

class User(db.Model):
    __tablename__ = 'Users'
    UserID = db.Column(db.Integer, primary_key=True)
    Username = db.Column(db.String(255), nullable=False)
    password = db.Column(db.String(255), nullable=False)
    UserType = db.Column(db.String(255), nullable=False)

class Patron(db.Model):
    __tablename__ = 'Patron'
    PatronID = db.Column(db.Integer, primary_key=True)
    UserID = db.Column(db.Integer, db.ForeignKey('Users.UserID'), nullable=True)
    firstName = db.Column(db.String(255))
    lastName = db.Column(db.String(255))
    Address = db.Column(db.String(255))
    Phone = db.Column(db.String(20))
    Email = db.Column(db.String(255))
    patronPoints = db.Column(db.Integer)

    @classmethod
    def add_patron(cls, first_name, last_name, address, phone, email, patron_points=0,  user_id=None):
        try:
            new_patron = cls(
                UserID=user_id,
                firstName=first_name,
                lastName=last_name,
                Address=address,
                Phone=phone,
                Email=email,
                patronPoints=patron_points
            )

            db.session.add(new_patron)
            db.session.commit()
            return True
        except Exception as e:
            db.session.rollback()
            print(f"An error occurred: {e}")
            return False

class Employee(db.Model):
    __tablename__ = 'Employees'
    EmployeeID = db.Column(db.Integer, primary_key=True)
    UserID = db.Column(db.Integer, db.ForeignKey('Users.UserID'))
    firstName = db.Column(db.String(255))
    lastName = db.Column(db.String(255))
    Address = db.Column(db.String(255))
    Phone = db.Column(db.String(20))
    Email = db.Column(db.String(255))
    Position = db.Column(db.String(255))
    Role = db.Column(db.String(255))
    Salary = db.Column(db.Numeric(10, 2))

class Reservation(db.Model):
    __tablename__ = 'Reservation'
    ReservationID = db.Column(db.Integer, primary_key=True)
    PatronID = db.Column(db.Integer, db.ForeignKey('Patron.PatronID'))
    DateReserved = db.Column(db.DateTime)
    TimeReserved = db.Column(db.Time)
    NumberOfGuests = db.Column(db.Integer)
    SpecialRequests = db.Column(db.Text)

class MenuItem(db.Model):
    __tablename__ = 'MenuItems'
    ItemID = db.Column(db.Integer, primary_key=True)
    Name = db.Column(db.String(255))
    Description = db.Column(db.Text)
    Price = db.Column(db.Numeric(10, 2))
    Category = db.Column(db.String(255))
    image = db.Column(db.String(255))

    def serialize(self):
        return {
            'id': self.ItemID,
            'name': self.Name,
            'description': self.Description,
            'price': self.Price,
            'category': self.Category,
            'image': self.image
        }

class Chef(db.Model):
    __tablename__ = 'Chef'
    ChefID = db.Column(db.Integer, primary_key=True)
    EmployeeID = db.Column(db.Integer, db.ForeignKey('Employees.EmployeeID'))
    Specialization = db.Column(db.String(255))
    Rating = db.Column(db.Integer)

class Waiter(db.Model):
    __tablename__ = 'Waiter'
    WaiterID = db.Column(db.Integer, primary_key=True)
    EmployeeID = db.Column(db.Integer, db.ForeignKey('Employees.EmployeeID'))
    Experience = db.Column(db.Integer)
    Ratings = db.Column(db.Integer)

class Order(db.Model):
    __tablename__ = 'Orders'
    OrderID = db.Column(db.Integer, primary_key=True)
    PatronID = db.Column(db.Integer, db.ForeignKey('Patron.PatronID'))
    OrderCreationDate = db.Column(db.DateTime)
    TotalAmount = db.Column(db.Numeric(10, 2))
    SpecialInstruction = db.Column(db.Text)
    paymentStatus = db.Column(db.String(255))
    OrderStatus = db.Column(db.String(255))
    tableNumber = db.Column(db.Integer)

    @classmethod
    def add_order(cls, patron_id, total_amount, payment_status, order_status, table_number, special_instruction=None):
        try:
            new_order = cls(
                PatronID=patron_id,
                OrderCreationDate=datetime.now(),
                TotalAmount=total_amount,
                SpecialInstruction=special_instruction,
                paymentStatus=payment_status,
                OrderStatus=order_status,
                tableNumber=table_number
            )

            db.session.add(new_order)
            db.session.commit()
            return new_order.OrderID 
        except Exception as e:
            db.session.rollback()
            print(f"An error occurred: {e}")
            return None

class OrderItem(db.Model):
    __tablename__ = 'OrderItems'
    OrderItemID = db.Column(db.Integer, primary_key=True)
    OrderID = db.Column(db.Integer, db.ForeignKey('Orders.OrderID'))
    MenuItemID = db.Column(db.Integer, db.ForeignKey('MenuItems.ItemID'))
    Quantity = db.Column(db.Integer)
    Subtotal = db.Column(db.Numeric(10, 2))

class Payment(db.Model):
    __tablename__ = 'Payment'
    PaymentID = db.Column(db.Integer, primary_key=True)
    OrderID = db.Column(db.Integer, db.ForeignKey('Orders.OrderID'))
    Amount = db.Column(db.Numeric(10, 2))
    paymentMethod = db.Column(db.String(255))
    paymentDate = db.Column(db.DateTime)

    @classmethod
    def add_payment(cls, order_id, amount, payment_method):
        try:
            new_payment = cls(
                OrderID=order_id,
                Amount=amount,
                paymentMethod=payment_method,
                paymentDate=datetime.now()
            )

            db.session.add(new_payment)
            db.session.commit()
            return True
        except Exception as e:
            db.session.rollback()
            print(f"An error occurred: {e}")
            return False
