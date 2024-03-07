-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Nov 16, 2023 at 11:09 PM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 7.4.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `afrobite`
--

-- --------------------------------------------------------

--
-- Table structure for table `chef`
--

CREATE TABLE `chef` (
  `ChefID` int(11) NOT NULL,
  `EmployeeID` int(11) DEFAULT NULL,
  `Specialization` varchar(255) DEFAULT NULL,
  `Rating` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `chef`
--

INSERT INTO `chef` (`ChefID`, `EmployeeID`, `Specialization`, `Rating`) VALUES
(1, 1, 'Nigerian', 9);

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `EmployeeID` int(11) NOT NULL,
  `UserID` int(11) DEFAULT NULL,
  `firstName` varchar(255) DEFAULT NULL,
  `lastName` varchar(255) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Position` varchar(255) DEFAULT NULL,
  `Role` varchar(255) DEFAULT NULL,
  `Salary` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`EmployeeID`, `UserID`, `firstName`, `lastName`, `Address`, `Phone`, `Email`, `Position`, `Role`, `Salary`) VALUES
(1, 2, 'John', 'Samiko', '23 Main St, Houston, TX 77446', '9155551234', 'jsami@afrobite.com', 'Head Chef', 'chef', '75000.00'),
(2, 3, 'Dele', 'Oriakhi', '456 Park Ave, Houston, TX 77446', '9795555678', 'deleOriaki@example.com', 'Waiter', 'waiter', '40000.00');

-- --------------------------------------------------------

--
-- Table structure for table `menuitems`
--

CREATE TABLE `menuitems` (
  `ItemID` int(11) NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Description` text DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `Category` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `menuitems`
--

INSERT INTO `menuitems` (`ItemID`, `Name`, `Description`, `Price`, `Category`, `image`) VALUES
(1, 'Jollof Rice', 'Aromatic West African rice cooked in a spicy tomato sauce and garnished with meat.', '25.00', 'main', './static/images/food/1.webp'),
(2, 'Eguisi Soup', 'A rich nutty stew made with ground melon seeds and assorted meats.', '20.00', 'main', './static/images/food/2.png'),
(3, 'catfish pepper soup', 'A spicy Nigerian broth with tender catfish, seasoned with traditional herbs and spices.', '25.00', 'main', './static/images/food/3.png'),
(4, 'Asun', 'Spicy grilled goat meat, marinated and cooked with onions and peppers for a smoky, fiery flavor.', '25.00', 'side', './static/images/food/4.png'),
(5, 'Grilled chicken', 'Succulent chicken marinated in herbs and spices, grilled to golden perfection.', '15.00', 'side', './static/images/food/14.webp'),
(6, 'Fried Plantain', 'Sweet, ripe plantains sliced and fried until golden and crispy on the outside, tender inside.', '15.00', 'side', './static/images/food/15.png'),
(7, 'Okra soup', 'A classic dish made with okra, meat, and fish in a savory, thick broth and patrons delight.', '25.00', 'main', './static/images/food/5.webp'),
(8, 'Oatmeal Swallow', 'A smooth staple made from ground oatmeal, served as a complement to soups and stews.', '5.00', 'complement', './static/images/food/7.png'),
(9, 'Fufu Swallow', 'A traditional African staple made from cassava and plantain flour, served with soups.', '5.00', 'complement', './static/images/food/8.png'),
(10, 'Garri Swallow', 'A popular African dish made from fermented cassava, served with various soups and sauces.', '5.00', 'complement', './static/images/food/9.png'),
(11, 'Coconut rice', 'A popular African dish made from fermented cassava, served with various soups and sauces.', '25.00', 'main', './static/images/food/10.png'),
(12, 'Ofada stew', 'A spicy, flavorful sauce made with green bell peppers, locust beans, and typically served with Ofada rice', '25.00', 'main', './static/images/food/11.webp'),
(13, 'Ofada rice', 'A unique, aromatic brown rice served with spicy, flavorful Ofada stew', '5.00', 'complement', './static/images/food/12.png'),
(14, 'Grilled fish', 'Tender, juicy fish delicately seasoned and grilled for a crisp, flavorful finish.', '15.00', 'side', './static/images/food/13.png');

-- --------------------------------------------------------

--
-- Table structure for table `orderitems`
--

CREATE TABLE `orderitems` (
  `OrderItemID` int(11) NOT NULL,
  `OrderID` int(11) DEFAULT NULL,
  `MenuItemID` int(11) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `Subtotal` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `orderitems`
--

INSERT INTO `orderitems` (`OrderItemID`, `OrderID`, `MenuItemID`, `Quantity`, `Subtotal`) VALUES
(1, 1, 1, 1, '25.00'),
(2, 1, 6, 1, '15.00'),
(3, 2, 2, 1, '20.00'),
(4, 2, 4, 2, '50.00'),
(5, 2, 10, 2, '10.00'),
(6, 2, 13, 1, '5.00'),
(7, 2, 14, 1, '15.00'),
(8, 3, 3, 1, '25.00'),
(9, 3, 7, 1, '25.00'),
(10, 3, 9, 2, '10.00'),
(11, 3, 14, 1, '15.00'),
(12, 4, 1, 2, '50.00'),
(13, 4, 5, 2, '30.00'),
(14, 4, 8, 2, '10.00'),
(15, 4, 12, 1, '25.00'),
(16, 5, 1, 2, '50.00'),
(17, 5, 2, 2, '40.00'),
(18, 5, 3, 2, '50.00'),
(19, 5, 4, 2, '50.00'),
(20, 5, 7, 1, '25.00'),
(21, 5, 11, 2, '50.00'),
(22, 5, 12, 1, '25.00');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `OrderID` int(11) NOT NULL,
  `PatronID` int(11) DEFAULT NULL,
  `OrderCreationDate` datetime DEFAULT NULL,
  `TotalAmount` decimal(10,2) DEFAULT NULL,
  `SpecialInstruction` text DEFAULT NULL,
  `paymentStatus` varchar(255) DEFAULT NULL,
  `OrderStatus` varchar(255) DEFAULT NULL,
  `tableNumber` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`OrderID`, `PatronID`, `OrderCreationDate`, `TotalAmount`, `SpecialInstruction`, `paymentStatus`, `OrderStatus`, `tableNumber`) VALUES
(1, 1, '2023-11-16 09:41:52', '50.66', NULL, 'Paid', 'Pending', 3),
(2, 8, '2023-11-16 09:57:35', '98.01', NULL, 'Paid', 'Pending', 4),
(3, 1, '2023-11-16 10:06:16', '71.50', NULL, 'Paid', 'Pending', 2),
(4, 7, '2023-11-16 11:09:38', '104.50', NULL, 'Paid', 'Pending', 0),
(5, 7, '2023-11-16 15:31:47', '269.50', NULL, 'Paid', 'Pending', 5);

-- --------------------------------------------------------

--
-- Table structure for table `patron`
--

CREATE TABLE `patron` (
  `PatronID` int(11) NOT NULL,
  `UserID` int(11) DEFAULT NULL,
  `firstName` varchar(255) DEFAULT NULL,
  `lastName` varchar(255) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `patronPoints` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `patron`
--

INSERT INTO `patron` (`PatronID`, `UserID`, `firstName`, `lastName`, `Address`, `Phone`, `Email`, `patronPoints`) VALUES
(1, 1, 'Kelvin', 'Items', '102 Sams Street, Houston, TX 77446', '9795972311', 'kelitembiz@gmail.com', 50),
(7, NULL, 'Kunle', 'Ade-Oni', '101 Allison Street, Hempstead, TX 77446', '9794201628', 'adeoni@gmail.com', 0),
(8, NULL, 'Daniel', 'Cook', '89 Bolly Rd., Cypress, TX 77445', '3164590211', 'dancook@gmail.com', 0);

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `PaymentID` int(11) NOT NULL,
  `OrderID` int(11) DEFAULT NULL,
  `Amount` decimal(10,2) DEFAULT NULL,
  `paymentMethod` varchar(255) DEFAULT NULL,
  `paymentDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`PaymentID`, `OrderID`, `Amount`, `paymentMethod`, `paymentDate`) VALUES
(1, 5, '269.50', 'credit card', '2023-11-16 15:31:47');

-- --------------------------------------------------------

--
-- Table structure for table `reservation`
--

CREATE TABLE `reservation` (
  `ReservationID` int(11) NOT NULL,
  `PatronID` int(11) DEFAULT NULL,
  `DateReserved` datetime DEFAULT NULL,
  `TimeReserved` time DEFAULT NULL,
  `NumberOfGuests` int(11) DEFAULT NULL,
  `SpecialRequests` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `UserID` int(11) NOT NULL,
  `Username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `UserType` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`UserID`, `Username`, `password`, `UserType`) VALUES
(1, 'kelitem', '1234', 'patron'),
(2, 'chef123', '1234', 'chef'),
(3, 'waiter456', '123', 'waiter');

-- --------------------------------------------------------

--
-- Table structure for table `waiter`
--

CREATE TABLE `waiter` (
  `WaiterID` int(11) NOT NULL,
  `EmployeeID` int(11) DEFAULT NULL,
  `Experience` int(11) DEFAULT NULL,
  `Ratings` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `waiter`
--

INSERT INTO `waiter` (`WaiterID`, `EmployeeID`, `Experience`, `Ratings`) VALUES
(1, 2, 5, 8);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `chef`
--
ALTER TABLE `chef`
  ADD PRIMARY KEY (`ChefID`),
  ADD KEY `EmployeeID` (`EmployeeID`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`EmployeeID`),
  ADD KEY `UserID` (`UserID`);

--
-- Indexes for table `menuitems`
--
ALTER TABLE `menuitems`
  ADD PRIMARY KEY (`ItemID`);

--
-- Indexes for table `orderitems`
--
ALTER TABLE `orderitems`
  ADD PRIMARY KEY (`OrderItemID`),
  ADD KEY `OrderID` (`OrderID`),
  ADD KEY `MenuItemID` (`MenuItemID`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`OrderID`),
  ADD KEY `PatronID` (`PatronID`);

--
-- Indexes for table `patron`
--
ALTER TABLE `patron`
  ADD PRIMARY KEY (`PatronID`),
  ADD KEY `UserID` (`UserID`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`PaymentID`),
  ADD KEY `OrderID` (`OrderID`);

--
-- Indexes for table `reservation`
--
ALTER TABLE `reservation`
  ADD PRIMARY KEY (`ReservationID`),
  ADD KEY `PatronID` (`PatronID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`UserID`);

--
-- Indexes for table `waiter`
--
ALTER TABLE `waiter`
  ADD PRIMARY KEY (`WaiterID`),
  ADD KEY `EmployeeID` (`EmployeeID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `chef`
--
ALTER TABLE `chef`
  MODIFY `ChefID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `EmployeeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `menuitems`
--
ALTER TABLE `menuitems`
  MODIFY `ItemID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `orderitems`
--
ALTER TABLE `orderitems`
  MODIFY `OrderItemID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `OrderID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `patron`
--
ALTER TABLE `patron`
  MODIFY `PatronID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `PaymentID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `reservation`
--
ALTER TABLE `reservation`
  MODIFY `ReservationID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `waiter`
--
ALTER TABLE `waiter`
  MODIFY `WaiterID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `chef`
--
ALTER TABLE `chef`
  ADD CONSTRAINT `chef_ibfk_1` FOREIGN KEY (`EmployeeID`) REFERENCES `employees` (`EmployeeID`);

--
-- Constraints for table `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`);

--
-- Constraints for table `orderitems`
--
ALTER TABLE `orderitems`
  ADD CONSTRAINT `orderitems_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `orders` (`OrderID`),
  ADD CONSTRAINT `orderitems_ibfk_2` FOREIGN KEY (`MenuItemID`) REFERENCES `menuitems` (`ItemID`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`PatronID`) REFERENCES `patron` (`PatronID`);

--
-- Constraints for table `patron`
--
ALTER TABLE `patron`
  ADD CONSTRAINT `patron_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`);

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `orders` (`OrderID`);

--
-- Constraints for table `reservation`
--
ALTER TABLE `reservation`
  ADD CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`PatronID`) REFERENCES `patron` (`PatronID`);

--
-- Constraints for table `waiter`
--
ALTER TABLE `waiter`
  ADD CONSTRAINT `waiter_ibfk_1` FOREIGN KEY (`EmployeeID`) REFERENCES `employees` (`EmployeeID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
