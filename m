Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8001EC433F5
	for <rcu@archiver.kernel.org>; Wed, 10 Nov 2021 04:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5447B6103A
	for <rcu@archiver.kernel.org>; Wed, 10 Nov 2021 04:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhKJEnW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 9 Nov 2021 23:43:22 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:15425 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230357AbhKJEnV (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 9 Nov 2021 23:43:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1636519235; x=1668055235;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ZsH6MhhbqNu57vYniPHkgklgigBcIxZ7QmJ8tNlyAIs=;
  b=HhRAvOZIChv5+IGeJyW0OpSg65KEvPEHmSdwj8oWn9t7a6Uf39/cW9MW
   UuXITnBZwwr7okLxNEd96vrWMx47swHF4B0u+ovMKXEeWrDbirTWlFX8X
   XpSfpDipj3VMMf/DaJYbuIDxKnvhm9P88FlIFTfltICssCxPxWVZ8rWFw
   w=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Nov 2021 20:40:34 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 20:40:34 -0800
Received: from [10.216.57.197] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7; Tue, 9 Nov 2021
 20:40:30 -0800
Subject: Re: [PATCH] rcu-tasks: Inspect stalled task's trc state in locked
 state
To:     <paulmck@kernel.org>
CC:     <josh@joshtriplett.org>, <rostedt@goodmis.org>,
        <mathieu.desnoyers@efficios.com>, <jiangshanlai@gmail.com>,
        <joel@joelfernandes.org>, <rcu@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <urezki@gmail.com>,
        <frederic@kernel.org>, <boqun.feng@gmail.com>
References: <20211109112214.19618-1-quic_neeraju@quicinc.com>
 <20211109145235.GV641268@paulmck-ThinkPad-P17-Gen-1>
From:   quic_neeraju <quic_neeraju@quicinc.com>
Message-ID: <d099f078-eef7-1c44-7086-b67971218f3f@quicinc.com>
Date:   Wed, 10 Nov 2021 10:10:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211109145235.GV641268@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul,


On 11/9/2021 8:22 PM, Paul E. McKenney wrote:
> On Tue, Nov 09, 2021 at 04:52:14PM +0530, Neeraj Upadhyay wrote:
>> On RCU tasks trace stall, inspect the RCU-tasks-trace specific
>> states of stalled task in locked down state, using try_invoke_
>> on_locked_down_task(), to get reliable trc state of a non-running
>> stalled task.
>>
>> Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> 
> Queued for further review and testing, thank you!
> 
> Along those lines, what did you do to test this?  I would like to
> add that to the commit message.  (The usual approach is to use the
> rcutorture.stall_cpu module parameter, in case I have not yet passed
> that along.)
> 

Before sending the patch, I had tested with TRACE01 and adding long 
delay before rcu_read_unlock_trace() in tasks_tracing_torture_read_unlock()

static void tasks_tracing_torture_read_unlock(int idx)
{
         rcu_read_unlock_trace();
}

I retested with below commandline (without adding delay in 
tasks_tracing_torture_read_unlock()):

tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 8 --configs TRACE01 
--bootargs "rcutorture.torture_type=tasks-tracing 
rcutorture.stall_cpu=10 rcutorture.stall_cpu_block=1 
rcupdate.rcu_task_stall_timeout=100" --trust-make

With this, I can see stalls for both RUNNING and WAITING state task:

[   21.520291] INFO: rcu_tasks_trace detected stalls on tasks:
[   21.521292] P85: ... nesting: 1N cpu: 2
[   21.521966] task:rcu_torture_sta state:D stack:15080 pid:   85 ppid: 
     2 flags:0x00004000
[   21.523384] Call Trace:
[   21.523808]  __schedule+0x273/0x6e0
[   21.524428]  schedule+0x35/0xa0
[   21.524971]  schedule_timeout+0x1ed/0x270
[   21.525690]  ? del_timer_sync+0x30/0x30
[   21.526371]  ? rcu_torture_writer+0x720/0x720
[   21.527106]  rcu_torture_stall+0x24a/0x270
[   21.527816]  kthread+0x115/0x140
[   21.528401]  ? set_kthread_struct+0x40/0x40
[   21.529136]  ret_from_fork+0x22/0x30
[   21.529766]  1 holdouts
[   21.632300] INFO: rcu_tasks_trace detected stalls on tasks:
[   21.632345] rcu_torture_stall end.
[   21.633293] P85: .
[   21.633294] task:rcu_torture_sta state:R  running task 
stack:15080 pid:   85 ppid:     2 flags:0x00004000
[   21.633299] Call Trace:
[   21.633301]  ? vprintk_emit+0xab/0x180
[   21.633306]  ? vprintk_emit+0x11a/0x180
[   21.633308]  ? _printk+0x4d/0x69
[   21.633311]  ? __default_send_IPI_shortcut+0x1f/0x40



Thanks
Neeraj

> 							Thanx, Paul
> 
>> ---
>>   kernel/rcu/tasks.h | 43 ++++++++++++++++++++++++++++++++++---------
>>   1 file changed, 34 insertions(+), 9 deletions(-)
>>
>> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
>> index e4a32db9f712..4e49b847971b 100644
>> --- a/kernel/rcu/tasks.h
>> +++ b/kernel/rcu/tasks.h
>> @@ -1073,25 +1073,50 @@ static void rcu_tasks_trace_postscan(struct list_head *hop)
>>   	// Any tasks that exit after this point will set ->trc_reader_checked.
>>   }
>>   
>> +/* Communicate task state back to the RCU tasks trace stall warning request. */
>> +struct trc_stall_chk_rdr {
>> +	int nesting;
>> +	int ipi_to_cpu;
>> +	u8 needqs;
>> +};
>> +
>> +static bool trc_check_slow_task(struct task_struct *t, void *arg)
>> +{
>> +	struct trc_stall_chk_rdr *trc_rdrp = arg;
>> +
>> +	if (task_curr(t))
>> +		return false; // It is running, so decline to inspect it.
>> +	trc_rdrp->nesting = READ_ONCE(t->trc_reader_nesting);
>> +	trc_rdrp->ipi_to_cpu = READ_ONCE(t->trc_ipi_to_cpu);
>> +	trc_rdrp->needqs = READ_ONCE(t->trc_reader_special.b.need_qs);
>> +	return true;
>> +}
>> +
>>   /* Show the state of a task stalling the current RCU tasks trace GP. */
>>   static void show_stalled_task_trace(struct task_struct *t, bool *firstreport)
>>   {
>>   	int cpu;
>> +	struct trc_stall_chk_rdr trc_rdr;
>> +	bool is_idle_tsk = is_idle_task(t);
>>   
>>   	if (*firstreport) {
>>   		pr_err("INFO: rcu_tasks_trace detected stalls on tasks:\n");
>>   		*firstreport = false;
>>   	}
>> -	// FIXME: This should attempt to use try_invoke_on_nonrunning_task().
>>   	cpu = task_cpu(t);
>> -	pr_alert("P%d: %c%c%c nesting: %d%c cpu: %d\n",
>> -		 t->pid,
>> -		 ".I"[READ_ONCE(t->trc_ipi_to_cpu) >= 0],
>> -		 ".i"[is_idle_task(t)],
>> -		 ".N"[cpu >= 0 && tick_nohz_full_cpu(cpu)],
>> -		 READ_ONCE(t->trc_reader_nesting),
>> -		 " N"[!!READ_ONCE(t->trc_reader_special.b.need_qs)],
>> -		 cpu);
>> +	if (!try_invoke_on_locked_down_task(t, trc_check_slow_task, &trc_rdr))
>> +		pr_alert("P%d: %c\n",
>> +			 t->pid,
>> +			 ".i"[is_idle_tsk]);
>> +	else
>> +		pr_alert("P%d: %c%c%c nesting: %d%c cpu: %d\n",
>> +			 t->pid,
>> +			 ".I"[trc_rdr.ipi_to_cpu >= 0],
>> +			 ".i"[is_idle_tsk],
>> +			 ".N"[cpu >= 0 && tick_nohz_full_cpu(cpu)],
>> +			 trc_rdr.nesting,
>> +			 " N"[!!trc_rdr.needqs],
>> +			 cpu);
>>   	sched_show_task(t);
>>   }
>>   
>> -- 
>> 2.17.1
>>
