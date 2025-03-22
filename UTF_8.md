The command:  
```bash
echo -e "\xe2\x94\x80"
```
uses **UTF-8 encoding** because the box-drawing character `─` (**U+2500**) is not part of the standard ASCII set (0-127). It is part of **Unicode**, which requires multiple bytes in UTF-8.

---

### **Why UTF-8?**
1. **UTF-8 is a variable-length encoding**  
   - Standard **ASCII (0-127)** is 1 byte.  
   - Extended characters (like `─` **U+2500**) need **multiple bytes**.  

2. **UTF-8 Encoding of `─` (`U+2500`)**  
   - Unicode Code Point: **U+2500**
   - UTF-8 Representation: **`0xE2 0x94 0x80`**  
   - This is a **3-byte sequence**, meaning it requires three `\x` hex values.

3. **UTF-8 ensures compatibility**  
   - It works across different systems and terminals that support Unicode.  
   - It is backward compatible with ASCII.

---

### **Breaking Down the UTF-8 Encoding (`0xE2 0x94 0x80`):**
- `U+2500` (Decimal 9472) in **Binary**:  
  ```
  1001010000000
  ```
- UTF-8 Encoding Rule for **3-byte characters (`U+0800` - `U+FFFF`)**:
  ```
  1110xxxx 10xxxxxx 10xxxxxx
  ```
- Applying `U+2500` (`1001010000000` in binary):
  ```
  11100010 10010100 10000000
  ```
  - `11100010` = `E2`
  - `10010100` = `94`
  - `10000000` = `80`
  - Final UTF-8 Hex: **`E2 94 80`**

---

### **Alternative: Using Unicode Escape**
Instead of UTF-8 hex encoding, you can also use:
```bash
echo -e "\u2500"
```
This works because modern shells support Unicode escapes directly.

