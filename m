Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AA33126A9;
	Mon, 27 Apr 2026 11:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777289426; cv=none; b=ldWM20n6LhIqR13hBpzKSoS+f7n94Hsn0Yu+u9nkHH/yt2tHabCgdat0Be1xu4ycvW6haIrkJrcX44UrApwpbchyQGvnDQubHpSfdUcZ+KPLYnZ9dfewgzYL5czTT/RMZKgDld8AmXYVCq/c5rQurgOdsYvOuVSjCT9U8ArDBBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777289426; c=relaxed/simple;
	bh=TuX1AeWGNkdvEroOO8+Q0d08pHkANn6TPoKpf482Uds=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=r5LQfvEQdewFKgXoZDRVIYSbZ0jdc16U2zgidkGPRNaxhWGSZkU8QVOGNOLisZfLqOOBGl2hZTcFl4fAu8YLO03HQmgmQUCQwhPfHsIkXVah8Q4g+kpAp3/iosnW8umWIvMmqRt55cC1U65xVlNWA797ZcOJR18fnvSwXR8JERg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qq+lCB9E; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qq+lCB9E"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R1stLK3289925;
	Mon, 27 Apr 2026 11:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UrHKDV
	M3BS8sf5gvBwvFiqkukFSvz3CAG6VxJPknp54=; b=qq+lCB9ESam1RxCvrLUQYX
	aXRX39tF+ulD/Sz+MhiurtP7QJQoazQZMsYX7uE/FsL1wK3K321+wLR0GeVWod3C
	juDLKOySAHQ0OUJupCDT4JL986cMCAcluXEJOIhkI2k84uU4fCm2/EyG/RaDPMny
	yBDBKe+u40VxXhaiSHou4xYUQ9gY4c6CASa0Pc4JvlSzZYVZDd3Ui6DXC9gmEDy7
	63/X/GoP3/EJF4HC0vZHf+yQlGKSDAl5ZIOldevThQk6yAvM5dBGLPkAatN/cuzr
	06ni9P9YhUHjRO8O66C9BnheKQIC/fZOhFtdF1P4lnQUhz8wq1erNSeSu7/Twjvw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9r038h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 11:30:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63RBNlvu009117;
	Mon, 27 Apr 2026 11:30:15 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds9eh4ud6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 11:30:15 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63RBTmcZ5046954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Apr 2026 11:29:48 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 221E658062;
	Mon, 27 Apr 2026 11:30:15 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D9885805C;
	Mon, 27 Apr 2026 11:30:12 +0000 (GMT)
Received: from [9.123.0.247] (unknown [9.123.0.247])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Apr 2026 11:30:11 +0000 (GMT)
Message-ID: <688280dc-78a2-4796-9eaf-e1c058836012@linux.ibm.com>
Date: Mon, 27 Apr 2026 17:00:10 +0530
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [mainline][BUG] Observed Workqueue lockups on offline CPUs.
From: Samir M <samir@linux.ibm.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, RCU <rcu@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, Shrikanth Hegde <sshegde@linux.ibm.com>
References: <97a7d011-d573-4754-9e5d-68b562c64089@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <97a7d011-d573-4754-9e5d-68b562c64089@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 8m-66Hp9T_nGTzfFySpGQ2mNf0Tx20GD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEyMCBTYWx0ZWRfX3qHLwSAlwc0V
 IenjyKY+KuhRXK8irba7Jjazt+fSvwTqDbnqIYKeCuZfH0DyOHNtLdWFUoI+adJeiXh3wkZOnff
 WMmtKxuu5CgChnaHgsCYX9sQPI7exInlZs2IeFWxQ0Ac1LIwNhXuNDMys+pLygNnrOdgJpMxnr7
 I3xktgAk+ni8kT9pcqNqsjWHpy6Ar/IqZHNiA+YD7+Xr4/xJLeL33e9IfbArzH4yEB/8qZYGIPL
 rHlPSOsq/s8GM0Lm+Ab+y+6pA2TzyPnuNrU3i3ch+FC6fy/nJjr16yVI4RQnpqmP2NgVPkDKYuY
 /Y/V82mMSFu8kfz3g3Bu8Qs9TSDuxqj9/3f680IHsBRHaen8dCPib5+oMV6BRqEEzBebuFevUOD
 g+CNx8JINHlDSiFARLdRCc8nWef03paynQNvNExTkCdp6y/pTRx938nArhnXSj6VYwQYQcZ5jJj
 PWrEhCNMUMyaGBQSTIQ==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69ef48c8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=XUFyTfre3SylLFWlK3QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: HpOUvCYn5WwccEah4xODF4KHYNyapTI8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270120


On 27/04/26 3:32 pm, Samir M wrote:
> Hi Paul,
>
> I've been testing the latest upstream kernel on a PowerPC system and 
> encountered workqueue lockup issues that I've bisected to commit 
> 61bbcfb50514 ("srcu: Push srcu_node allocation to GP when 
> non-preemptible").
> After booting, I'm seeing workqueue lockup warnings for CPUs 81-96, 
> which are offline on my system. The workqueues remain stuck for over 
> 237 seconds:
>
> [  243.309302][    C0] BUG: workqueue lockup - pool cpus=81 node=0 
> flags=0x4 nice=0 stuck for 237s!
> [  243.309311][    C0] BUG: workqueue lockup - pool cpus=82 node=0 
> flags=0x4 nice=0 stuck for 237s!
> [  243.309318][    C0] BUG: workqueue lockup - pool cpus=83 node=0 
> flags=0x4 nice=0 stuck for 237s!
> [  243.309326][    C0] BUG: workqueue lockup - pool cpus=84 node=0 
> flags=0x4 nice=0 stuck for 237s!
> [  243.309333][    C0] BUG: workqueue lockup - pool cpus=85 node=0 
> flags=0x4 nice=0 stuck for 237s!
> [  243.309341][    C0] BUG: workqueue lockup - pool cpus=86 node=0 
> flags=0x4 nice=0 stuck for 237s!
> [  243.309348][    C0] BUG: workqueue lockup - pool cpus=87 node=0 
> flags=0x4 nice=0 stuck for 237s!
> [  243.309355][    C0] BUG: workqueue lockup - pool cpus=88 node=0 
> flags=0x4 nice=0 stuck for 237s!
> [  243.309363][    C0] BUG: workqueue lockup - pool cpus=89 node=0 
> flags=0x4 nice=0 stuck for 237s!
> [  243.309370][    C0] BUG: workqueue lockup - pool cpus=90 node=0 
> flags=0x4 nice=0 stuck for 237s!
> [  243.309377][    C0] BUG: workqueue lockup - pool cpus=91 node=0 
> flags=0x4 nice=0 stuck for 237s!
> [  243.309384][    C0] BUG: workqueue lockup - pool cpus=92 node=0 
> flags=0x4 nice=0 stuck for 237s!
> [  243.309392][    C0] BUG: workqueue lockup - pool cpus=93 node=0 
> flags=0x4 nice=0 stuck for 237s!
> [  243.309399][    C0] BUG: workqueue lockup - pool cpus=94 node=0 
> flags=0x4 nice=0 stuck for 237s!
> [  243.309406][    C0] BUG: workqueue lockup - pool cpus=95 node=0 
> flags=0x4 nice=0 stuck for 237s!
> [  243.309413][    C0] BUG: workqueue lockup - pool cpus=96 node=0 
> flags=0x4 nice=0 stuck for 237s!
>
> Git bisect identified this as the first bad commit:
>
> commit 61bbcfb50514a8a94e035a7349697a3790ab4783
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Fri Mar 20 20:29:20 2026 -0700
>
>     srcu: Push srcu_node allocation to GP when non-preemptible
>
>     When the srcutree.convert_to_big and srcutree.big_cpu_lim kernel boot
>     parameters specify initialization-time allocation of the srcu_node
>     tree for statically allocated srcu_struct structures (for example, in
>     DEFINE_SRCU() at build time instead of init_srcu_struct() at 
> runtime),
>     init_srcu_struct_nodes() will attempt to dynamically allocate this 
> tree
>     at the first run-time update-side use of this srcu_struct structure,
>     but while holding a raw spinlock. Because the memory allocator can
>     acquire non-raw spinlocks, this can result in lockdep splats.
>
>     This commit therefore uses the same SRCU_SIZE_ALLOC trick that is 
> used
>     when the first run-time update-side use of this srcu_struct structure
>     happens before srcu_init() is called. The actual allocation then 
> takes
>     place from workqueue context at the ends of upcoming SRCU grace 
> periods.
>
>     [boqun: Adjust the sha1 of the Fixes tag]
>
>     Fixes: 175b45ed343a ("srcu: Use raw spinlocks so call_srcu() can 
> be used under preempt_disable()")
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>     Signed-off-by: Boqun Feng <boqun@kernel.org>
>
>  kernel/rcu/srcutree.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> Reverting this commit resolves the issue.
>
> The problem appears to be that the workqueue is attempting to execute 
> on offline CPUs. The commit moves SRCU node allocation to workqueue 
> context to avoid lockdep issues with memory allocation under raw 
> spinlocks, which makes sense. However, it seems the workqueue 
> scheduling doesn't properly account for CPU online/offline state in 
> this code path.
>
> My test environment:
> - Architecture: PowerPC
> - Kernel version: Latest upstream (7.1-rc1)
> - CPUs 81-96 are offline at boot time
>
> I suspect the issue might be related to:
> 1. Workqueue not checking CPU online status before scheduling SRCU 
> allocation work
> 2. Missing CPU hotplug awareness in the new workqueue-based allocation 
> path
> 3. Possible race condition with CPU hotplug events
>
> Would it make sense to use queue_work_on() with explicit online CPU 
> selection, or add CPU hotplug handlers for this workqueue? I'm not 
> deeply familiar with the workqueue internals, so I might be missing 
> something.
> Please let me know if you need any additional details or if you'd like 
> me to test any patches.
>
> If you happen to fix the above issue, then please add below tag.
> Reported-by: Samir M <samir@linux.ibm.com>
>
>
> Thanks,
> Samir

Hi Paul,


I worked on fixing the issue and introduced the changes below. With 
these updates, I no longer observe any workqueue lockup messages for 
offline CPUs.
Could you please review the changes and share your feedback?

The commit 61bbcfb50514 ("srcu: Push srcu_node allocation to GP when
non-preemptible") introduced workqueue lockups on systems with offline
CPUs. The issue occurs because srcu_queue_delayed_work_on() calls
queue_work_on() with sdp->cpu, which may be offline, causing the
workqueue to spin indefinitely on that CPU.

This patch fixes the issue by checking if the target CPU is online
before queuing work on it. If the CPU is offline, we fall back to
using queue_work() which will schedule the work on any available
online CPU.

Fixes: 61bbcfb50514 ("srcu: Push srcu_node allocation to GP when 
non-preemptible")

Signed-off-by: Samir <samir@linux.ibm.com>
---
  kernel/rcu/srcutree.c | 7 ++++++-
  1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 0d01cd8c4b4a..55a90dd4a030 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -869,10 +869,15 @@ static void srcu_delay_timer(struct timer_list *t)
  static void srcu_queue_delayed_work_on(struct srcu_data *sdp,
  unsigned long delay)
  {
-       if (!delay) {
+       if (!delay && cpu_online(sdp->cpu)) {
                 queue_work_on(sdp->cpu, rcu_gp_wq, &sdp->work);
                 return;
+       } else if (!delay) {
+               /* CPU is offline, queue on any available CPU */
+               queue_work(rcu_gp_wq, &sdp->work);
+               return;
+       }

         timer_reduce(&sdp->delay_work, jiffies + delay);
  }
--


Thanks,
Samir
