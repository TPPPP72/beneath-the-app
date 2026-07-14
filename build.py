import os
import re
import subprocess
import sys

GLOBAL_FILE = "global.typ"          
COVER_FILE = "cover.typ"            
EPIGRAPH_FILE = "epigraph.typ"      
CHAPTERS_DIR = "chapters"           
TEMP_BUILD_FILE = "_main_build.typ" 

OUTPUT_DIR = "build"
OUTPUT_PDF = os.path.join(OUTPUT_DIR, "book.pdf")

def extract_version_key(file_path):
    directory, filename = os.path.split(file_path)
    
    dir_numbers = re.findall(r'\d+', directory)
    dir_key = tuple(map(int, dir_numbers)) if dir_numbers else (0,)

    name_without_ext = os.path.splitext(filename)[0]
    file_numbers = re.findall(r'\d+', name_without_ext)
    file_key = tuple(map(int, file_numbers)) if file_numbers else (0,)
    
    return (dir_key, file_key)

def scan_and_sort_chapters(directory):
    typ_files = []
    if not os.path.exists(directory):
        print(f"⚠️ 警告: 未找到章节目录 '{directory}'")
        return typ_files

    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith('.typ'):
                full_path = os.path.join(root, file).replace('\\', '/')
                typ_files.append(full_path)
    
    typ_files.sort(key=extract_version_key)
    return typ_files

def build():
    print("🚀 开始拼装 Typst 电子书...")

    if not os.path.exists(OUTPUT_DIR):
        os.makedirs(OUTPUT_DIR)
        print(f"📁 已自动创建输出文件夹: {OUTPUT_DIR}")

    content_lines = []

    if os.path.exists(GLOBAL_FILE):
        with open(GLOBAL_FILE, 'r', encoding='utf-8') as f:
            content_lines.append(f.read())
        content_lines.append("\n")
    else:
        print(f"❌ 错误: 找不到全局配置文件 {GLOBAL_FILE}")
        sys.exit(1)

    if os.path.exists(COVER_FILE):
        content_lines.append(f'#include "{COVER_FILE}"')
        content_lines.append("#pagebreak()\n")
        print("📝 已添加封面")

    if os.path.exists(EPIGRAPH_FILE):
        content_lines.append(f'#include "{EPIGRAPH_FILE}"')
        content_lines.append("#pagebreak()\n")
        print("📝 已添加引言")

    chapter_files = scan_and_sort_chapters(CHAPTERS_DIR)
    if not chapter_files:
        print("⚠️ 未发现任何章节 .typ 文件")
    else:
        print(f"🔍 扫描到 {len(chapter_files)} 个章节文件，排序结果如下：")
        total_files = len(chapter_files)
        for index, path in enumerate(chapter_files):
            print(f"  -> {path}")
            content_lines.append(f'#include "{path}"')
            
            if index < total_files - 1:
                content_lines.append("#pagebreak()")
                
        content_lines.append("\n")

    with open(TEMP_BUILD_FILE, 'w', encoding='utf-8') as f:
        f.write("\n".join(content_lines))

    print(f"\n⚡ 正在调用 Typst 编译 PDF...")
    try:
        result = subprocess.run(
            ["typst", "compile", "--font-path", "./fonts", TEMP_BUILD_FILE, OUTPUT_PDF],
            check=True,
            capture_output=True,
            text=True,
            encoding="utf-8",
            errors="ignore"
        )
        print(f"🎉 编译成功！已生成: {OUTPUT_PDF}")
    except subprocess.CalledProcessError as e:
        print("❌ Typst 编译失败！")
        print(e.stderr)
    except FileNotFoundError:
        print("❌ 错误: 系统中未找到 'typst' 命令行工具。")
    finally:
        if os.path.exists(TEMP_BUILD_FILE):
            os.remove(TEMP_BUILD_FILE)

if __name__ == "__main__":
    build()