### [dapp-deploy](https://github.com/warren-bank/dapp-deploy)

#### Description:

Command-line tool to:
* deploy Ethereum contracts to a blockchain
* for each contract,<br>
  associate Ethereum network IDs to a list of addresses,<br>
  where each address represents a deployment of the contract onto that blockchain,<br>
  and store this metadata as a hashtable in a (small) JSON file

#### Installation:

```bash
npm install -g @warren-bank/dapp-deploy
```

*aside:*
* Before installation, you first might want to check whether your `$PATH` contains any conflicting symbolic links: `which dapp-deploy`
* At present, the [`dapphub/dapp`](https://github.com/dapphub/dapp) toolchain doesn't include a `deploy` library; But that may change in the future.

#### Simple Example:

```bash
lxterminal -e testrpc

mkdir ~/my_dapp
cd ~/my_dapp

dapp init
dapp deploy
```

#### Options:

```text
$ dapp-deploy --help

 Tool to use in combination with 'dapphub/dapp'.
 Uses artifacts generated by "dapp build".
 Deploys compiled contract(s) to an Ethereum blockchain.

 Each deployed contract address is saved to a JSON data file.
 Format is a hash table:
     Ethereum network ID => array of addresses

 Ethereum network ID represents a unique Ethereum blockchain.
 Enables deployment to multiple chains.

 A frontend Dapp can determine the current Ethereum network ID.
 For each contract, the Dapp can perform the necessary lookup
 in the corresponding hash table of deployment addresses.
 Using web3.js, only 2 data files are needed per contract:
     ./out/CONTRACTNAME.abi
     ./out/CONTRACTNAME.deployed

 Usage: dapp-deploy [options]


Options:
  --all                                Deploy all contracts  [boolean] [default: true]
  -c, --contract, --whitelist          Deploy specified contract(s)  [array]
  -x, --exclude_contract, --blacklist  Do not deploy specified contract(s)  [array]
  -l, --lib, --library                 Link specified library(s) to dependent deployment contract(s)
                                       note: The specified libary(s) won't be redeployed.
                                       note: Addresses for previously deployed libaries can be specified in two formats: "LIBRARYNAME=0x12345" and "{{LIBRARYNAME, /optional/filepath}}". The latter format references stored .deployed metadata.  [array]
  --params                             Parameter(s) to pass to contract constructor(s)
                                       note: Addresses for previously deployed contracts (with stored .deployed metadata) can be referenced by passing a string parameter having the format: "{{CONTRACTNAME, /optional/filepath}}"
                                       note: Arrays can be encoded into JSON. Arrays may contain strings that reference the address of a previously deployed contract.
                                       note: In most situations, each contract having a constructor that accepts input parameters should be deployed individually, rather than in a batch. Please be careful.  [array] [default: []]
  --value, --wei                       Value (wei) to pass to contract constructor(s)
                                       note: In most situations, each contract having a payable constructor should be deployed individually, rather than in a batch. Please be careful.  [number] [default: 0]
  --gas                                Gas to send with each transaction
                                       note: In most situations, it would be better to not use this option. By default, the amount of gas sent is an estimate.  [number]
  -h, --host                           Ethereum JSON-RPC server hostname  [string] [default: "localhost"]
  -p, --port                           Ethereum JSON-RPC server port number  [number] [default: 8545]
  --tls, --https, --ssl                Require TLS handshake (https:) to connect to Ethereum JSON-RPC server  [boolean] [default: false]
  -a, --aa, --account_address          Address of Ethereum account to own deployed contracts  [string]
  -A, --ai, --account_index            Index of Ethereum account to own deployed contracts.
                                       note: List of available/unlocked accounts is determined by Ethereum client.  [number] [default: 0]
  -i, --input_directory                Path to input directory. All compiled contract artifacts are read from this directory.
                                       note: The default path assumes that the current directory is the root of a compiled "dapp" project.  [string] [default: "./out"]
  -o, --od, --output_directory         Path to output directory. All "CONTRACTNAME.deployed" JSON files will be written to this directory.  [string] [default: "./out"]
  -O, --op, --output_pattern           Pattern to specify absolute output file path. The substitution pattern "{{contract}}" will be interpolated.
                                       note: The substitution pattern is required.  [string]
  -v, --verbose                        Configure how much information is logged to the console during the deployment of contracts.  [count]
  -q, --quiet                          Disable log messages. Output is restricted to the address(es) of newly deployed contracts. If a single contract is specified, returns a string. Otherwise, returns a hash (name => address) in JSON format. This data can be piped to other applications.  [boolean] [default: false]
  --help                               Show help  [boolean]

Examples:
  dapp-deploy                                                                                                                        deploy all contracts via: "http://localhost:8545" using account index #0
  dapp-deploy -A 1                                                                                                                   deploy all contracts via: "http://localhost:8545" using account index #1
  dapp-deploy -h "mainnet.infura.io" -p 443 --ssl -a "0xB9903E9360E4534C737b33F8a6Fef667D5405A40"                                    deploy all contracts via: "https://mainnet.infura.io:443" using account address "0xB9903E9360E4534C737b33F8a6Fef667D5405A40"
  dapp-deploy -c Foo                                                                                                                 deploy contract: "Foo"
  dapp-deploy -x Foo                                                                                                                 deploy all contracts except: "Foo"
  dapp-deploy -c Foo --params bar baz 123 --value 100                                                                                deploy contract: "Foo"
                                                                                                                                     call: "Foo('bar', 'baz', 123)"
                                                                                                                                     pay to contract: "100 wei"
  dapp-deploy -c Foo --params '["a","b","c"]'                                                                                        deploy contract: "Foo"
                                                                                                                                     call: "Foo(['a', 'b', 'c'])"
  dapp-deploy -c Foo --params '[1,2,3]'                                                                                              deploy contract: "Foo"
                                                                                                                                     call: "Foo([1, 2, 3])"
  dapp-deploy -c Foo --params '{{Bar}}' '{{Baz}}' '["{{Bar}}","{{Baz}}"]'                                                            deploy contract: "Foo"
                                                                                                                                     call: "Foo('0x123', '0x456', ['0x123', '0x456'])"
                                                                                                                                     where:
                                                                                                                                       - contract "Bar" is deployed to address "0x123" with metadata at: "./out/Bar.deployed"
                                                                                                                                       - contract "Baz" is deployed to address "0x456" with metadata at: "./out/Baz.deployed"
  dapp-deploy -c Foo --lib 'Bar=0x12345' 'Baz=0x98765'                                                                               deploy contract: "Foo"
                                                                                                                                     link to libraries: "Bar" at address: "0x12345", "Baz" at address: "0x98765"
  dapp-deploy -c Foo --lib '{{Lib1}}' '{{Lib2,./out/}}' '{{Lib3,./out/Lib3.deployed}}'                                               equivalent ways to reference metadata stored in the default '--output_directory'
  dapp-deploy -c Foo --lib "{{Lib4, $HOME/ethereum/libs/v1.0.0/}}" '{{Lib5, /home/warren/ethereum/libs/v1.0.1/Lib5.deployed.json}}'  versioning of libraries, referencing absolute paths, using custom filenames
  dapp-deploy -c Foo Bar Baz                                                                                                         deploy contracts: ["Foo","Bar","Baz"]
  dapp-deploy -c Foo -o "$HOME/Dapp_frontend/contracts"                                                                              generate: "~/Dapp_frontend/contracts/Foo.deployed"
  dapp-deploy -c Foo -O "$HOME/Dapp_frontend/contracts/{{contract}}.deployed.json"                                                   generate: "~/Dapp_frontend/contracts/Foo.deployed.json"
  dapp-deploy -c Foo -i "$HOME/Dapp_contracts/out" -O "./contracts/{{contract}}.deployed.json"                                       deploy contract: "~/Dapp_contracts/out/Foo.bin"
                                                                                                                                     and generate: "./contracts/Foo.deployed.json"

copyright: Warren Bank <github.com/warren-bank>
license: GPLv2
```

#### Notes:

* This tool is standalone.
* It is intended to complement the [`dapphub/dapp`](https://github.com/dapphub/dapp) toolchain,<br>
  but it can also work directly with Solidity compiler (solc) output.
* When `dapp` is installed, this tool can be invoked by the command: `dapp deploy [options]`
* When used standalone, it can be invoked by the command: `dapp-deploy [options]`

#### Methodology:

* find all .bin and .abi files in "input directory"
* filter contracts that don't have both artifacts
* if whitelist: filter contracts that aren't in whitelist
* if blacklist: filter contracts that are in blacklist
* if libraries: filter contracts (ie: compiled libraries) that have a static address to which dependent contracts will be linked
* for each remaining contract, perform in parallel (first pass):
  * read code
  * determine dependent libraries (if any)
  * determine whether the deployed address of any dependent libraries is (as of yet) unknown
  * if so: save metadata and stop processing contract
  * otherwise: deploy contract, save address, write output file (.deployed)
* if first pass completes and there is saved metadata for unlinked contracts:
  * iterate through all unlinked contracts and attempt to redeploy
  * when iteration completes:
    * if the number of unlinked contracts is zero: success
    * if the number of unlinked contracts has decreased: recursively perform the iteration again
    * otherwise: failure => there are contract dependencies on libraries for which no address is available to link

#### How to format options that reference deployment metadata

* '--lib' and '--params' can accept addresses for previously deployed libraries and contracts (respectively)
* the values given to both options are parsed to optionally allow each address to be specified by a reference to a stored .deployed metadata file
  * '--lib' can accept the format: "{{LIBRARYNAME, /optional/filepath}}"
  * '--params' can accept the format: "{{CONTRACTNAME, /optional/filepath}}"
* both formats are equivalent
  * `LIBRARYNAME` and `CONTRACTNAME` are required (ex: "{{Foo}}")
  * the optional file path is used to determine where to look for the particular .deployed metadata file
    * if no file path is specified:
      * if '--output_pattern'
        * file path is obtained by interpolating '{{contract}}' in '--output_pattern'
      * otherwise
        * filename is assumed to be: "CONTRACTNAME.deployed"
        * path to directory containing filename is assumed to be: '--output_directory'
    * otherwise, the file path can specify either:
      * path to .deployed metadata file
        * absolute path
        * path relative to the current working directory
      * path to directory containing .deployed metadata file
        * absolute or relative
        * path must terminate with a directory separator token (ie: `/` on POSIX, `\` on Windows)
        * filename is assumed to be: "CONTRACTNAME.deployed"
      * filename for .deployed metadata file
        * path to directory containing filename is assumed to be: '--output_directory'

#### Commentary:

* I'm fairly new to the Ethereum ecosystem.
* I've inspected various tools that assist with the development and testing of Solidity contracts
  * [Truffle](https://github.com/trufflesuite/truffle)
  * [Dapple](https://github.com/dapphub/dapple)
  * [Dapp](https://github.com/dapphub/dapp)
* I prefer `dapp` for the ability of its testing harness to debug deeply nested throws
* After a Solidity contract (or system of contracts) is ready for a front-end UI
  * the contracts need to be deployed to an Ethereum blockchain
    * most likely, this blockchain is a short-lived instance of `testrpc`;<br>
      in which case, redeployment is necessary each time the RPC server is restarted.
  * the addresses of these deployed contracts need to be saved,<br>
    and made available to the Dapp while it is being developed and tested.
* I've found the existing tools to be somewhat lacking for this purpose.<br>
  It's very possible that I'm mistaken and have re-invented the wheel.
  * `dapp` provides [`seth`](https://github.com/dapphub/seth) as its command-line tool to perform RPC calls.<br>
    It has many more features than this tool, but I find it lacking (and difficult to use) in a lot of ways.<br>
    Hopefully, it will continue to improve over time.
  * `dapple` provides [`DappleScript`](http://dapple.readthedocs.io/en/master/dapplescript/) as its Solidity-like language in which to write "migrations".<br>
    These migration scripts can be run on the command-line.<br>
    My impression is that it's a really nice system.<br>
    My only issue is that the scripting environment is very limiting.
    * can't work with complex data types
    * can't parse (or stringify) JSON data
    * can't write to the file system
  * `truffle` provides [`migrations`](http://truffleframework.com/docs/getting_started/migrations).<br>
    I haven't spent much time looking at this.<br>
    Initial impressions:
    * Pros:
      * scripting is done in a nodeJS javascript environment
      * can use a chain of promises to inspect the "instance" of each deployed contract
      * supports linking (which is something I may need to add)
    * Cons:
      * "Truffle requires you to have a Migrations contract in order to use the Migrations feature."
      * Personally, I don't plan to use Truffle to either test Solidity contracts or write front-end Dapps.<br>
        Though it could be used solely for generating deployment metadata,<br>
        which could then be consumed elsewhere,<br>
        I don't think that makes for a pleasant (or efficient) workflow.

#### Legal:

* copyright: [Warren Bank](https://github.com/warren-bank)
* license: [GPLv2](https://www.gnu.org/licenses/old-licenses/gpl-2.0.txt)
