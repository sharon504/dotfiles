# Java & Spring Boot Development Setup for Neovim

## 🎉 Installation Complete!

Your Neovim configuration now supports **full-featured Java and Spring Boot development** with automatic activation.

---

## 📋 What Was Added

### New Files Created:
1. **`lua/plugins/java/nvim-java.lua`** - Main Java/Spring Boot plugin configuration
2. **`lua/plugins/java/keymaps.lua`** - Java-specific keybindings

### Modified Files:
1. **`lua/plugins/coding/treesitter.lua`** - Added Java parser
2. **`lua/plugins/coding/formatting.lua`** - Added google-java-format
3. **`lua/plugins/coding/linting.lua`** - Added checkstyle
4. **`lua/plugins/lsp/mason.lua`** - Added Java tools

---

## 🚀 First-Time Setup

### Step 1: Install Plugins

Open Neovim and let lazy.nvim install the new plugins:

```bash
nvim
```

Lazy.nvim will automatically detect and install:
- nvim-java
- spring-boot.nvim
- nui.nvim
- All dependencies

**Wait for installation to complete** (check bottom-right status).

### Step 2: Install Java Tools

Once plugins are installed, Mason will automatically install:
- JDTLS (Java Language Server)
- java-debug-adapter
- java-test
- google-java-format
- checkstyle

**This happens automatically in the background** (~30 seconds).

You can verify installation:
```vim
:Mason
```

Look for these packages in the Mason UI:
- ✓ jdtls
- ✓ java-debug-adapter
- ✓ java-test
- ✓ google-java-format
- ✓ checkstyle

### Step 3: Install Java Treesitter Parser

The Java parser will auto-install on first .java file open, but you can manually install:

```vim
:TSInstall java
```

### Step 4: Verify Installation

Check that nvim-java loaded successfully:

```vim
:checkhealth java
```

This will show:
- ✓ nvim-java installed
- ✓ JDTLS available
- ✓ JDK detected (or auto-install prompt)

---

## 🏃 Quick Start Guide

### Opening a Java Project

1. **Navigate to your Spring Boot project:**
   ```bash
   cd ~/projects/my-spring-boot-app
   nvim src/main/java/com/example/Application.java
   ```

2. **First-time project setup** (takes ~30-60 seconds):
   - JDTLS analyzes project structure
   - Detects Maven/Gradle
   - Indexes dependencies
   - Spring Boot LS starts (if Spring detected)

3. **Look for status indicators:**
   - Status line shows: "Java ☕"
   - Bottom-right: "JDTLS started"
   - Spring projects: "Spring Boot LS active"

### Creating a Test Spring Boot Project

If you don't have a project yet:

```bash
# Using Spring Initializr (requires curl)
curl https://start.spring.io/starter.zip \
  -d dependencies=web,devtools \
  -d language=java \
  -d javaVersion=17 \
  -d type=maven-project \
  -d groupId=com.example \
  -d artifactId=demo \
  -o demo.zip

unzip demo.zip -d demo
cd demo
nvim src/main/java/com/example/demo/DemoApplication.java
```

Or use the web UI: https://start.spring.io

---

## ⌨️ Keybindings Reference

All Java commands use the `<leader>J` prefix (default leader: `<Space>`).

### 🔨 Build Commands (`<leader>Jb`)

| Keybinding | Action | Description |
|------------|--------|-------------|
| `<leader>Jbb` | Build workspace | Full project build |
| `<leader>Jbc` | Clean workspace | Clear cache/compiled files |

### 🏃 Runner Commands (`<leader>Jr`)

| Keybinding | Action | Description |
|------------|--------|-------------|
| `<leader>Jrr` | Run main class | Execute application |
| `<leader>Jrs` | Stop app | Terminate running app |
| `<leader>Jrl` | Toggle logs | Show/hide runner output |

**Example Usage:**
1. Open any Java file with a `main()` method
2. Press `<Space>Jrr`
3. If multiple main classes exist, a picker appears
4. Select the class to run
5. Runner window opens with live logs
6. Stop with `<Space>Jrs`

### 🧪 Test Commands (`<leader>Jt`)

| Keybinding | Action | Description |
|------------|--------|-------------|
| `<leader>Jtc` | Run current test class | Execute all tests in file |
| `<leader>Jtm` | Run current test method | Execute test under cursor |
| `<leader>Jta` | Run all tests | Execute entire test suite |
| `<leader>Jtd` | Debug current test method | Debug test under cursor |
| `<leader>JtD` | Debug current test class | Debug all tests in file |
| `<leader>Jtr` | View test report | Show last test results |

**Example Usage:**
1. Open a JUnit test file: `MyServiceTest.java`
2. Position cursor on a test method (e.g., `testFindUser()`)
3. Press `<Space>Jtm` to run just that test
4. Press `<Space>Jtr` to see detailed results

### 🌱 Spring Boot Commands (`<leader>Js`)

| Keybinding | Action | Description |
|------------|--------|-------------|
| `<leader>Jsb` | Find Spring Beans | Search all @Component, @Service, etc. |
| `<leader>Jse` | Find Web Endpoints | Search all @RequestMapping endpoints |
| `<leader>Jsp` | Find properties | Open application.properties/yml |

**Spring Bean Discovery:**
- Press `<Space>Jsb`
- Telescope opens with all Spring-managed beans
- Filter by name (e.g., "UserService")
- Press Enter to jump to definition

**Web Endpoint Discovery:**
- Press `<Space>Jse`
- Shows all REST endpoints with HTTP methods
- Example: `GET /api/users` → `UserController.getUsers()`

### ✂️ Refactoring Commands (`<leader>Je`)

| Keybinding | Action | Mode | Description |
|------------|--------|------|-------------|
| `<leader>Jev` | Extract variable | n, v | Create variable from expression |
| `<leader>JeV` | Extract variable (all) | n, v | Replace all occurrences |
| `<leader>Jec` | Extract constant | n, v | Create constant |
| `<leader>Jem` | Extract method | n, v | Create method from selection |
| `<leader>Jef` | Extract field | n, v | Create class field |

**Example - Extract Variable:**
1. Position cursor on: `user.getAddress().getCity()`
2. Press `<Space>Jev`
3. Type variable name: `city`
4. Result: `String city = user.getAddress().getCity();`

**Example - Extract Method:**
1. Visual select code block (V + movement)
2. Press `<Space>Jem`
3. Type method name: `validateUser`
4. Code moved to new method with proper signature

### ⚙️ Configuration Commands (`<leader>Jc`)

| Keybinding | Action | Description |
|------------|--------|-------------|
| `<leader>Jcr` | Change JDK runtime | Switch Java version |
| `<leader>Jcp` | Open profiles UI | Manage run/debug profiles |

### 🐛 Debug Commands (`<leader>d`)

**Your existing DAP keybindings work automatically with Java!**

| Keybinding | Action | Description |
|------------|--------|-------------|
| `<leader>db` | Toggle breakpoint | Set breakpoint on line |
| `<leader>dc` | Continue/Start | Start or continue debugging |
| `<leader>di` | Step into | Step into method |
| `<leader>do` | Step out | Step out of method |
| `<leader>dO` | Step over | Step over line |
| `<leader>du` | Toggle DAP UI | Show/hide debug UI |
| `<leader>de` | Evaluate expression | Eval code in debug context |

**Example - Debug Spring Boot App:**
1. Set breakpoint in controller: move to line, press `<Space>db`
2. Start debug: `<Space>dc`
3. Select main class (if multiple)
4. App starts in debug mode
5. Make HTTP request to trigger breakpoint
6. DAP UI shows variables, call stack
7. Step through: `<Space>di`, `<Space>do`, `<Space>dO`

### 🔧 Utility Commands (`<leader>J`)

| Keybinding | Action | Description |
|------------|--------|-------------|
| `<leader>Ju` | Update config | Refresh project configuration |
| `<leader>JB` | Show bytecode | View compiled bytecode |
| `<leader>JJ` | Open JShell | Interactive Java REPL |
| `<leader>JR` | Restart JDTLS | Restart language server |
| `<leader>JdC` | Update debug config | Refresh debug settings |
| `<leader>JdH` | Update hotcode | Hot reload changes |

---

## 🌱 Spring Boot Specific Features

### 1. Spring Bean Navigation

**Automatic Bean Detection:**
- `@Component`, `@Service`, `@Repository`, `@Controller`, `@RestController`
- `@Configuration`, `@Bean`
- Spring Data repositories
- `@Autowired` dependencies

**Usage:**
```java
// In any file, press <Space>Jsb, type "userService"
@Service
public class UserService {
    // Jump here directly
}
```

### 2. Web Endpoint Discovery

**Detected Mappings:**
- `@RequestMapping`, `@GetMapping`, `@PostMapping`, etc.
- Shows HTTP method + path
- Includes request/response types

**Usage:**
```java
@RestController
@RequestMapping("/api/users")
public class UserController {
    
    @GetMapping("/{id}")  // Shows as: GET /api/users/{id}
    public User getUser(@PathVariable Long id) {
        // Press <Space>Jse to find this endpoint
    }
}
```

### 3. Application Properties Support

**Features:**
- Autocomplete for Spring properties
- Validation for property keys
- Navigation to property definition
- Hover documentation

**Usage in `application.properties`:**
```properties
# Type "server." → autocomplete suggestions
server.port=8080
spring.datasource.url=jdbc:mysql://localhost/mydb

# Ctrl+] to jump to property definition
# K to see property documentation
```

### 4. Spring Boot Runner Integration

**Features:**
- Detects `@SpringBootApplication` main class
- Auto-configures runner for Spring Boot
- Live log output in Neovim
- Proper shutdown handling

**Console Output Shows:**
```
  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::                (v3.2.0)

2024-03-22 10:15:32.123  INFO : Starting Application...
2024-03-22 10:15:34.567  INFO : Started Application in 2.444 seconds
```

---

## 🔍 Common Workflows

### Workflow 1: Developing a REST API

```
1. Open controller: nvim UserController.java
2. Auto-completion works: @GetMapping, @Autowired, etc.
3. Find all endpoints: <Space>Jse
4. Run app: <Space>Jrr
5. Test endpoint: curl http://localhost:8080/api/users
6. See logs in runner window: <Space>Jrl
7. Stop app: <Space>Jrs
```

### Workflow 2: Writing and Running Tests

```
1. Create test: UserServiceTest.java
2. Write test with auto-completion
3. Run single test: <Space>Jtm (cursor on test method)
4. Run all class tests: <Space>Jtc
5. View results: <Space>Jtr
6. Debug failing test: <Space>Jtd
```

### Workflow 3: Debugging Spring Boot Application

```
1. Set breakpoint in service method: <Space>db
2. Start debug: <Space>dc
3. Open DAP UI: <Space>du
4. Make HTTP request to trigger breakpoint
5. Inspect variables in DAP UI
6. Step through code: <Space>di, <Space>do
7. Evaluate expressions: <Space>de
8. Continue or stop: <Space>dc or <Space>dt
```

### Workflow 4: Refactoring Code

```
1. Extract magic number:
   - Cursor on: timeout = 5000;
   - Press: <Space>Jec
   - Name: TIMEOUT_MS
   - Result: private static final int TIMEOUT_MS = 5000;

2. Extract complex logic:
   - Visual select code block: V + movement
   - Press: <Space>Jem
   - Name: validateUserInput
   - Result: New method created with proper signature
```

---

## 🛠️ Troubleshooting

### JDTLS Not Starting

**Symptoms:**
- No completions
- No diagnostics
- No "Java ☕" in status line

**Solutions:**
1. Check JDTLS installation:
   ```vim
   :Mason
   ```
   Ensure `jdtls` shows ✓

2. Check health:
   ```vim
   :checkhealth java
   ```

3. View logs:
   ```vim
   :lua print(vim.fn.stdpath('state') .. '/nvim-java.log')
   ```
   Then open the log file to see errors

4. Restart JDTLS:
   ```vim
   :JdtRestart
   ```

5. Clean workspace:
   ```vim
   <Space>Jbc
   ```
   Then restart Neovim

### No Spring Boot Features

**Symptoms:**
- Spring beans not found
- No endpoint detection
- Properties not autocompleting

**Verify Spring Dependencies:**
1. Check if project has Spring Boot in `pom.xml` or `build.gradle`:
   ```xml
   <!-- Maven -->
   <parent>
       <groupId>org.springframework.boot</groupId>
       <artifactId>spring-boot-starter-parent</artifactId>
   </parent>
   ```
   
   ```gradle
   // Gradle
   plugins {
       id 'org.springframework.boot'
   }
   ```

2. Manually update config:
   ```vim
   <Space>Ju
   ```

3. Check Spring Boot LS loaded:
   ```vim
   :lua print(vim.inspect(vim.lsp.get_active_clients()))
   ```
   Look for `spring_boot` client

### JDK Version Issues

**Symptoms:**
- "Java XX features not available"
- Syntax errors on newer Java syntax

**Solution:**
Change runtime:
```vim
<Space>Jcr
```
Select correct JDK version from list

Or configure in setup:
```lua
-- In nvim-java.lua
jdk = {
  version = "21", -- Change to desired version
}
```

### Slow Performance

**Symptoms:**
- Laggy completions
- Slow diagnostics
- High CPU usage

**Solutions:**
1. Limit indexed files:
   ```java
   // Add to .gitignore:
   target/
   build/
   .idea/
   *.class
   ```

2. Disable unused features temporarily:
   ```vim
   :lua vim.lsp.inlay_hint.enable(false)
   ```

3. Increase JDTLS memory (advanced):
   Add to nvim-java.lua:
   ```lua
   jdtls = {
     jvm_args = { "-Xmx2G" }, -- Increase heap to 2GB
   }
   ```

---

## 📚 Additional Resources

### Documentation
- **nvim-java**: https://github.com/nvim-java/nvim-java
- **spring-boot.nvim**: https://github.com/JavaHello/spring-boot.nvim
- **JDTLS**: https://github.com/eclipse/eclipse.jdt.ls

### Example Projects
- **Spring Boot Starter**: https://start.spring.io
- **Spring Guides**: https://spring.io/guides

### Community
- **nvim-java Issues**: https://github.com/nvim-java/nvim-java/issues
- **Neovim Discourse**: https://neovim.discourse.group

---

## 🎯 Quick Reference Card

**Print this for your desk!**

```
┌─────────────────────────────────────────────────┐
│        Java & Spring Boot - Quick Keys          │
├─────────────────────────────────────────────────┤
│ BUILD                                           │
│  <Space>Jbb  → Build workspace                  │
│  <Space>Jbc  → Clean workspace                  │
├─────────────────────────────────────────────────┤
│ RUN                                             │
│  <Space>Jrr  → Run main class                   │
│  <Space>Jrs  → Stop app                         │
│  <Space>Jrl  → Toggle logs                      │
├─────────────────────────────────────────────────┤
│ TEST                                            │
│  <Space>Jtc  → Run test class                   │
│  <Space>Jtm  → Run test method                  │
│  <Space>Jtd  → Debug test                       │
│  <Space>Jtr  → View report                      │
├─────────────────────────────────────────────────┤
│ SPRING BOOT                                     │
│  <Space>Jsb  → Find Spring Beans                │
│  <Space>Jse  → Find Web Endpoints               │
│  <Space>Jsp  → Find properties                  │
├─────────────────────────────────────────────────┤
│ REFACTOR                                        │
│  <Space>Jev  → Extract variable                 │
│  <Space>Jec  → Extract constant                 │
│  <Space>Jem  → Extract method                   │
├─────────────────────────────────────────────────┤
│ DEBUG (existing keybindings work!)              │
│  <Space>db   → Toggle breakpoint                │
│  <Space>dc   → Start/Continue                   │
│  <Space>di   → Step into                        │
│  <Space>do   → Step out                         │
│  <Space>du   → Toggle DAP UI                    │
└─────────────────────────────────────────────────┘
```

---

## ✅ Summary

**You now have:**
- ✅ Full Java LSP support (JDTLS)
- ✅ Spring Boot Language Server integration
- ✅ Auto-completion for Java & Spring
- ✅ Java debugging via nvim-dap
- ✅ JUnit test running & debugging
- ✅ Spring Bean & Endpoint discovery
- ✅ application.properties/yml support
- ✅ Code refactoring tools
- ✅ Integrated runner for Spring Boot apps
- ✅ Java formatting (google-java-format)
- ✅ Java linting (checkstyle)

**Zero impact on existing languages:**
- ✅ Rust, C/C++, Python, Go, Lua, JS/TS all untouched
- ✅ Java isolated in `lua/plugins/java/` directory
- ✅ Auto-activates only when opening `.java` files

**Next Steps:**
1. Restart Neovim: `:qa` then `nvim`
2. Let plugins install automatically
3. Open a Java file or create a Spring Boot project
4. Start coding! 🚀

Enjoy your enhanced Java development experience! ☕
