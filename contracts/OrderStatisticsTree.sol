pragma solidity ^0.5.0;

contract OrderStatisticTree {


    address owner;
    uint numberofInserts;
    uint EligibleCount;
    bool GoalReached;

    constructor(address _owner, uint _eligibleCount) public {
        owner=_owner;
        numberofInserts=0;
        EligibleCount=_eligibleCount;
        GoalReached=false;
    }
    function SetCoinOwnerEligible(uint value) public isOwner(){
      require(GoalReached==true);
      require(rank(value)<=EligibleCount);
     // if(!owner.call(bytes4(keccak256("setEligible(uint256)")),value )) revert();
    }
    function SetGoalReached() public isOwner(){
      GoalReached=true;
    }
    modifier isOwner(){
      require(msg.sender==owner);
      _;
    }
    function update_count(uint value) private {
        Node storage n=nodes[value];
        n.count=1+nodes[n.children[false]].count+nodes[n.children[true]].count+n.dupes;
    }
    function update_counts(uint value) private {
        uint parent=nodes[value].parent;
        while (parent!=0) {
            update_count(parent);
            parent=nodes[parent].parent;
        }
    }
    function update_height(uint value) private {
        Node storage n=nodes[value];
        uint height_left=nodes[n.children[false]].height;
        uint height_right=nodes[n.children[true]].height;
        if (height_left>height_right)
            n.height=height_left+1;
        else
            n.height=height_right+1;
    }
    function balance_factor(uint value) view private returns (int bf) {
        Node storage  n=nodes[value];
        return int(nodes[n.children[false]].height)-int(nodes[n.children[true]].height);
    }
    function rotate(uint value,bool dir) private {
        bool other_dir=!dir;
        Node  storage n=nodes[value];
        bool side=n.side;
        uint parent=n.parent;
        uint value_new=n.children[other_dir];
        Node  storage  n_new=nodes[value_new];
        uint orphan=n_new.children[dir];
        Node storage  p=nodes[parent];
        Node storage o=nodes[orphan];
        p.children[side]=value_new;
        n_new.side=side;
        n_new.parent=parent;
        n_new.children[dir]=value;
        n.parent=value_new;
        n.side=dir;
        n.children[other_dir]=orphan;
        o.parent=value;
        o.side=other_dir;
        update_height(value);
        update_height(value_new);
        update_count(value);
        update_count(value_new);
    }
    function rebalance_insert(uint n_value) private {
        update_height(n_value);
        Node memory n=nodes[n_value];
        uint p_value=n.parent;
        if (p_value!=0) {
            int p_bf=balance_factor(p_value);
            bool side=n.side;
            int sign;
            if (side)
                sign=-1;
            else
                sign=1;
            if (p_bf == sign*2) {
                if (balance_factor(n_value) == (-1 * sign))
                    rotate(n_value,side);
                rotate(p_value,!side);
            }
            else if (p_bf != 0)
                rebalance_insert(p_value);
        }
    }
    function rebalance_delete(uint p_value,bool side) private{
        if (p_value!=0) {
            update_height(p_value);
            int p_bf=balance_factor(p_value);
            //bool dir = side;
            int sign;
            if (side)
                sign=1;
            else
                sign=-1;
            int bf=balance_factor(p_value);
            if (bf==(2*sign)) {
                Node storage p=nodes[p_value];
                uint s_value=p.children[!side];
                int s_bf=balance_factor(s_value);
                if (s_bf == (-1 * sign))
                    rotate(s_value,!side);
                rotate(p_value,side);
                if (s_bf!=0){
                    p=nodes[p_value];
                    rebalance_delete(p.parent,p.side);
                }
            }
            else if (p_bf != sign){
                Node memory p=nodes[p_value];
                rebalance_delete(p.parent,p.side);
            }
        }
    }
    function fix_parents(uint parent,bool side) private {
        if(parent!=0) {
            update_count(parent);
            update_counts(parent);
            rebalance_delete(parent,side);
        }
    }
    function insert_helper(uint p_value,bool side,uint value) private {
        Node storage root=nodes[p_value];
        uint c_value=root.children[side];
        if (c_value==0){
            root.children[side]=value;
            Node storage child=nodes[value];
            child.parent=p_value;
            child.side=side;
            child.height=1;
            child.count=1;
            update_counts(value);
            rebalance_insert(value);
        }
        else if (c_value==value){
            nodes[c_value].dupes++;
            update_count(value);
            update_counts(value);
        }
        else{
            bool side_new=(value >= c_value);
            insert_helper(c_value,side_new,value);
        }
    }
    function insert(uint value) public isOwner() {

        if (value==0)
            nodes[value].dupes++;
        else{
            numberofInserts+=1;
            insert_helper(0,true,value);
        }
    }
    function rightmost_leaf(uint value) view private returns (uint leaf) {
        uint child=nodes[value].children[true];
        if (child!=0)
            return rightmost_leaf(child);
        else
            return value;
    }
    function zero_out(uint value) private {
        Node  storage n=nodes[value];
        n.parent=0;
        n.side=false;
        n.children[false]=0;
        n.children[true]=0;
        n.count=0;
        n.height=0;
        n.dupes=0;
    }
    function remove_branch(uint _value,uint _left) private {
        uint ipn=rightmost_leaf(_left);
        Node storage i=nodes[ipn];
        uint dupes=i.dupes;
        remove_helper(ipn);
        Node storage n=nodes[_value];
        uint parent=n.parent;
        Node  storage p=nodes[parent];
        uint height=n.height;
        bool side=n.side;
        uint count=n.count;
        uint right=n.children[true];
        uint left=n.children[false];
        p.children[side]=ipn;
        i.parent=parent;
        i.side=side;
        i.count=count+dupes-n.dupes;
        i.height=height;
        i.dupes=dupes;
        if (left!=0) {
            i.children[false]=left;
            nodes[left].parent=ipn;
        }
        if (right!=0) {
            i.children[true]=right;
            nodes[right].parent=ipn;
        }
        zero_out(_value);
        update_counts(ipn);
    }
    function remove_helper(uint value) private {
        Node storage  n=nodes[value];
        uint parent=n.parent;
        bool side=n.side;
        Node storage p=nodes[parent];
        uint left=n.children[false];
        uint right=n.children[true];
        if ((left == 0) && (right == 0)) {
            p.children[side]=0;
            zero_out(value);
            fix_parents(parent,side);
        }
        else if ((left !=0) && (right != 0)) {
            remove_branch(value,left);
        }
        else {
            uint child=left+right;
            Node storage c=nodes[child];
            p.children[side]=child;
            c.parent=parent;
            c.side=side;
            zero_out(value);
            fix_parents(parent,side);
        }
    }
    function remove(uint value) public isOwner(){
        Node storage n=nodes[value];
        if (value==0){
            if (n.dupes==0)
                return;
        }
        else{
            if (n.count==0)
                return;
        }
        if (n.dupes>0) {
            n.dupes--;
            if(value!=0)
                n.count--;
            fix_parents(n.parent,n.side);
        }
        else
            remove_helper(value);
    }

    function rank(uint value) view public returns (uint smaller){
        uint temp=0;
        if(value!=0){
            smaller=nodes[0].dupes;
            uint cur=nodes[0].children[true];
            Node storage cur_node=nodes[cur];
            while(temp<10){
                temp+=1;
                if (cur<=value){
                    if(cur<value)
                        smaller+=1+cur_node.dupes;
                    uint left_child=cur_node.children[false];
                    if (left_child!=0)
                        smaller+=nodes[left_child].count;
                }
                if (cur==value)
                    break;
                //cur=cur_node.children[cur<value];
                if(cur<value){
                    cur=cur_node.children[true];
                    cur_node=nodes[cur];

                }
                if(cur>value){
                    cur=cur_node.children[false];
                    cur_node=nodes[cur];
                }
            }
        }
    }

    function select_at(uint pos) view public returns (uint value){
        uint zeroes=nodes[0].dupes;
        uint left_count;
        if (pos<zeroes)
            return 0;
        else {
            uint pos_new=pos-zeroes;
            uint cur=nodes[0].children[true];
            Node storage cur_node=nodes[cur];
            while(true){
                uint left=cur_node.children[false];
                uint cur_num=cur_node.dupes+1;
                Node storage left_node=nodes[left];
                if (left!=0) {
                   
                    uint left_count=left_node.count;
                }
                
                if (pos_new<left_count) {
                    cur=left;
                    cur_node=left_node;
                }
                else if (pos_new<left_count+cur_num){
                    return cur;
                }
                else {
                    cur=cur_node.children[true];
                    cur_node=nodes[cur];
                    pos_new-=left_count+cur_num;
                }
            }
        }
    }

    function duplicates(uint value)  public view returns (uint n){
        return nodes[value].dupes+1;
    }

    function count()  public view returns (uint count){
        Node storage root=nodes[0];
        Node storage child=nodes[root.children[true]];
        return root.dupes+child.count;
    }

    function in_top_n(uint value,uint n) public view returns (bool truth){
        uint pos=rank(value);
        uint num=count();
        return (num-pos-1<n);
    }
    function percentile(uint value) public view returns (uint k){
        uint pos=rank(value);
        uint same=nodes[value].dupes;
        uint num=count();
        return (pos*100+(same*100+100)/2)/num;
    }
    function at_percentile(uint percentile) public view returns (uint value){
        uint n=count();
        return select_at(percentile*n/100);
    }
    function permille(uint value) public view  returns (uint k){
        uint pos=rank(value);
        uint same=nodes[value].dupes;
        uint num=count();
        return (pos*1000+(same*1000+1000)/2)/num;
    }
    function at_permille(uint permille) public view returns (uint value){
        uint n=count();
        return select_at(permille*n/1000);
    }
    function median() public view returns (uint value){
        return at_percentile(50);
    }
    function node_left_child(uint value) public view returns (uint child){
        child=nodes[value].children[false];
    }
    function node_right_child(uint value) public view returns (uint child){
        child=nodes[value].children[true];
    }
    function node_parent(uint value) public view returns (uint parent){
        parent=nodes[value].parent;
    }
    function node_side(uint value) public view returns (bool side){
        side=nodes[value].side;
    }
    function node_height(uint value) public view returns (uint height){
        height=nodes[value].height;
    }
    function node_count(uint value) public view returns (uint count){
        count=nodes[value].count;
    }
    function node_dupes(uint value) public view returns (uint dupes){
        dupes=nodes[value].dupes;
    }
    function numInserts() public view returns(uint){
        return numberofInserts;
    }
    struct Node {
        mapping (bool => uint) children;
        uint parent;
        bool side;
        uint height;
        uint count;
        uint dupes;
    }
    mapping(uint => Node) nodes;
}
