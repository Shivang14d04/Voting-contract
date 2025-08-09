// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract Ballot{
    address public chairperson;
    constructor (string[] memory proposalNames){
        chairperson = msg.sender;
        voters[chairperson].weight =1;

        for(uint i = 0;i< proposalNames.length;i++){
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount:0 
            }));
        }


    }
    struct Proposal{
        string name;
        uint voteCount;

    }

    struct VoterInfo{
        bool isVoted;
        uint votedProposal;
        uint weight;
        address delegate;
    }
    Proposal[] public proposals ;

    mapping (address => VoterInfo) public voters;

    function giveRightToVote(address voter) public {
        require(msg.sender==chairperson ,"Only chairPerson can give voting rights");

        require(!voters[voter].isVoted, "the voter has already voted" );

        require(voters[voter].weight ==0 ,"voter already has the right to vote");
        voters[voter].weight = 1;

    }

    function vote(uint ProposalIndex) public{
        VoterInfo storage sender = voters[msg.sender];

        require(sender.weight >0 , "has no right to vote");
        require(!sender.isVoted , "sender has already  vote");

        sender.isVoted  = true;

        sender.votedProposal = ProposalIndex;
        proposals[ProposalIndex].voteCount += sender.weight;



    }

    function delegate(address to ) public{
        VoterInfo storage sender = voters[msg.sender];
        require(!voters[msg.sender].isVoted ,"you have already voted");
        require(to != msg.sender,"not allowed to delegate yourself");

        while(voters[to].delegate != address(0)){
            to = voters[to].delegate;

            require(to != msg.sender , "Found delegation loop");

        }
        sender.isVoted = true;
        sender.delegate = to;

        VoterInfo storage delegate_ = voters[to];

        if(delegate_.isVoted){
            proposals[delegate_.votedProposal].voteCount += sender.weight;
        }
        else{
            delegate_.weight += sender.weight;
        }

    }

    function FindWinner() public view returns(uint WinnerIndex){
        uint maxVoteCount = 0;
        for(uint i = 0;i< proposals.length;i++){
            if(proposals[i].voteCount > maxVoteCount){
                maxVoteCount = proposals[i].voteCount;
                WinnerIndex = i;
            }
        }
        return WinnerIndex;
    }
    function WinningProposal() public view returns(string  memory WinnerName){
        WinnerName = proposals[FindWinner()].name;
        return WinnerName;
    }

}