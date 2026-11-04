from PyPDF2 import PdfReader
import requests
import re
from difflib import unified_diff
from google import genai

client = genai.Client(
    api_key="")
# ------------------------------
# CONFIGURATION
# ------------------------------



# ------------------------------
# READ DOCUMENT
# ------------------------------

def read_document(path: str) -> str:
    """
    Read text from a PDF or TXT file.
    """

    if path.lower().endswith(".pdf"):
        reader = PdfReader(path)

        return "\n".join(
            page.extract_text() or ""
            for page in reader.pages
        )

    with open(path, "r", encoding="utf-8") as f:
        return f.read()


# ------------------------------
# READ WEBPAGE
# ------------------------------

def read_webpage(url: str)->str:
    """
    Download webpage content and
    remove HTML tags.
    """

    response = requests.get(
        url,
        headers={"User-Agent": "Mozilla/5.0"}
    )

    response.raise_for_status()
html = response.text

    html = re.sub(
        r"<script.*?</script>",
        "",
        html,
        flags=re.DOTALL
    )

    html = re.sub(
        r"<style.*?</style>",
        "",
        html,
        flags=re.DOTALL
    )

    html = re.sub(
        r"<[^>]+>",
        " ",
        html
    )

    return " ".join(html.split())


# ------------------------------
# SUMMARIZE WITH GEMINI
# ------------------------------

def summarize(text: str, focus=None) -> str:

    prompt = f"""
Summarize the following policy document:

{text}
"""

    if focus:
        prompt += f"\n\nPay special attention to: {focus}"

    response = client.models.generate_content(
        model="gemini-2.5-flash",
        contents=prompt
    )

    return response.text


# ------------------------------
# EXTRACT DATES
# ------------------------------

def check_dates(text):

    patterns = [
        r"\b\d{1,2}[/-]\d{1,2}[/-]\d{2,4}\b",
        r"\b(?:January|February|March|April|May|June|July|August|September|October|November|December)\s+\d{1,2},\s+\d{4}\b"
    ]

    dates = []

    for pattern in patterns:
        matches = re.findall(
            pattern,
            text,
            re.IGNORECASE
        )

        dates.extend(matches)

    return sorted(list(set(dates)))


# ------------------------------
# COMPARE POLICY VERSIONS
# ------------------------------

def compare_versions(old_text, new_text):

    old_lines = old_text.splitlines()
    new_lines = new_text.splitlines()

    diff = unified_diff(
        old_lines,
        new_lines,
        fromfile="Old Policy",
        tofile="New Policy",
        lineterm=""
    )

    return "\n".join(diff)


# ------------------------------
# MAIN MENU
# ------------------------------

def main():

    print("\n==============================")
    print(" POLICY ANALYZER ")
    print("==============================")

    print("\n1. Summarize PDF")
    print("2. Summarize Website")
    print("3. Extract Dates from PDF")
    print("4. Compare Two Policies")

    choice = input("\nChoose an option (1-4): ").strip()

    try:

        # --------------------------
        # OPTION 1
        # --------------------------

        if choice == "1":

            pdf_path = input(
                "Enter PDF file path: "
            ).strip()

            text = read_document(pdf_path)

            focus = input(
                "Optional focus area: "
            ).strip()

            summary = summarize(
                text,
                focus if focus else None
            )

            print("\n===== SUMMARY =====\n")
            print(summary)

        # --------------------------
        # OPTION 2
        # --------------------------

        elif choice == "2":

            url = input(
                "Enter Website URL: "
            ).strip()

            text = read_webpage(url)

            focus = input(
                "Optional focus area: "
            ).strip()

            summary = summarize(
                text,
                focus if focus else None
            )

            print("\n===== SUMMARY =====\n")
            print(summary)

        # --------------------------
        # OPTION 3
        # --------------------------

        elif choice == "3":

            pdf_path = input(
                "Enter PDF file path: "
            ).strip()

            text = read_document(pdf_path)

            dates = check_dates(text)

            print("\n===== DATES FOUND =====\n")

            if dates:
                for date in dates:
                    print(date)
            else:
                print("No dates found.")

        # --------------------------
        # OPTION 4
        # --------------------------

        elif choice == "4":

            old_pdf = input(
                "Enter OLD policy PDF: "
            ).strip()

            new_pdf = input(
                "Enter NEW policy PDF: "
            ).strip()

            old_text = read_document(old_pdf)
            new_text = read_document(new_pdf)

            differences = compare_versions(
                old_text,
                new_text
            )

            print("\n===== DIFFERENCES =====\n")
            print(differences)

        else:
            print("Invalid option selected.")

    except Exception as e:
        print(f"\nError: {e}")


# ------------------------------
# PROGRAM ENTRY POINT
# ------------------------------

if __name__ == "__main__":
    main()
