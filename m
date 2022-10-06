Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD01C4332F
	for <rcu@archiver.kernel.org>; Thu,  6 Oct 2022 18:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJFSnK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 6 Oct 2022 14:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJFSnJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 6 Oct 2022 14:43:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586AFC510E
        for <rcu@vger.kernel.org>; Thu,  6 Oct 2022 11:43:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 700CCB82144
        for <rcu@vger.kernel.org>; Thu,  6 Oct 2022 18:43:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118F3C433D6;
        Thu,  6 Oct 2022 18:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665081785;
        bh=PsAOK4CXbZglRLAzpj4kmIb+zy9tfhcR1d3FmJ6+Qn4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HIEnLrl1NmRN6R49mg2gyXNT1sdWRk6fpIoohfkt0oyf4dHYUvq9K8zZYGCoeuXte
         yBMGdUAefkUFGEYvYbSut8wsEGiC7FfcnerlbrbnKWbhnQQdynffNo5YnvhKqyz6lF
         iu0I2wULGRYXwP54ampRakXh5KeooaP3Ih5ZmBJNyvAHEqH9noVzNuRQlAQAf9uxgq
         oBWIMmSzgCZt5KILyjbj1dklLAyZRvhify2HBeDhQIqdbRy+gT2Sl22t9pIaRWTNQb
         ZRFF0EVU7NpqgP1T2UYSHLy8rK0LVmk1lL0o9kVLbb4ip3DCTP0mQkAtR7vHTZhZHn
         HdRDWAEVih53g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A51175C0F66; Thu,  6 Oct 2022 11:43:04 -0700 (PDT)
Date:   Thu, 6 Oct 2022 11:43:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     5486 <3164135486@qq.com>
Cc:     rcu <rcu@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN77ya5Zue5aSN77ya5Zue?= =?utf-8?B?5aSN77yaUmU6?=
Message-ID: <20221006184304.GA4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <tencent_BB0C9F0DE163BBB4638FB155CB4C8FFA6F07@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_BB0C9F0DE163BBB4638FB155CB4C8FFA6F07@qq.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Oct 07, 2022 at 12:55:49AM +0800, 5486 wrote:
> &gt;&nbsp;Note that the last argument to on_each_cpu() is "1", that is,
> &gt;&nbsp;on_each_cpu() does not return until rcu_barrier_func() has executed on
> &gt;&nbsp;all CPUs.
> o .
> 
> 
> 
> &gt;Can your scenario happen?
> 
> rcu_barrier_func&nbsp; execution is not enough,the goal is finish all the rcu callback functions.
> 
> so it can.

OK, then please show the sequence of calls to rcu_barrier_func() and
rcu_barrier_callback() on their respective CPUs, along with their effects
on rcu_barrier_cpu_count, in order to show exactly how this can happen.

							Thanx, Paul

> 原始邮件
>                        
>                      
> 
> 发件人："Paul E. McKenney"< paulmck@kernel.org &gt;;
> 
> 发件时间：2022/10/7 0:46
> 
> 收件人："5486"< 3164135486@qq.com &gt;;
> 
> 抄送人："rcu"< rcu@vger.kernel.org &gt;;
> 
> 主题：回复：回复：Re:
> 
> 
> On Fri, Oct 07, 2022 at 12:38:56AM +0800, 5486 wrote:
> &gt; In fact suppose there are for cpuscpu0 cpu1 cpu2 cpu3
> &gt; 
> &gt; 
> &gt; the value of rcu_barrier_cpu_count may be
> &gt; 
> &gt; 
> &gt; 1 &nbsp;cpu0 2 -&gt; 1 cpu1 2 -&gt; 1 cpu2 2 -&gt; 1
> &gt; then on_each_cpu finished rcu_barrier_cpu_count decreased to be 0
> &gt; then complete(&amp;rcu_barrier_completion); rcu_barrier finished.but rcu_barrier_func of cpu3 may not&nbsp;have been executed.
> 
> Note that the last argument to on_each_cpu() is "1", that is,
> on_each_cpu() does not return until rcu_barrier_func() has executed on
> all CPUs.
> 
> Can your scenario happen?
> 
> 							Thanx, Paul
> 
> &gt; 原始邮件
> &gt;                        
> &gt;                      
> &gt; 
> &gt; 发件人："Paul E. McKenney"< paulmck@kernel.org &gt;;
> &gt; 
> &gt; 发件时间：2022/10/6 19:57
> &gt; 
> &gt; 收件人："5486"< 3164135486@qq.com &gt;;
> &gt; 
> &gt; 抄送人："rcu"< rcu@vger.kernel.org &gt;;
> &gt; 
> &gt; 主题：回复：Re:
> &gt; 
> &gt; 
> &gt; On Thu, Oct 06, 2022 at 05:56:35PM +0800, 5486 wrote:
> &gt; &gt; My problem is &nbsp;some grace period can take very little time shorter than the one iteration of on_each_cpu itself。So the complete() can execute on one cpu before the last of all. &nbsp;
> &gt; 
> &gt; And that is the bug.  Very good!
> &gt; 
> &gt; &gt; but now 
> &gt; &gt; The key is on_each_cpu &nbsp;,it is really clever that on_each_cpu &nbsp;will prevent completion of any grace periods. Concealed Mechanism！
> &gt; &gt; Is it?
> &gt; &gt; In this ancient version code have &nbsp;real race-condition bugs .I will take some time to study to find it and reply to you.
> &gt; &gt; it is about on_each_cpu have not prohibit preemption? ,I did not cover more things related to the operationg system.
> &gt; 
> &gt; Suppose the code instead read as follows?
> &gt; 
> &gt; void rcu_barrier(void)
> &gt; {
> &gt; 	BUG_ON(in_interrupt());
> &gt; 	/* Take cpucontrol semaphore to protect against CPU hotplug */
> &gt; 	down(&amp;rcu_barrier_sema);
> &gt; 	init_completion(&amp;rcu_barrier_completion);
> &gt; 	atomic_set(&amp;rcu_barrier_cpu_count, 1);
> &gt; 	on_each_cpu(rcu_barrier_func, NULL, 0, 1);
> &gt; 	if (atomic_dec_and_test(&amp;rcu_barrier_cpu_count))
> &gt; 		complete(&amp;rcu_barrier_completion);
> &gt; 	wait_for_completion(&amp;rcu_barrier_completion);
> &gt; 	up(&amp;rcu_barrier_sema);
> &gt; }
> &gt; 
> &gt; Would that work?  Or are there additional bugs?
> &gt; 
> &gt; 							Thanx, Paul
> &gt; 
> &gt; &gt; Chao,Li
> &gt; &gt; 
> &gt; &gt;                        
> &gt; &gt; 原始邮件
> &gt; &gt;                        
> &gt; &gt;                      
> &gt; &gt; 
> &gt; &gt; 发件人："Paul E. McKenney"< paulmck@kernel.org &gt;;
> &gt; &gt; 
> &gt; &gt; 发件时间：2022/10/5 21:01
> &gt; &gt; 
> &gt; &gt; 收件人："5486"< 3164135486@qq.com &gt;;
> &gt; &gt; 
> &gt; &gt; 抄送人："rcu"< rcu@vger.kernel.org &gt;;
> &gt; &gt; 
> &gt; &gt; 主题：Re: Dear Pualmack help i have a problem with rcu code
> &gt; &gt; 
> &gt; &gt; 
> &gt; &gt; On Tue, Oct 04, 2022 at 03:04:19AM +0800, 5486 wrote:
> &gt; &gt; &gt; Dear&nbsp;Pualmack i have problem.
> &gt; &gt; &gt; I have been reading the patch
> &gt; &gt; &gt; https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/kernel?id=ab4720ec76b756e1f8705e207a7b392b0453afd6
> &gt; &gt; &gt; 
> &gt; &gt; &gt; 
> &gt; &gt; &gt; 
> &gt; &gt; &gt; +	wait_for_completion(&amp;rcu_barrier_completion);
> &gt; &gt; &gt; 
> &gt; &gt; &gt; How this guarantees all completes to be done ?
> &gt; &gt; &gt; I learn one wait_for_completion corresponds to one&nbsp;x-&gt;done++ once a time
> &gt; &gt; 
> &gt; &gt; 2005!  That takes me back a bit!
> &gt; &gt; 
> &gt; &gt; Adding the rcu email list on CC to archive this and for others to
> &gt; &gt; weigh in.
> &gt; &gt; 
> &gt; &gt; The trick is that rcu_barrier_callback() is an RCU callback that executes
> &gt; &gt; on each CPU (see the on_each_cpu() in the rcu_barrier() function.)
> &gt; &gt; 
> &gt; &gt; This RCU callback function is queued using call_rcu(), which queues
> &gt; &gt; that callback at the end of the CPU's callback list.  Thus, all
> &gt; &gt; RCU callback functions that were already queued on that CPU will
> &gt; &gt; be invoked before rcu_barrier_callback() in invoked.
> &gt; &gt; 
> &gt; &gt; The rcu_barrier_callback() does an atomic_dec_and_test() operation on the
> &gt; &gt; rcu_barrier_cpu_count global variable, and only when this variable becomes
> &gt; &gt; zero does it invoke complete().  This atomic_dec_and_test() operation is
> &gt; &gt; fully ordered, and thus ensures that all the earlier atomic_dec_and_test()
> &gt; &gt; operations on this variable are globally seen to happen before the last
> &gt; &gt; such operation (the one that decrements rcu_barrier_cpu_count to zero).
> &gt; &gt; 
> &gt; &gt; This last rcu_barrier_callback() will then invoke complete().  This will
> &gt; &gt; ensure that the wakeup in wait_for_completion() happens only after all
> &gt; &gt; previously queued RCU callbacks are invoked.
> &gt; &gt; 
> &gt; &gt; Almost, anyway.
> &gt; &gt; 
> &gt; &gt; There are rare but real race-condition bugs in this ancient version
> &gt; &gt; of rcu_barrier().  Can you tell me what they are?
> &gt; &gt; 
> &gt; &gt; 							Thanx, Paul
