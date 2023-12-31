JsOsaDAS1.001.00bplist00�Vscript_�iTerm = Application('iTerm2')
iTerm.includeStandardAdditions = true;

let win = iTerm.createWindowWithDefaultProfile();

const servicesList = [
  {
    serviceName : "api_gateway",
    launchOnStartup: true 
  },
  {
    serviceName : "catalog_service",
    launchOnStartup: true 
  },
  {
    serviceName : "communication_service",
    launchOnStartup: true 
  },
  {
    serviceName : "fulfillment_service",
    launchOnStartup: true 
  },
  {
    serviceName : "pos_service",
    launchOnStartup: true 
  },
  {
    serviceName : "recon_service",
    launchOnStartup: false 
  },
  {
    serviceName : "report_service",
    launchOnStartup: false 
  },
  {
    serviceName : "user_service",
    launchOnStartup: true 
  },
  {
    serviceName : "view_service",
    launchOnStartup: true 
  },
];
const autoStartServices = servicesList.filter(x => x.launchOnStartup);
const numberOfHorizantalSplits = Math.floor(autoStartServices.length / 3);
let sessionIndex = 0;
for ( let i = 0; i < numberOfHorizantalSplits; i++) {
  win.tabs[0].sessions[i].splitHorizontallyWithDefaultProfile();
}
let reducer = 3;
let reduceCount = 0;
do {
  for ( let i = reduceCount * reducer; i < numberOfHorizantalSplits + reduceCount * reducer; i++) {
    win.tabs[0].sessions[i].splitVerticallyWithDefaultProfile();
  }
  reduceCount++;
} while (reduceCount !== reducer);

for (let i = 0; i < autoStartServices.length; i++) {
  let service = autoStartServices[i];

  sendTabCommand(i, `cd proj/pinnium/services/${service.serviceName}`);
  sendTabCommand(i, "yarn start");
}

function sendTabCommand(sessionIndex, message){
  win.tabs[0].sessions[sessionIndex].write({ text: message });
}                              � jscr  ��ޭ