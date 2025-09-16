# Nucleus Framework Installation Guide

## Quick Start

1. **Database Setup**
   - Import `database.sql` into your MySQL database
   - Make sure your database connection string in `server.cfg` is correct

2. **Dependencies**
   - Ensure `oxmysql` resource is installed and running
   - Add `ensure oxmysql` to your `server.cfg` before `ensure nucleus`

3. **Framework Installation**
   - Place the `nucleus` folder in your server's `resources` directory
   - Add `ensure nucleus` to your `server.cfg`

4. **Start Server**
   - Start your FiveM server
   - Check console for framework startup messages

## Server.cfg Example

```cfg
# Dependencies
ensure oxmysql

# Core Framework
ensure nucleus
```

## Database Connection

Make sure your `server.cfg` has the correct MySQL connection string:

```cfg
set mysql_connection_string "mysql://username:password@localhost/database_name?charset=utf8mb4"
```

## Verification

After starting the server, you should see:
- `[Nucleus] Starting Nucleus Framework...`
- `[Nucleus] Framework started successfully!`
- `[Nucleus Test] All tests passed! Framework is ready to use.`

## Troubleshooting

**Framework won't start:**
- Check if `oxmysql` is running
- Verify database connection
- Check console for error messages

**Database errors:**
- Make sure `database.sql` was imported correctly
- Verify MySQL connection string
- Check database permissions

**Player data not saving:**
- Ensure database tables exist
- Check MySQL connection
- Verify player has proper permissions

## Next Steps

Once the framework is running, you can:
1. Add custom jobs in `shared/config.lua`
2. Create custom items
3. Add new vehicles
4. Build additional scripts on top of the framework

## Support

For issues or questions, check the console output for error messages and ensure all dependencies are properly installed.
