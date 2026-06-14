# Marketplace Seller Contact — Solution Design

Covers Facebook Marketplace, Gumtree, and eBay.
Focus: search term schemas, seller outreach message drafting, listing/reply evaluation, and product recommendations.

---

## Search Term Schema

```json
{
  "solutionDomain": "marketplace laptop/workstation sourcing and seller verification",
  "searchSchema": {
    "intentGroups": [
      "modelDiscovery",
      "upgradeability",
      "serviceability",
      "refurbVerification",
      "importRisk",
      "resaleArbitrage",
      "sellerContact"
    ]
  },
  "defaultSearchPack": {
    "baseTerms": [
      "used laptop",
      "used workstation",
      "mobile workstation",
      "upgradeable laptop",
      "gaming laptop",
      "refurbished laptop",
      "desktop replacement laptop"
    ],
    "brandTerms": [
      "Dell Precision",
      "HP ZBook Fury",
      "Lenovo ThinkPad P",
      "MSI Titan 18 HX",
      "Framework Laptop 16",
      "HP Omen 17",
      "Acer Nitro 17",
      "ASUS TUF F17"
    ],
    "specTerms": [
      "SO-DIMM RAM",
      "2 RAM slots",
      "4 RAM slots",
      "2 M.2 slots",
      "BIOS screenshot",
      "battery health",
      "SMART SSD",
      "service tag",
      "serial number",
      "GPU model",
      "screen resolution",
      "refresh rate"
    ],
    "riskTerms": [
      "no return policy",
      "spec mismatch",
      "hidden defects",
      "grey market",
      "warranty transfer",
      "asset tag",
      "BIOS lock",
      "cosmetic only photos",
      "works great no tests"
    ],
    "geoTerms": ["Australia", "US", "Japan", "EU", "Hong Kong", "Singapore"],
    "marketplaceTerms": ["Facebook Marketplace", "Gumtree", "eBay"],
    "exampleSearches": [
      "Facebook Marketplace Dell Precision BIOS screenshot battery health",
      "Gumtree HP ZBook Fury serial number screenshot",
      "eBay Lenovo ThinkPad P used workstation return policy",
      "Facebook Marketplace gaming laptop 2 RAM slots 2 M.2",
      "Gumtree refurbished workstation BIOS Device Manager screenshots",
      "eBay MSI Titan 18 HX upgrade RAM slots",
      "Facebook Marketplace used laptop no return policy warning signs",
      "Gumtree Dell Precision battery health check",
      "eBay HP ZBook Fury serviceability RAM SSD",
      "used workstation Australia seller proof of testing"
    ]
  }
}
```

---

## Seller Contact Strategy

### Platform-specific tone

| Platform | Style | Key focus |
|---|---|---|
| Facebook Marketplace | Short, friendly, low-friction | Assume incomplete listings; expect negotiation |
| Gumtree | Classified-style, direct | Condition, accessories, return clarity |
| eBay | Structured, fact-checking | Verify discrepancies, seller feedback, shipping |

### Core rule
Treat anything not explicitly confirmed by the seller as **unknown**, not safe.
Require documented testing, not just "works great".

---

## Seller Verification Message Template

```json
{
  "templateName": "sellerVerificationMessage",
  "tone": "clear, polite, buyer-protective",
  "sections": [
    {
      "label": "Identity & specs",
      "asks": [
        "Exact model name/number",
        "Serial number / service tag (photo of bottom label is fine)",
        "CPU model",
        "GPU model",
        "Installed RAM — size, number of sticks, DDR generation, speed",
        "Storage — each drive's size, type (SATA/NVMe), brand if known",
        "Screen size and resolution (e.g. 17.3\" 2560×1440 165 Hz)",
        "Any replaced or upgraded parts vs original factory config?"
      ]
    },
    {
      "label": "Refurb testing performed",
      "asks": [
        "What tests did you run beyond 'powers on'? (e.g. RAM test, SSD SMART check, CPU/GPU stress test, port check)",
        "Can you confirm there are no BIOS passwords, asset tags, or locks remaining?",
        "Any known faults? (fan noise, thermal throttling, dead/stuck pixels, loose hinge, damaged ports, Wi-Fi issues)"
      ]
    },
    {
      "label": "Battery & thermals (laptops)",
      "asks": [
        "Battery health / wear level, or screenshot from battery report tool",
        "Under load, do the fans ramp normally without errors or unusual grinding noises?"
      ]
    },
    {
      "label": "Photos & screenshots",
      "asks": [
        "Photo of serial/asset tag on chassis",
        "BIOS/UEFI System Information screen showing CPU, RAM, storage, model",
        "Windows System About or Device Manager screen",
        "Clear photos of: top cover, keyboard, screen on, ports both sides, power adapter"
      ]
    },
    {
      "label": "Windows licence & accessories",
      "asks": [
        "Is Windows activated with a valid licence (OEM/retail/volume)?",
        "Included accessories: original charger, power cable, any dock/adapter?"
      ]
    },
    {
      "label": "Warranty, return & shipping",
      "asks": [
        "Store/manufacturer warranty term (months) and what it covers",
        "Return window and who pays return shipping if the unit is not as described",
        "How will you pack the laptop/workstation and charger for shipping? (double-boxing, padding, insurance, tracking)"
      ]
    }
  ],
  "shortVersion": "Hi, I'm interested in this item and just want to confirm the exact specs and condition before buying. Could you please confirm the exact model, CPU, GPU, RAM configuration, storage, screen size/resolution, battery health, and whether any parts were replaced or upgraded? Also, could you attach a BIOS/System Information screenshot, a photo of the serial or service tag, and let me know what testing you performed beyond just powering it on? Please also confirm any faults, return policy, included charger/accessories, and how it would be packed if shipped."
}
```

---

## Listing + Reply Evaluation JSON

Paste this into Google AI Studio to score a listing and seller reply:

```json
{
  "task": "Evaluate a marketplace laptop/workstation listing and seller reply for accuracy, risk, and missing information.",
  "inputs": {
    "marketplace": "facebook | gumtree | ebay",
    "listingTitle": "",
    "listingDescription": "",
    "sellerReply": "",
    "targetUse": "personal use | resale | workstation | gaming"
  },
  "requiredOutput": {
    "normalizedSpecs": {
      "brand": "",
      "model": "",
      "cpu": "",
      "gpu": "",
      "ramGb": null,
      "ramConfig": "",
      "storage": "",
      "screenSizeInch": "",
      "resolution": "",
      "batteryHealth": "",
      "portsSummary": "",
      "notes": ""
    },
    "testingEvidence": {
      "hasBiosScreenshot": false,
      "hasDeviceManagerScreenshot": false,
      "hasSmartOrDiskTest": false,
      "hasBatteryReport": false,
      "testsClaimed": []
    },
    "conditionAssessment": {
      "cosmeticGrade": "",
      "functionalIssues": [],
      "coolingOrFanConcerns": "",
      "missingAccessories": []
    },
    "riskFlags": {
      "noReturnPolicy": false,
      "vagueTesting": false,
      "specMismatchBetweenListingAndReply": false,
      "priceTooLowWithoutReason": false,
      "possibleBiosLockOrAssetTag": false,
      "internationalImportRisk": false
    },
    "followUpQuestionsForSeller": [],
    "overallRecommendation": {
      "rating": "safe | cautious | avoid",
      "shortReason": ""
    }
  },
  "rule": "If the seller does not explicitly confirm something, treat it as unknown, not safe.",
  "assumptions": "Treat 'works great' or 'tested' without evidence as vagueTesting = true."
}
```

---

## Product Recommendation Decision Rule

Recommend **only** when all of the following are true:

- Specs confirmed (model, CPU, GPU, RAM, storage, screen)
- At least one piece of testing proof exists (BIOS screenshot, SMART result, battery report)
- Risk flags are zero or low
- Price is plausible for market value
- Return policy is acceptable

---

## Auto-Draft Message Flow

1. Parse listing text
2. Detect missing proof (specs, testing, photos)
3. Draft shortest next seller message targeting missing items
4. Re-score after seller replies
5. Produce recommendation: safe / cautious / avoid
6. If safe: generate product recommendation summary

---

## Codebase Interfaces

Encode into the repo as:

- `searchSchema` — interface type
- `defaultSearchPack` — config constant
- `buildSearchQueries()` — helper that combines terms into marketplace-safe searches
- `sellerVerificationPromptTemplate` — message builder
- `evaluateSellerReplyPrompt` — evaluation prompt
- `recommendationEngine` — decision rule function
