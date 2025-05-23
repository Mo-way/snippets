# `clock_gettime` behavior

- [godbolt example](https://godbolt.org/#g:!((g:!((g:!((h:codeEditor,i:(filename:'1',fontScale:14,fontUsePx:'0',j:1,lang:___c,selection:(endColumn:45,endLineNumber:20,positionColumn:45,positionLineNumber:20,selectionStartColumn:45,selectionStartLineNumber:20,startColumn:45,startLineNumber:20),source:'%23include+%3Cstdint.h%3E%0A%23include+%3Cstdio.h%3E%0A%23include+%3Ctime.h%3E%0A%0A%23define+NSEC+100000000%0A%0Auint64_t+getTimeLatencyNs()+%7B%0A++++struct+timespec+ts1%3B%0A++++struct+timespec+ts2%3B%0A++++clock_gettime(CLOCK_MONOTONIC_RAW,+%26ts1)%3B%0A++++clock_gettime(CLOCK_MONOTONIC_RAW,+%26ts2)%3B%0A++++return+((ts2.tv_sec+-+ts1.tv_sec)+*+NSEC+%2B+ts2.tv_nsec+-+ts1.tv_nsec)%3B%0A%7D%0A%0Aint+main(void)+%7B%0A++++int+runs+%3D+1000000%3B%0A++++uint64_t+sum+%3D+0%3B%0A++++uint64_t+max+%3D+0%3B%0A++++for+(int+i+%3D+0%3B+i+%3C+runs%3B+i%2B%2B)+%7B%0A++++++++uint64_t+delta+%3D+getTimeLatencyNs()%3B%0A++++++++sum+%2B%3D+delta%3B%0A++++++++if+(delta+%3E+max)+%7B%0A++++++++++++max+%3D+delta%3B%0A++++++++%7D%0A++++%7D%0A++++printf(%22%5Cn%5CnSum:+%25lu,+Avg:+%25lu,+Max:+%25lu%5Cn%22,+sum,+sum+/+runs,+max)%3B%0A++++return+0%3B%0A%7D'),l:'5',n:'0',o:'C+source+%231',t:'0')),header:(),k:59.87193169690501,l:'4',n:'0',o:'',s:0,t:'0'),(g:!((g:!((h:executor,i:(argsPanelShown:'1',compilationPanelShown:'0',compiler:armv8-cclang-trunk,compilerName:'',compilerOutShown:'0',execArgs:'',execStdin:'',fontScale:14,fontUsePx:'0',j:4,lang:___c,libs:!(),options:'',overrides:!(),runtimeTools:!(),source:1,stdinPanelShown:'1',wrap:'1'),l:'5',n:'0',o:'Executor+armv8-a+clang+(trunk)+(C,+Editor+%231)',t:'0')),k:61.299359658484526,l:'4',m:50,n:'0',o:'',s:0,t:'0'),(g:!((h:executor,i:(argsPanelShown:'1',compilationPanelShown:'0',compiler:cg151,compilerName:'',compilerOutShown:'0',execArgs:'',execStdin:'',fontScale:14,fontUsePx:'0',j:1,lang:___c,libs:!(),options:'',overrides:!(),runtimeTools:!(),source:1,stdinPanelShown:'1',tree:'1',wrap:'1'),l:'5',n:'0',o:'Executor+x86-64+gcc+15.1+(C,+Editor+%231)',t:'0')),header:(),l:'4',m:50,n:'0',o:'',s:0,t:'0')),k:40.12806830309499,l:'3',n:'0',o:'',t:'0')),l:'2',n:'0',o:'',t:'0')),version:4)


## how to gdb `clock_gettime()`

- *a
- `-g` for symbols in main.c
- but does neither add symbols in glibc, nor for the kernel

- => Do I need to recompile kernel?
- => glibc maybe apt install?
- jup install glibc6-dbg package
A


## tracing

Record all scheduling events:
`sudo trace-cmd record -e sched ./a.out`

Show  functiuon graph with call times:
`sudo trace-cmd record -p function_graph ./a.out`

Show involuntary context switches:
`trace-cmd report -w -F 'sched_switch, sched_wakeup.*' -i trace-1m-runs-8k-max.dat`

=> we see `a.out ==> somethin_else`, then ca. max latency later other ==> a.out
=> So most outliers from scheduling
=> chrt -f 99 gives less 100k outliers  but still 20-80k sometimes
=> how does it work on own cpu?
