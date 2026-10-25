/// Made-up AAMVA driving licence data, in the layout found on the back of
/// US cards (dates are MMDDCCYY). No real person.
const String kSampleUsIdCard =
    '@\n\x1e\rANSI 636014090102DL00410278ZC03190024DLDAQD1234562\n'
    'DCSSAMPLE\n'
    'DDEN\n'
    'DACJANE\n'
    'DDFN\n'
    'DADQ\n'
    'DDGN\n'
    'DCAC\n'
    'DBD08312026\n'
    'DBB01311985\n'
    'DBA01312031\n'
    'DBC2\n'
    'DAG123 MAIN STREET\n'
    'DAISACRAMENTO\n'
    'DAJCA\n'
    'DAK958220000  \n'
    'DCGUSA\n'
    'ZCZCAY\n';

/// Made-up Canadian card (dates are CCYYMMDD) with an older `DCT` name field
/// and a missing middle name.
const String kSampleCanadaIdCard =
    '@\n\x1e\rANSI 636012080002DL00410200ZO02410040DLDAQ987654321\n'
    'DCSTREMBLAY\n'
    'DCTMARIE,LOUISE\n'
    'DBB19900215\n'
    'DBA20300215\n'
    'DAJON\n'
    'DCGCAN\n';
