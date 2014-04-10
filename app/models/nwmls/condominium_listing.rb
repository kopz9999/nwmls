class Nwmls::CondominiumListing < Nwmls::Listing

  CODES = HashWithIndifferentAccess.new(
    LN: 'Listing Number',
    PTYP: 'Property Type',
    LAG: 'Listing Agent Number',
    ST: 'Status',
    LP: 'Listing Price',
    LPH: 'Listing Price History',
    SP: 'Selling Price',
    OLP: 'Original Price',
    HSN: 'House Number',
    DRP: 'Directional Prefix',
    STR: 'Street',
    SSUF: 'Street Suffix',
    DRS: 'Directional Suffix',
    UNT: 'Unit',
    CIT: 'City',
    STA: 'State',
    ZIP: 'Zip Code',
    PL4: 'Zip Plus 4',
    BR: 'Bedrooms',
    BTH: 'Bathrooms',
    ASF: 'Approximate Square Footage',
    LSF: 'Lot Square Footage',
    UD: 'Update Date',
    AR: 'Area',
    DSRNUM: 'Community Number',
    LDR: 'List Date Received',
    LD: 'List Date',
    CLO: 'Selling Date',
    YBT: 'Year Built',
    LO: 'Listing Office Number',
    TAX: 'Parcel Number',
    MAP: 'Map Page',
    GRDX: 'X Coordinate',
    GRDY: 'Y Coordinate',
    SAG: 'Selling Agent Number',
    SO: 'Selling Office Number',
    NIA: 'Publish To Internet',
    MR: 'Marketing Remarks',
    LONG: 'Longitude',
    LAT: 'Latitude',
    PDR: 'Pending Date',
    CLA: 'Co-Listing Agent Number',
    SHOADR: 'Show Address to Public',
    DD: 'Directions',
    AVDT: 'Available Date',
    INDT: 'Inactive Date',
    COU: 'County',
    CDOM: 'Cumulative Days on Market',
    CTDT: 'Contingent Date',
    DOM: 'Days on Market',
    SCA: 'Selling Co Agent Number',
    SCO: 'Selling Co Office Number',
    VIRT: 'Virtual Tour URL',
    SD: 'School District Code',
    SDT: 'Status Date',
    FIN: 'Financing',
    MAPBOOK: 'Map Book',
    DSR: 'Community Name',
    QBT: 'Quarter Bathrooms',
    SFS: 'Square Footage Source',
    LSZS: 'Lot Size Source',
    COLO: 'Co Office Number',
    PIC: 'Picture Count',
    HSNA: 'Street Number Modifier',
    AFH: 'FHA/VA Approved',
    ASC: 'Association Contact',
    BDL: 'Bedrooms Lower',
    BDM: 'Bedrooms Main',
    BDU: 'Bedrooms Upper',
    BRM: 'Bonus Room Location',
    BUS: 'Bus Line Nearby',
    COO: 'Co-op Yes or No',
    DNO: 'Den or Office Location',
    DRM: 'Dining Room Location',
    EL: 'Elementary School',
    ENT: 'Entry Location',
    F17: 'Form 17',
    FAM: 'Family Room Location',
    FBL: 'Full Baths Lower',
    FBM: 'Full Baths Main',
    FBT: 'Full Bathrooms',
    FBU: 'Full Baths Upper',
    FP: 'Fireplaces Total',
    FPL: 'Fireplaces Lower',
    FPM: 'Fireplaces Main',
    FPU: 'Fireplaces Upper',
    HBL: 'Half Baths Lower',
    HBM: 'Half Baths Main',
    HBT: 'Half Bathrooms',
    HBU: 'Half Baths Upper',
    HOD: 'Annual Association Dues',
    JH: 'Junior High',
    KES: 'Kitchen with Eating Space Location',
    KIT: 'Kitchen Location',
    LRM: 'Living Room Location',
    LSD: 'Leased Equipment',
    MBD: 'Master Bedroom Location',
    MGR: 'Manager Contact Information',
    MOR: 'Monthly Rent if Rented',
    NAS: 'Number of Assigned Spaces',
    NC: 'New Construction',
    NOC: 'Number of Units in Complex',
    NOS: 'Number of Stories in Building',
    NOU: 'Number of Units',
    OOC: 'Owner Occupancy Percentage',
    PKS: 'Parking Space Number',
    PRJ: 'Project',
    PTO: 'Preliminary Title Ordered',
    TQBT: 'Three Quarter Bathrooms',
    REM: 'Remodeled',
    SAA: 'Special Assessment Amount',
    SH: 'Senior High',
    SML: 'Show Map Link to Public',
    SNR: 'Senior Exemption',
    SPA: 'Special Assessment ',
    STG: 'Storage Number',
    STL: 'Storage Location',
    STY: 'Style',
    TBL: 'Three Quarter Baths Lower',
    TBM: 'Three Quarter Baths Main',
    TBU: 'Three Quarter Baths Upper',
    TOF: 'Type of Fireplace',
    TX: 'Tax Amount',
    TXY: 'Tax Year',
    UFN: 'Unit Floor Number',
    UTR: 'Utility Room Location',
    WDW: 'Window Covering',
    WHT: 'Water Heater Location',
    APH: 'Appliance Hookups',
    APS: 'Appliances that Stay',
    CMN: 'Common Features',
    CTD: 'Cats and Dogs',
    ENS: 'Energy Source',
    EXT: 'Exterior',
    FLS: 'Floor Covering',
    HOI: 'Home Owner Dues Include',
    HTC: 'Heating and Cooling',
    LDE: 'Lot Details',
    PKG: 'Parking Types',
    POS: 'Possession',
    RF: 'Roof',
    TRM: 'Potential Terms',
    UNF: 'Unit Features',
    VEW: 'View',
    WFT: 'Waterfront',
    ARC: 'Architecture',
    BUSR: 'Bus Route Number',
    ECRT: 'Environmental Cert',
    STRS: 'Number of Access Stairs',
    PARQ: 'Third Party Approval Required',
    BREO: 'Bank Owned',
    AllowAVM: 'Allow AVM',
    ProhibitBLOG: 'Allow Blog',
  )

  acts_as_nwmls_listing :property_type => 'COND', :attribute_mappings => CODES
end
