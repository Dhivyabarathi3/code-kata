set val(chan) Channel/WirelessChannel 
set val(prop) Propagation/TwoRayGround 
set val(netif) Phy/WirelessPhy 
set val(mac) Mac/802_11 
set val(ifq) Queue/DropTail/PriQueue 
set val(ll) LL 
set val(ant) Antenna/OmniAntenna 
set val(ifqlen) 150 
set val(nn) 100 
set val(rp) AODV 
set val(x) 800 
set val(y) 500 
set val(stop) 150


#-------Event scheduler object creation--------#

set ns              [new Simulator]
#used to schedule the events that are running at the same time
$ns use-scheduler Heap

#Creating trace file and nam file
set tracefd       [open aodv1.tr w]
set namtrace      [open aodv1.nam w]   
$ns trace-all $tracefd
$ns namtrace-all-wireless $namtrace $val(x) $val(y)

# set up topography object
set topo       [new Topography]
$topo load_flatgrid $val(x) $val(y)
create-god $val(nn)

# configure the nodes
        $ns node-config -adhocRouting $val(rp) \
                   -llType $val(ll) \
                   -macType $val(mac) \
                   -ifqType $val(ifq) \
                   -ifqLen $val(ifqlen) \
                   -antType $val(ant) \
                   -propType $val(prop) \
                   -phyType $val(netif) \
                   -channelType $val(chan) \
                   -topoInstance $topo \
                   -agentTrace ON \
                   -routerTrace ON \
                   -macTrace OFF \
                   -movementTrace ON


# node creation

      for {set i 0} {$i < $val(nn) } { incr i } {
            set node_($i) [$ns node] 
$node_($i) color "black" 
$node_($i) label Node$i   
      }
#initial location of nodes

for {set i 0} {$i < $val(nn)} {incr i} {

$node_($i) set X_ [expr rand()*$val(x)]
$node_($i) set Y_ [expr rand()*$val(y)]
$node_($i) set Z_ 0

$node_($i) color "green"

}


for {set i 0} {$i < $val(nn)} {incr i} {

$ns at 0.1 "$node_($i) color darkviolet"
$ns at 0.1 "$node_($i) label Node$i"

}

#generation of movements

$ns at 2.0 "$node_(0) setdest 20.0 10.0 0.0"
$ns at 5.0 "$node_(24) setdest 60.0 50.0 50.0"
$ns at 7.0 "$node_(2) setdest 120.0 100.0 50.0"
$ns at 0.0 "$node_(17) setdest 140.0 150.0 50.0"
$ns at 0.0 "$node_(20) setdest 160.0 180.0 50.0"
$ns at 12.0 "$node_(19) setdest 130.0 230.0 6.0"
$ns at 23.0 "$node_(5) setdest 40.0 165.0 9.0"
$ns at 20.0 "$node_(7) setdest 50.0 180.0 13.0"
$ns at 3.0 "$node_(4) setdest 80.0 156.0 5.0"
$ns at 6.0 "$node_(10) setdest 56.0 200.0 10.0"
$ns at 13.0 "$node_(15) setdest 88.0 20.0 45.0"
$ns at 6.0 "$node_(3) setdest 177.0 120.0 45.0"
$ns at 23.0 "$node_(1) setdest 140.0 70.0 20.0"

# -------------------------------------- #	fp2	


#set fp2 [open "/root/Downloads/ns-allinone-2.29/ns-2.29/input.txt" r]
#set filed [read $fp2]
#puts $filed;
#set data [split $filed "\n"]
#puts $data;
#foreach line2 $data {
#set length2 [string length $line2]
#if {$length2 != 0} {
#lassign $line2 src dest
#puts $src
set tcp1 [new Agent/TCP/Newreno]
$tcp1 set class_ 2
set sink1 [new Agent/TCPSink]
$ns attach-agent $node_(7) $tcp1
$ns attach-agent $node_(8) $sink1
$ns connect $tcp1 $sink1
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ns at 3.0 "$node_(7) color brown"
$ns at 3.0 "$node_(8) color brown"
$ns at 3.0 "$ftp1 start"
#}
#}
#close $fp2


# --------------------------------------# 	fp1


#set fp1 [open "/root/Downloads/ns-allinone-2.29/ns-2.29/mali.txt" r]
#set file_data [read $fp1]
#set data1 [split $file_data "\n"]
#foreach line $data1  {
#set length1 [string length $line]
#if {$length1 !=0} {
#set id $line
$ns at 3.2 "[$node_(5) set ragent_] hacker"

for {set i 0} {$i < $val(nn)} { incr i } {
$ns initial_node_pos $node_($i) 10
}

$ns at 3.2 "$node_(5) color red"
$ns at 3.2 "$node_(5) label malicious"
#}
#}
#close $fp1

# Define node initial position in nam
for {set i 0} {$i < $val(nn)} { incr i } {
# 20 defines the node size for nam
$ns initial_node_pos $node_($i) 20
}

# Telling nodes when the simulation ends
for {set i 0} {$i < $val(nn) } { incr i } {
    $ns at $val(stop) "$node_($i) reset";
}
# ending nam and the simulation
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "stop"
#$ns at 149.01 "puts \"end simulation\" ; $ns halt"
proc stop {} {
    global ns tracefd namtrace
    $ns flush-trace
    close $tracefd
    close $namtrace
exec nam aodv.nam &
exit 0
}

#$ns at 150.01 "puts \"end simulation\" ; $ns halt"

$ns run
