Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD6DC4320A
	for <rcu@archiver.kernel.org>; Wed,  1 Sep 2021 04:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E25DF60241
	for <rcu@archiver.kernel.org>; Wed,  1 Sep 2021 04:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhIAEJU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Sep 2021 00:09:20 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:37344 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhIAEJT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Sep 2021 00:09:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630469303; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=w4ZnWlbQyBqQPC2d63fDVjc/+3hn5i/lQ0ipwySTshA=; b=rH6I59yE63ChupbbBdS0wJje4qKqvzLO13YB9T99JXAYO4VY9Wcy61EqU9oLjuL/hEd0wfrd
 yBtGyi1AjHUht0X/WRiWx/0MRjRuNpnP6K9FQnUWBq9Kva6Z9CqbrRPTRqPHhY8yC2+hpBx0
 9Z1VcdGPESwBJKqyNh3qa0x6jlc=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyJkZDlkNSIsICJyY3VAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 612efca940d2129ac14a1c91 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 01 Sep 2021 04:08:09
 GMT
Sender: neeraju=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B8FB8C43460; Wed,  1 Sep 2021 04:08:09 +0000 (UTC)
Received: from [192.168.0.106] (unknown [103.199.158.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: neeraju)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 92D1DC4338F;
        Wed,  1 Sep 2021 04:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 92D1DC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Subject: Re: rcu_preempt detected stalls
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>,
        "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
List-Id: <soc.lore.kernel.org>
Cc:     paulmck@kernel.org, Josh Triplett <josh@joshtriplett.org>,
        rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        rcu <rcu@vger.kernel.org>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210831152144.GA28128@trex>
 <CAABZP2xGnSLVbgxqjKMq=Oj_H7rYfYjuCvmBpmZ4tRptGs3SEw@mail.gmail.com>
 <CAABZP2wUdToiAWOAgqDZrZtkuEdrXEv9GDgbioW3PZAyseOSgA@mail.gmail.com>
 <CAABZP2zg8c_gkm4+h4-mPCv_uDf5-iJFHEExCDFoES0jmBeuKw@mail.gmail.com>
From:   Neeraj Upadhyay <neeraju@codeaurora.org>
Message-ID: <2712e554-2058-d3c3-72ae-cca7562a2ec7@codeaurora.org>
Date:   Wed, 1 Sep 2021 09:38:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAABZP2zg8c_gkm4+h4-mPCv_uDf5-iJFHEExCDFoES0jmBeuKw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,

 >[   62.603086] rcu: rcu_preempt kthread starved for 5258 jiffies! 
g3017 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
 >[   62.613246] rcu:     Unless rcu_preempt kthread gets sufficient CPU 
time, OOM is now expected behavior.

These logs tells us, rcu_preempt thread is in RUNNING state, however, 
the thread is not scheduled for long. So, can you please check the
activity (scheduler traces, runqueue) on the CPU where rcu_preempt 
kthread is running (->cpu=1 in this case) , to see why rcu_preempt
is starved of CPU cycles?


Thanks
Neeraj

On 9/1/2021 6:33 AM, Zhouyi Zhou wrote:
> Hi,
> 
> I  perform following two new rounds of experiments:
> 
> 
> Test environment (x86_64 debian10 virtual machine: kvm -cpu host -smp
> 8 -hda ./debian10.qcow2 -m 4096 -net
> user,hostfwd=tcp::5556-:22,hostfwd=tcp::5555-:19 -net nic,model=e1000
> -vnc :30)
> 
> 1.   CONFIG_RCU_BOOST=y
> 1.1 as root, run #stress-ng --sequential 100  --class scheduler -t 5m --times
> 1.2 as regular user at the same time, run $stress-ng --sequential 100
> --class scheduler -t 5m --times
> 
> System begin OOM kill after 6 minutes:
> 31 19:41:12 debian kernel: [  847.171884] task:kworker/1:0     state:D
> stack:    0 pid: 1634 ppid:     2 flag\
> s:0x00004000
> Aug 31 19:41:12 debian kernel: [  847.171890] Workqueue: ipv6_addrconf
> addrconf_verify_work
> Aug 31 19:41:12 debian kernel: [  847.171897] Call Trace:
> Aug 31 19:41:12 debian kernel: [  847.171903]  __schedule+0x368/0xa40
> Aug 31 19:41:12 debian kernel: [  847.171915]  schedule+0x44/0xe0
> Aug 31 19:41:12 debian kernel: [  847.171921]
> schedule_preempt_disabled+0x14/0x20
> Aug 31 19:41:12 debian kernel: [  847.171924]  __mutex_lock+0x4b1/0xa10
> Aug 31 19:41:12 debian kernel: [  847.171935]  ? addrconf_verify_work+0xa/0x20
> Aug 31 19:41:12 debian kernel: [  847.171948]  ? addrconf_verify_work+0xa/0x20
> Aug 31 19:41:12 debian kernel: [  847.171951]  addrconf_verify_work+0xa/0x20
> Aug 31 19:41:12 debian kernel: [  847.171955]  process_one_work+0x1fa/0x5b0
> Aug 31 19:41:12 debian kernel: [  847.171967]  worker_thread+0x64/0x3d0
> Aug 31 19:41:12 debian kernel: [  847.171974]  ? process_one_work+0x5b0/0x5b0
> Aug 31 19:41:12 debian kernel: [  847.171978]  kthread+0x131/0x180
> Aug 31 19:41:12 debian kernel: [  847.171982]  ? set_kthread_struct+0x40/0x40
> Aug 31 19:41:12 debian kernel: [  847.171989]  ret_from_fork+0x1f/0x30
> Aug 31 19:41:12 debian kernel: [  847.176007]
> Aug 31 19:41:12 debian kernel: [  847.176007] Showing all locks held
> in the system:
> Aug 31 19:41:12 debian kernel: [  847.176016] 1 lock held by khungtaskd/56:
> Aug 31 19:41:12 debian kernel: [  847.176018]  #0: ffffffff82918b60
> (rcu_read_lock){....}-{1:2}, at: debug_show_a\
> ll_locks+0xe/0x1a0
> 
> 2.  # CONFIG_RCU_BOOST is not set
> 2.1 as root, run #stress-ng --sequential 100  --class scheduler -t 5m --times
> 2.2 as regular user at the same time, run $stress-ng --sequential 100
> --class scheduler -t 5m --times
> System begin OOM kill after 6 minutes:
> The system is so dead, that I can't save the backtrace to file nor did
> kernel has a chance to save the log to /var/log/messages
> 
> Thanks
> Zhouyi
> 
> On Wed, Sep 1, 2021 at 1:11 AM Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
>>
>> followings are some of my kernel config options:
>> CONFIG_PREEMPT=y
>> CONFIG_PREEMPT_COUNT=y
>> CONFIG_PREEMPTION=y
>> CONFIG_PREEMPT_DYNAMIC=y
>> CONFIG_PREEMPT_RCU=y
>> CONFIG_HAVE_PREEMPT_DYNAMIC=y
>> CONFIG_TREE_RCU=y
>> CONFIG_PREEMPT_RCU=y
>> CONFIG_RCU_EXPERT=y
>> CONFIG_SRCU=y
>> CONFIG_TREE_SRCU=y
>> CONFIG_TASKS_RCU_GENERIC=y
>> CONFIG_TASKS_RCU=y
>> CONFIG_TASKS_RUDE_RCU=y
>> CONFIG_TASKS_TRACE_RCU=y
>> CONFIG_RCU_STALL_COMMON=y
>> CONFIG_RCU_NEED_SEGCBLIST=y
>> CONFIG_RCU_FANOUT=64
>> CONFIG_RCU_FANOUT_LEAF=16
>> # CONFIG_RCU_FAST_NO_HZ is not set
>> # CONFIG_RCU_BOOST is not set
>> CONFIG_RCU_NOCB_CPU=y
>> # CONFIG_TASKS_TRACE_RCU_READ_MB is not set
>> # end of RCU Subsystem
>> CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
>> CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
>> # RCU Debugging
>> CONFIG_PROVE_RCU=y
>> # CONFIG_PROVE_RCU_LIST is not set
>> # CONFIG_RCU_SCALE_TEST is not set
>> CONFIG_RCU_TORTURE_TEST=m
>> # CONFIG_RCU_REF_SCALE_TEST is not set
>> CONFIG_RCU_CPU_STALL_TIMEOUT=21
>> # CONFIG_RCU_TRACE is not set
>> # CONFIG_RCU_EQS_DEBUG is not set
>>
>> Thanks
>> Zhouyi
>>
>> On Wed, Sep 1, 2021 at 1:01 AM Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
>>>
>>> I did an experiment just now on x86_64 virtual machines, rcu did not
>>> complain after 10 minutes's test, I hope my effort can provide some
>>> clue.
>>>
>>> 1. I clone the fresh new linux kernel (git clone
>>> https://kernel.source.codeaurora.cn/pub/scm/linux/kernel/git/torvalds/linux.git)
>>> 2. compile the kernel without CONFIG_RCU_BOOST (: # CONFIG_RCU_BOOST is not set)
>>> 3. boot the kernel on a x86_64 VM (kvm -cpu host -smp 16  -hda
>>> ./debian10.qcow2 -m 4096 -net
>>> user,hostfwd=tcp::5556-:22,hostfwd=tcp::5555-:19 -net nic,model=e1000
>>> -vnc :30)
>>> 4. run the test (stress-ng --sequential 16  --class scheduler -t 5m --times)
>>> 5. monitor the system by constantly typing top and dmesg
>>> 6. after 10 minutes, nothing else happens except that the dmesg report
>>> following two messages
>>> [  672.528192] sched: DL replenish lagged too much
>>> [  751.127790] hrtimer: interrupt took 12143 ns
>>>
>>> So, I guess CONFIG_RCU_BOOST is not necessary for x86_64 virtual machines
>>>
>>> Zhouyi
>>>
>>> On Tue, Aug 31, 2021 at 11:24 PM Jorge Ramirez-Ortiz, Foundries
>>> <jorge@foundries.io> wrote:
>>>>
>>>> Hi
>>>>
>>>> When enabling CONFIG_PREEMPT and running the stress-ng scheduler class
>>>> tests on arm64 (xilinx zynqmp and imx imx8mm SoCs) we are observing the following.
>>>>
>>>> [   62.578917] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>>>> [   62.585015]  (detected by 0, t=5253 jiffies, g=3017, q=2972)
>>>> [   62.590663] rcu: All QSes seen, last rcu_preempt kthread activity 5254 (4294907943-4294902689), jiffies_till_next_fqs=1, root
>>>> +->qsmask 0x0
>>>> [   62.603086] rcu: rcu_preempt kthread starved for 5258 jiffies! g3017 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
>>>> [   62.613246] rcu:     Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
>>>> [   62.622359] rcu: RCU grace-period kthread stack dump:
>>>> [   62.627395] task:rcu_preempt     state:R  running task     stack:    0 pid:   14 ppid:     2 flags:0x00000028
>>>> [   62.637308] Call trace:
>>>> [   62.639748]  __switch_to+0x11c/0x190
>>>> [   62.643319]  __schedule+0x3b8/0x8d8
>>>> [   62.646796]  schedule+0x4c/0x108
>>>> [   62.650018]  schedule_timeout+0x1ac/0x358
>>>> [   62.654021]  rcu_gp_kthread+0x6a8/0x12b8
>>>> [   62.657933]  kthread+0x14c/0x158
>>>> [   62.661153]  ret_from_fork+0x10/0x18
>>>> [   62.682919] BUG: scheduling while atomic: stress-ng-hrtim/831/0x00000002
>>>> [   62.689604] Preemption disabled at:
>>>> [   62.689614] [<ffffffc010059418>] irq_enter_rcu+0x30/0x58
>>>> [   62.698393] CPU: 0 PID: 831 Comm: stress-ng-hrtim Not tainted 5.10.42+ #5
>>>> [   62.706296] Hardware name: Zynqmp new (DT)
>>>> [   62.710115] Call trace:
>>>> [   62.712548]  dump_backtrace+0x0/0x240
>>>> [   62.716202]  show_stack+0x2c/0x38
>>>> [   62.719510]  dump_stack+0xcc/0x104
>>>> [   62.722904]  __schedule_bug+0x78/0xc8
>>>> [   62.726556]  __schedule+0x70c/0x8d8
>>>> [   62.730037]  schedule+0x4c/0x108
>>>> [   62.733259]  do_notify_resume+0x224/0x5d8
>>>> [   62.737259]  work_pending+0xc/0x2a4
>>>>
>>>> The error results in OOM eventually.
>>>>
>>>> RCU priority boosting does work around this issue but it seems to me
>>>> a workaround more than a fix (otherwise boosting would be enabled
>>>> by CONFIG_PREEMPT for arm64 I guess?).
>>>>
>>>> The question is: is this an arm64 bug that should be investigated? or
>>>> is this some known corner case of running stress-ng that is already
>>>> understood?
>>>>
>>>> thanks
>>>> Jorge
>>>>
>>>>
>>>>

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of the Code Aurora Forum, hosted by The Linux Foundation
