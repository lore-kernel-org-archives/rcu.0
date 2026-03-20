Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BA229346F;
	Fri, 20 Mar 2026 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774032597; cv=none; b=HSvHgdD7N5q0u0tW2F+jRdJzLwBkOZh/ItsA+4jPF8qJflGv8JoX/KyMncuqSABYCIEvJZuLOVEcqmCncgHRCt8mr0avBlVFan7N6y5clZzAwBGDMkxP422y+yt+4wM4O3fOOCbhQbKteyRGRrf6d6QmITipcxrdvRHs8amVddw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774032597; c=relaxed/simple;
	bh=ode6IRLnzBGMe/RGmjV1E8zt/s+60bcNaK3PwIbfPos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avsM7DzveJyynKUXq7csxHMOhkcClvEjn5yf/asP2CmDRXcF4BANrtnXS/cslW3/MlyjSYQ9jMyuDFEWobY7pdYNy8oFOY2ouXDn4gOGMaRgzOU+B+da1hOn4+t4tGZjgZPlCOMA3Ml5sf+1uAntvCcO08eZOY8dbkbTMq1ZnTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CxLTkIgF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CxLTkIgF"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62KHJf8r4073613;
	Fri, 20 Mar 2026 18:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MkAI5C
	rMxU4Dfuhrmy74i1Px9ryimnDJC+LC+CxKzEk=; b=CxLTkIgFDbuwJlQTwtf/Do
	DbzikauyZF49TYoSE4d+sxJgvI7aLZstgLnQCJxgD9OKkHXEncTwONi8bPnt8seP
	UT3DwxsILBBvpaAlEOVTqjRHPCits5+G6HeC7i3tcCZEHPZI6qcJX0yD7sWJqSWJ
	vUPFowgwBUDmHxvXSJd08TX3iXLmpfCQCIFQ7DQsRTmjeWj3zNNVhTRcbc69Hrgs
	zAfzLs9kOUDb1oZP9gXyhrXf6ruXUSbXyvH7+fBRzzCQOTgsmKmTC09WDLzpxaVE
	EhRbGvJa6uqAmp519SIiwml3ArDRsHUe0I9t6sK5arIBEuUyUvTjmqCXltWh7pFA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvy6556mw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 18:49:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62KIM00P028455;
	Fri, 20 Mar 2026 18:49:47 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq1r9wh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 18:49:47 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62KInhp951446196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 18:49:44 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC6F720043;
	Fri, 20 Mar 2026 18:49:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD8C120040;
	Fri, 20 Mar 2026 18:49:38 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.124.222.114])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 20 Mar 2026 18:49:38 +0000 (GMT)
Date: Sat, 21 Mar 2026 00:19:35 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Samir M <samir@linux.ibm.com>, Joel Fernandes <joelagnelf@nvidia.com>,
        peterz@infradead.org, aboorvad@linux.ibm.com, boqun.feng@gmail.com,
        frederic@kernel.org, josh@joshtriplett.org,
        linux-kernel@vger.kernel.org, neeraj.upadhyay@kernel.org,
        rcu@vger.kernel.org, rostedt@goodmis.org, srikar@linux.ibm.com,
        sshegde@linux.ibm.com, tglx@linutronix.de, urezki@gmail.com
Subject: Re: [PATCH v3 2/2] cpuhp: Expedite RCU grace periods during SMT
 operations
Message-ID: <ab2WvwjWNnJceaWS@linux.ibm.com>
References: <20260218083915.660252-2-vishalc@linux.ibm.com>
 <20260218083915.660252-6-vishalc@linux.ibm.com>
 <20260227011352.GA1089964@joelbox2>
 <94b3284b-885d-4263-99ed-728375c1a2b7@linux.ibm.com>
 <aapprY-prH0l_WeK@linux.ibm.com>
 <bde1a8b9-7f56-45fb-830c-038fa7b85f0d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bde1a8b9-7f56-45fb-830c-038fa7b85f0d@paulmck-laptop>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7uJiPmEhmNVwxS0uKKnNU_5XUmYhLJaP
X-Proofpoint-GUID: 7uJiPmEhmNVwxS0uKKnNU_5XUmYhLJaP
X-Authority-Analysis: v=2.4 cv=KYnfcAYD c=1 sm=1 tr=0 ts=69bd96cc cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=X-Hu_6gHTJTtgA5pAAIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE1MiBTYWx0ZWRfX2zbgprhNtXbU
 /+mlw8LMMuLxZ2URVmIixZoJBoSCj9eIhCi8R1ZLMsHPg/++JoSnEKQzs6vIDxBdPNoNUqR64e1
 /hIx4fwd10p+zJ+sIuYnv2syNNoS2YKANt5zDrssw5SBYDvZerk9CUZax37lCP1N+38Rd8wD+3s
 Xdo6Ig/C3RcZE93VMR5dkicpqQdwYh4DNYpmUw2DxxjhKwp/Y+btW5uXIdR0V4cLCSiz7baQ8/S
 ZU9+Wb6++gKK9AkdhTaABF2I/YbcvQcBtQUU2s9z0k0+ZQ9Ou6cbLFEvdrqzuzneXsBZbE6Al0m
 yxeDx1+s/cRAVcefQQ7WfMFUlSFi6ixh2wAN0pAwTJ652IVNBKigbE7DikRO/82QWenDUoKVU/5
 ym8NYCshJPnYpNHUFWmBnPpAiCoJrzivsnMvEc6WfAl+3YG7lRz261fQL3KFBC17cxKG2iZdI8G
 Zj5QxQUW7TOD1Y9yh7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200152

Hi Paul, Thank you for your response. 
Sorry, I could not revert back quicker.

As I wanted to understand what's happening behind the scenes after the
cpuhp kthread blocks upon execution of synchronize_rcu(). So I did a
little more digging.

On a 320 CPU system, (SMT8 to SMT4) operation takes >1 minute to complete.
160 CPUs are offlined one by one. 

In total 321 synchronize_rcu() calls are invoked taking ~125ms to finish
(ftrace option sleep-time set).

3298110.851011 |   316)  cpuhp/3-1614  |               |  synchronize_rcu() {
3298111.010125 |   316)  cpuhp/3-1614  | @ 159112.9 us |  }
--
3298111.020432 |     0) kworker-29406  |               |  synchronize_rcu() {
3298111.190132 |     0) kworker-29406  | @ 169699.4 us |  }
--
3298111.191327 |   317)  cpuhp/3-1619  |               |  synchronize_rcu() {
3298111.350129 |   317)  cpuhp/3-1619  | @ 158801.9 us |  }
--
3298111.360263 |     0) kworker-29406  |               |  synchronize_rcu() {
3298111.530137 |     0) kworker-29406  | @ 169874.5 us |  }
--
3298111.531098 |   318)  cpuhp/3-1624  |               |  synchronize_rcu() {
3298111.650128 |   318)  cpuhp/3-1624  | @ 119029.8 us |  }

Breakdown of the time spent during a single synchronize_rcu() during the
invocation of sched_cpu_deactivate callback (CPU 4 was offlined)

Summary:
--> cpuhp_enter (sched_cpu_deactivate)
CB registration → AccWaitCB        ~10ms     Waiting for softirq tick on CPU 4
GP 220685125: FQS scan 1           ~10ms     Tick delay + scan (all clear except CPU 260, 
                                                        rcu_gp_kthread is running on CPU 260)
GP 220685125: wait for CPU 260     ~30msi    FQS sleep interval, CPU 260 not yet reported
GP 220685125: FQS scan 2 + end     ~0.02ms   CPU 260 clears
GP 220685129: FQS scan 1           ~30ms     Tick delay + full scan (same: CPU 260 holdout)
GP 220685129: wait for CPU 260     ~30ms     Same pattern
GP 220685129: FQS scan 2 + end     ~0.02ms   CPU 260 clears
CB invocation + wakeup             ~10ms     Softirq tick invokes wakeme_after_rcu
destroy_sched_domains_rcu queueing ~8ms322   call_rcu() callbacks
<-- cpuhp_exit (sched_cpu_deactivate)

I have collected some rcu static tracepoint data, which I am currently
going through.

On Fri, Mar 06, 2026 at 07:12:04AM -0800, Paul E. McKenney wrote:
> On Fri, Mar 06, 2026 at 11:14:13AM +0530, Vishal Chourasia wrote:
> > On Mon, Mar 02, 2026 at 05:17:16PM +0530, Samir M wrote:
> > > 
> > > On 27/02/26 6:43 am, Joel Fernandes wrote:
> > > > On Wed, Feb 18, 2026 at 02:09:18PM +0530, Vishal Chourasia wrote:
> > > > > Expedite synchronize_rcu during the SMT mode switch operation when
> > > > > initiated via /sys/devices/system/cpu/smt/control interface
> > > > >
> > > > After the locking related changes in patch 1, is expediting still required? I
> > Yes.
> > > > am just a bit concerned that we are papering over the real issue of over
> > > > usage of synchronize_rcu() (which IIRC we discussed in earlier versions of
> > > > the patches that reducing the number of lock acquire/release was supposed to
> > > > help.)
> > At present, I am not sure about the underlying issue. So far what I have
> > found is when synchronize_rcu() is invoked, it marks the start of a new
> > grace period number, say A. Thread invoking synchronize_rcu() blocks
> > until all CPUs have reported QS for GP "A". There is a rcu grace period
> > kthread that runs periodically looping over a CPU list to figure out all
> > CPUs have reported QS. In the trace, I find some CPUs reporting QS for
> > sequence number way back in the past for ex. A - N where N is > 10.
> 
> This can happen when a CPU goes idle for multiple grace periods, then
> wakes up in the middle of a later grace period.  This is (or at least is
> supposed to be) harmless because a quiescent state was reported on that
> CPU's behalf when RCU noticed that it was idle.  The report is quashed
If it is harmless, can we consider just expediting the smt mode switch
operation via smt/control file [1].

Thanks, vishalc

[1] https://lore.kernel.org/all/20260218083915.660252-6-vishalc@linux.ibm.com/

> when RCU notices that the quiescent state being reported is for a grace
> period that has already completed.  Grace-period counter wrap is handled
> by the infamous ->gpwrap field in the rcu_data structure.

> 
> I have seen N having four digits, with deep embedded devices being most
> likely to have extremely large values of N.
> 
> 							Thanx, Paul
> 
> > > > Could you provide more justification of why expediting these sections is
> > > > required if the locking concerns were addressed? It would be great if you can
> > > > provide performance numbers with only the first patch and without the second
> > > > patch. That way we can quantify this patch.
> > > > 
> > > > 
> > > SMT Mode    | Without Patch(Base) | both patch applied | % Improvement  |
> > > ------------------------------------------------------------------------|
> > > SMT=off     | 16m 13.956s         |     6m 18.435s     |  +61.14 %      |
> > > SMT=on      | 12m 0.982s          |     5m 59.576s     |  +50.10 %      |
> > > 
> > > When I tested the below patch independently, I did not observe any
> > > improvements for either smt=on or smt=off. However, in the smt=off scenario,
> > > I encountered hung task splats (with call traces), where some threads were
> > > blocked on cpus_read_lock. Please also refer to the attached call trace
> > > below.
> > > Patch 1:
> > > https://lore.kernel.org/all/20260218083915.660252-4-vishalc@linux.ibm.com/
> > > 
> > > SMT Mode    | Without Patch(Base) | just patch 1 applied   | % Improvement 
> > > |
> > > ----------------------------------------------------------------------------|
> > > SMT=off     | 16m 13.956s         |     16m 9.793s         |  +0.43 %     
> > >  |
> > > SMT=on      | 12m 0.982s          |     12m 19.494s        |  -2.57 %     
> > >  |
> > > 
> > > 
> > > Call traces:
> > > 12377] [  T8746]    Tainted: G      E 7.0.0-rc1-150700.51-default-dirty #1
> > > [ 1477.612384] [  T8746] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > > disables this message.
> > > [ 1477.612389] [  T8746] task:systemd     state:D stack:0   pid:1  tgid:1 
> > >  ppid:0   task_flags:0x400100 flags:0x00040000
> > > [ 1477.612397] [  T8746] Call Trace:
> > > [ 1477.612399] [  T8746] [c00000000cc0f4f0] [0000000000100000] 0x100000
> > > (unreliable)
> > > [ 1477.612416] [  T8746] [c00000000cc0f6a0] [c00000000001fe5c]
> > > __switch_to+0x1dc/0x290
> > > [ 1477.612425] [  T8746] [c00000000cc0f6f0] [c0000000012598ac]
> > > __schedule+0x40c/0x1a70
> > > [ 1477.612433] [  T8746] [c00000000cc0f840] [c00000000125af58]
> > > schedule+0x48/0x1a0
> > > [ 1477.612439] [  T8746] [c00000000cc0f870] [c0000000002e27b8]
> > > percpu_rwsem_wait+0x198/0x200
> > > [ 1477.612445] [  T8746] [c00000000cc0f8f0] [c000000001262930]
> > > __percpu_down_read+0xb0/0x210
> > > [ 1477.612449] [  T8746] [c00000000cc0f930] [c00000000022f400]
> > > cpus_read_lock+0xc0/0xd0
> > > [ 1477.612456] [  T8746] [c00000000cc0f950] [c0000000003a6398]
> > > cgroup_procs_write_start+0x328/0x410
> > > [ 1477.612462] [  T8746] [c00000000cc0fa00] [c0000000003a9620]
> > > __cgroup_procs_write+0x70/0x2c0
> > > [ 1477.612468] [  T8746] [c00000000cc0fac0] [c0000000003a98e8]
> > > cgroup_procs_write+0x28/0x50
> > > [ 1477.612473] [  T8746] [c00000000cc0faf0] [c0000000003a1624]
> > > cgroup_file_write+0xb4/0x240
> > > [ 1477.612478] [  T8746] [c00000000cc0fb50] [c000000000853ba8]
> > > kernfs_fop_write_iter+0x1a8/0x2a0
> > > [ 1477.612485] [  T8746] [c00000000cc0fba0] [c000000000733d5c]
> > > vfs_write+0x27c/0x540
> > > [ 1477.612491] [  T8746] [c00000000cc0fc50] [c000000000734350]
> > > ksys_write+0x80/0x150
> > > [ 1477.612495] [  T8746] [c00000000cc0fca0] [c000000000032898]
> > > system_call_exception+0x148/0x320
> > > [ 1477.612500] [  T8746] [c00000000cc0fe50] [c00000000000d6a0]
> > > system_call_common+0x160/0x2c4
> > > [ 1477.612506] [  T8746] ---- interrupt: c00 at 0x7fffa8f73df4
> > > [ 1477.612509] [  T8746] NIP: 00007fffa8f73df4 LR: 00007fffa8eb6144 CTR:
> > > 0000000000000000
> > > [ 1477.612512] [  T8746] REGS: c00000000cc0fe80 TRAP: 0c00 Tainted: G     
> > > E    (7.0.0-rc1-150700.51-default-dirty)
> > > [ 1477.612515] [  T8746] MSR: 800000000000d033 <SF,EE,PR,ME,IR,DR,RI,LE> CR:
> > > 28002288 XER: 00000000
> > > 
> > > 
> > 
> > Default timeout is set to 8 mins.
> > 
> > $ grep . /proc/sys/kernel/hung_task_timeout_secs
> > /proc/sys/kernel/hung_task_timeout_secs:480
> > 
> > Now that cpus_write_lock is taken once, and SMT mode switch can take
> > tens of minutes to complete and relinquish the lock, threads waiting on 
> > cpus_read_lock will be blocked for this entire duration.
> > 
> > Although there were no splats observed for "both patch applied" case
> > the issue still remains.
> > 
> > regards,
> > vishal
