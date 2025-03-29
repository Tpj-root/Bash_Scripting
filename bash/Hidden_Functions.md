#### Solution 1
#### Unset the Function When Disabled
#### sample code

```
Function_enable=1

if [[ "$Function_enable" -eq 1 ]]; then
    seq100() {
        seq 1 10
        sleep 2
    }
else
    unset -f seq100  # Remove the function
fi
```

```
#seq10
```


#### Solution 2: Dynamically Enable/Disable the Function
#### Create a wrapper script that reloads functions based on Function_enable
#### Now, if you set Function_enable=0 and run toggle_seq10, seq10 disappears. ✅

```
toggle_seq101() {
    if [[ "$Function_enable" -eq 1 ]]; then
        seq101() { seq 1 10; sleep 2; }
    else
        unset -f seq101  # Remove function
    fi
}
```

```
toggle_seq101  # Call this after changing Function_enable
```

#### Solution 3
#### If toggle_seq10 is just a helper function and you don’t want it in suggestions, name it with a _ prefix:
#### Bash autocomplete usually ignores _ prefixed functions unless you type 
```
_toggle_seq102() {
    if [[ "$_Function_enable" -eq 1 ]]; then
        seq102() { seq 1 10; sleep 2; }
    else
        unset -f seq10 2>/dev/null  # Remove function if it exists
    fi
}
```

```
#_toggle_seq102  # Call this after changing _Function_enable
```


#### Solution 4
#### Make toggle_seq10 a Local Function
#### If you don’t need toggle_seq10 outside the script, define it inside a conditional block:

```
_Function_enable=1

if [[ "$_Function_enable" -eq 1 ]]; then
    seq10() { seq 1 10; sleep 2; }
fi

#### Now _toggle_seq10 is removed after running and won’t show in suggestions.
unset -f _toggle_seq10 2>/dev/null  # Remove it after execution

```



#### Solution 5
#### Use an Alias Instead of a Function

```
if [[ "$_Function_enable" -eq 1 ]]; then
    alias seq10='seq 1 10; sleep 2'
else
    unalias seq10 2>/dev/null
fi
```



Here’s the table with symbols and their names:  

| **Symbol** | **Name**          |  
|-----------|----------------|  
| `_`       | Underscore      |  
| `.`       | Dot (Period)    |  
| `@`       | At Symbol       |  
| `:`       | Colon           |  
| `__`      | Double Underscore |  




These symbols can be used as **prefixes** to "hide" functions from regular Bash autocompletion but still allow access when explicitly typed. Here’s what they are called and how they work:  

##**Symbols & Their Uses in Function Names**
| Symbol | Example | Effect |
|---------|------------------|--------------------------------------|
| `_` (Underscore) | `_myfunc()` | Common for private/internal functions. Still shows if `Tab` is pressed after `_`. |
| `.` (Period/Dot) | `.myfunc()` | Less common but works. Needs explicit `.` to autocomplete. |
| `@` (At Symbol) | `@myfunc()` | Rarely used, but valid. Suggests only when typing `@` + `Tab`. |
| `__` (Double Underscore) | `__myfunc()` | Works like `_`, but useful for deeper internal functions. |
| `:` (Colon) | `:myfunc()` | Allowed in Bash function names, avoids autocomplete unless typed. |

##**Best Naming Practice**
- **For hiding functions:** Use `_` or `:` (e.g., `_myfunc` or `:myfunc`).  
- **For internal system functions:** Use `__` (e.g., `__internal_task`).  
- **For rarely used but accessible functions:** Use `.` or `@` (e.g., `.secret_func` or `@debug_func`).  




#### Note: Some special characters (like -) cannot be used in function names in Bash.

####  Stick to _ . @ : __

#### Use a Period (.)

#### Typing . + Tab will suggest .function_hidden.

#### Hidden from normal autocomplete unless you start with .
```
.function_hidden() { echo "Secret Function"; }
```

#### Use @ (or Any Special Character)

#### Works the same way as _, but @ is less common in functions.

```
@hidden_func() { echo "Not in normal autocomplete"; }
```



#### Use Double Underscore (__)

#### Works like _, but less likely to interfere with existing functions.
```
__internal_func() { echo "Hidden Function"; }
```

#### Use a Prefix with :

#### Works in most Bash versions.
````
:hidden_function() { echo "This is hidden"; }
```








Here are some function name ideas using **_ . @ : __** prefixes:  

### **Underscore (`_`) – General Private Functions**
- `_init_config()`
- `_cleanup_temp_files()`
- `_update_system()`
- `_check_permissions()`
- `_debug_mode()`

---

### **Dot (`.`) – Hidden Utility Functions**
- `.reload_env()`
- `.backup_data()`
- `.reset_network()`
- `.toggle_feature()`
- `.secure_wipe()`

---

### **At Symbol (`@`) – Special or Debugging Functions**
- `@test_mode()`
- `@force_restart()`
- `@log_errors()`
- `@safe_shutdown()`
- `@quick_scan()`

---

### **Double Underscore (`__`) – Deep Internal Functions**
- `__parse_config()`
- `__fetch_remote_data()`
- `__update_cache()`
- `__run_critical_task()`
- `__check_integrity()`

---

### **Colon (`:`) – Special System-Like Functions**
- `:enable_feature()`
- `:disable_logging()`
- `:secure_erase()`
- `:reset_device()`
- `:toggle_debug()`

💡 **Choose based on your workflow!** `_` and `:` are best for keeping things hidden but accessible when needed. 🚀



Here are function name ideas using your preferred symbols:  

### **Function Name Format** → **`Symbol + Meaningful Name`**  

| **Symbol** | **Example Function Name** | **Purpose** |
|------------|--------------------------|------------|
| `_` (Underscore) | `_init()` | Private initialization function |
| `_` | `_cleanup()` | Internal cleanup process |
| `_` | `_update_db()` | Database update operation |
| `_` | `_log_error()` | Log errors internally |
| `_` | `_check_status()` | Hidden status check |
| `.` (Dot) | `.reload_env()` | Hidden environment reload |
| `.` | `.reset_net()` | Reset network settings |
| `.` | `.secure_wipe()` | Securely erase sensitive data |
| `.` | `.backup_data()` | Backup system data |
| `.` | `.toggle_feature()` | Enable/disable a feature |
| `@` (At Symbol) | `@debug()` | Debugging mode function |
| `@` | `@test_mode()` | Enable test mode |
| `@` | `@quick_scan()` | Run a quick system scan |
| `@` | `@force_restart()` | Restart system forcefully |
| `@` | `@log_errors()` | Log error messages |
| `:` (Colon) | `:enable_feature()` | Special feature toggle |
| `:` | `:disable_logging()` | Disable system logging |
| `:` | `:secure_erase()` | Securely delete files |
| `:` | `:reset_device()` | Factory reset |
| `:` | `:toggle_debug()` | Switch debug mode |
| `__` (Double Underscore) | `__parse_config()` | Deep internal config parser |
| `__` | `__fetch_data()` | Fetch remote data |
| `__` | `__update_cache()` | Cache update function |
| `__` | `__run_critical()` | Perform a critical task |
| `__` | `__check_integrity()` | Internal integrity check |

💡 **Pick symbols based on how "hidden" you want the function to be!** 🚀