use [LegoInventoryTracker]
go

ALTER TABLE [User]
ADD CHECK (LEN(Username) > 0)