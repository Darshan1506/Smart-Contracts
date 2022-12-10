<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title></title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="">
    </head>
    <body>
       <h1>This is my first dapp</h1>
       <p>Here we gonna set mood</p>
       <label for="mood">Input</label>
       <input type="text" id="mood"/>
       <div>
        <button onclick="getMood()">Get Mood</button>
       </div>
       <div>
        <button onclick="setMood()">Set Mood</button>
       </div>
        
    </body>
    <script
        src="https://cdn.ethers.io/lib/ethers-5.2.umd.min.js"
        type="application/javascript"
    ></script>
    <script>
        window.ethereum.enable();
        var provider = new ethers.providers.Web3Provider(
            web3.currentProvider,      // your wallet window.etheem will check whether a wallet is ttheir and then it will connext
            "goerli"
        );
        var MoodContractAddress = "0xd196418dCAd7CB1C1fEa71Cb4AeC30BF3A822162";  // remix contract address
        var MoodContractABI=[
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_mood",
				"type": "string"
			}
		],
		"name": "setMood",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getMood",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
];
        var MoodContract;
        var signer;

        provider.listAccounts().then(function(accounts){
            signer = provider.getSigner(accounts[0]);
            MoodContract = new ethers.Contract(
                MoodContractAddress,
                MoodContractABI,
                signer
            );
        });
        async function getMood(){
            getMoodPromise = MoodContract.getMood();
            var Mood = await getMoodPromise;
            console.log(Mood);
        }

        async function setMood(){
            let mood = document.getElementById("mood").value;
            setMoodPromise = MoodContract.setMood(mood);
            await setMoodPromise;
        }
    </script>
</html>