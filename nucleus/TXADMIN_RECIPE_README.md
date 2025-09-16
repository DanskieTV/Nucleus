# Nucleus Framework txAdmin Recipe

This txAdmin recipe will automatically set up a complete FiveM server with the Nucleus framework.

## 🚀 **What This Recipe Does:**

### **Core Setup:**
- ✅ Downloads and configures Nucleus framework
- ✅ Sets up MySQL database with all required tables
- ✅ Configures server.cfg with proper settings
- ✅ Installs all required dependencies

### **Dependencies Installed:**
- **oxmysql** - Database connectivity
- **menuv** - UI library
- **progressbar** - Progress bar system
- **interact-sound** - Sound system
- **connectqueue** - Connection queue
- **PolyZone** - Zone detection
- **pma-voice** - Voice chat system

### **Framework Structure:**
```
resources/
├── [cfx-default]/          # Default FiveM resources
├── [standalone]/           # Standalone utilities
├── [voice]/               # Voice chat system
└── [nucleus]/             # Nucleus framework
    └── nucleus/           # Core framework
```

## 📋 **How to Use:**

### **Option 1: Full Recipe (Advanced)**
Use `nucleus_recipe.yaml` for a complete setup with all planned resources:
- Includes all future Nucleus resources (commented out until created)
- Ready for expansion
- More complex setup

### **Option 2: Simple Recipe (Recommended)**
Use `nucleus_simple_recipe.yaml` for basic setup:
- Just the core framework
- Essential dependencies only
- Clean and simple

## 🔧 **Setup Instructions:**

1. **Upload Recipe to txAdmin:**
   - Copy the recipe file to your txAdmin recipes folder
   - Or paste the recipe content into txAdmin web interface

2. **Configure Database:**
   - Update database connection in the recipe
   - Ensure MySQL server is running

3. **Run Recipe:**
   - Execute the recipe through txAdmin
   - Wait for all downloads to complete

4. **Start Server:**
   - The recipe will automatically configure everything
   - Server should start with Nucleus framework running

## ⚙️ **Customization:**

### **Before Running Recipe:**
- Update GitHub repository URLs to your actual repos
- Modify database connection settings
- Adjust server settings in the recipe

### **After Running Recipe:**
- Edit `server.cfg` for additional configuration
- Add custom resources to the `[nucleus]` folder
- Configure framework settings in `shared/config.lua`

## 🎯 **What You Get:**

- **Working FiveM server** with Nucleus framework
- **Database setup** with all required tables
- **Basic resources** for roleplay functionality
- **Voice chat** system
- **UI libraries** for future development
- **Clean structure** for easy expansion

## 🔄 **Future Updates:**

To add new Nucleus resources:
1. Create the resource
2. Add it to the recipe
3. Re-run the recipe or manually add to server.cfg

## 📝 **Notes:**

- The recipe includes `waste_time` actions to prevent GitHub rate limiting
- All resources are organized in proper folders
- Database is automatically configured
- Server.cfg is generated with proper settings

## 🆘 **Troubleshooting:**

**Recipe fails to download:**
- Check internet connection
- Verify GitHub repository URLs
- Ensure txAdmin has proper permissions

**Database errors:**
- Verify MySQL connection settings
- Check database permissions
- Ensure MySQL server is running

**Server won't start:**
- Check server.cfg syntax
- Verify all resources are downloaded
- Check console for error messages

This recipe provides a solid foundation for your Nucleus framework server!
