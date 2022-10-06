Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A23AC433FE
	for <rcu@archiver.kernel.org>; Thu,  6 Oct 2022 16:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiJFQqW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 6 Oct 2022 12:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbiJFQqW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 6 Oct 2022 12:46:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2758E1004D
        for <rcu@vger.kernel.org>; Thu,  6 Oct 2022 09:46:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B66E061A2D
        for <rcu@vger.kernel.org>; Thu,  6 Oct 2022 16:46:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC49C433D6;
        Thu,  6 Oct 2022 16:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665074780;
        bh=K52u1hfwbCayl4FUVh5UGXTm3EWuByZ8fwYNugODI/U=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Kf84Zrtt75PM5falzpFkRQtBeIlpg5BsH/qxegv3QKDPkyoihOwArbO8nqkNVcEN1
         w4jWHAZam4ILQNUvtPfThO8nzMrFlAzfv8IF/NFmw9zt1Z8M2SAACQzf9/lNR8RwGa
         EoMwy18rkmVJOX6qrasFYUXHorjYhBK010Oty2Xw5ABIpMuPpdlI/T/C8fq1jiuWcP
         HzLmzFrvZg/aGV0FdXlyzfVcqHYNyBI0YLMPxIE5BqGMIzm4txfx3UOqt6lKgSGC8G
         2gxPwGL4JtYcxlLGAiwb4mcwhED7ynXxuaRn3de47+O4UgY7NiCn+kTuf5SpI3oFz4
         BjUrH/3EatfUQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B089D5C0AC7; Thu,  6 Oct 2022 09:46:19 -0700 (PDT)
Date:   Thu, 6 Oct 2022 09:46:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     5486 <3164135486@qq.com>
Cc:     rcu <rcu@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN77ya5Zue5aSN77yaUmU6?=
Message-ID: <20221006164619.GY4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <tencent_0C077C5C8447EC608EDBC6482DCF3C58BF09@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_0C077C5C8447EC608EDBC6482DCF3C58BF09@qq.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Oct 07, 2022 at 12:38:56AM +0800, 5486 wrote:
> In fact suppose there are for cpuscpu0 cpu1 cpu2 cpu3
> 
> 
> the value of rcu_barrier_cpu_count may be
> 
> 
> 1 &nbsp;cpu0 2 -&gt; 1 cpu1 2 -&gt; 1 cpu2 2 -&gt; 1
> then on_each_cpu finished rcu_barrier_cpu_count decreased to be 0
> then complete(&amp;rcu_barrier_completion); rcu_barrier finished.but rcu_barrier_func of cpu3 may not&nbsp;have been executed.

Note that the last argument to on_each_cpu() is "1", that is,
on_each_cpu() does not return until rcu_barrier_func() has executed on
all CPUs.

Can your scenario happen?

							Thanx, Paul

> 原始邮件
>                        
>                      
> 
> 发件人："Paul E. McKenney"< paulmck@kernel.org &gt;;
> 
> 发件时间：2022/10/6 19:57
> 
> 收件人："5486"< 3164135486@qq.com &gt;;
> 
> 抄送人："rcu"< rcu@vger.kernel.org &gt;;
> 
> 主题：回复：Re:
> 
> 
> On Thu, Oct 06, 2022 at 05:56:35PM +0800, 5486 wrote:
> &gt; My problem is &nbsp;some grace period can take very little time shorter than the one iteration of on_each_cpu itself。So the complete() can execute on one cpu before the last of all. &nbsp;
> 
> And that is the bug.  Very good!
> 
> &gt; but now 
> &gt; The key is on_each_cpu &nbsp;,it is really clever that on_each_cpu &nbsp;will prevent completion of any grace periods. Concealed Mechanism！
> &gt; Is it?
> &gt; In this ancient version code have &nbsp;real race-condition bugs .I will take some time to study to find it and reply to you.
> &gt; it is about on_each_cpu have not prohibit preemption? ,I did not cover more things related to the operationg system.
> 
> Suppose the code instead read as follows?
> 
> void rcu_barrier(void)
> {
> 	BUG_ON(in_interrupt());
> 	/* Take cpucontrol semaphore to protect against CPU hotplug */
> 	down(&amp;rcu_barrier_sema);
> 	init_completion(&amp;rcu_barrier_completion);
> 	atomic_set(&amp;rcu_barrier_cpu_count, 1);
> 	on_each_cpu(rcu_barrier_func, NULL, 0, 1);
> 	if (atomic_dec_and_test(&amp;rcu_barrier_cpu_count))
> 		complete(&amp;rcu_barrier_completion);
> 	wait_for_completion(&amp;rcu_barrier_completion);
> 	up(&amp;rcu_barrier_sema);
> }
> 
> Would that work?  Or are there additional bugs?
> 
> 							Thanx, Paul
> 
> &gt; Chao,Li
> &gt; 
> &gt;                        
> &gt; 原始邮件
> &gt;                        
> &gt;                      
> &gt; 
> &gt; 发件人："Paul E. McKenney"< paulmck@kernel.org &gt;;
> &gt; 
> &gt; 发件时间：2022/10/5 21:01
> &gt; 
> &gt; 收件人："5486"< 3164135486@qq.com &gt;;
> &gt; 
> &gt; 抄送人："rcu"< rcu@vger.kernel.org &gt;;
> &gt; 
> &gt; 主题：Re: Dear Pualmack help i have a problem with rcu code
> &gt; 
> &gt; 
> &gt; On Tue, Oct 04, 2022 at 03:04:19AM +0800, 5486 wrote:
> &gt; &gt; Dear&nbsp;Pualmack i have problem.
> &gt; &gt; I have been reading the patch
> &gt; &gt; https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/kernel?id=ab4720ec76b756e1f8705e207a7b392b0453afd6
> &gt; &gt; 
> &gt; &gt; 
> &gt; &gt; 
> &gt; &gt; +	wait_for_completion(&amp;rcu_barrier_completion);
> &gt; &gt; 
> &gt; &gt; How this guarantees all completes to be done ?
> &gt; &gt; I learn one wait_for_completion corresponds to one&nbsp;x-&gt;done++ once a time
> &gt; 
> &gt; 2005!  That takes me back a bit!
> &gt; 
> &gt; Adding the rcu email list on CC to archive this and for others to
> &gt; weigh in.
> &gt; 
> &gt; The trick is that rcu_barrier_callback() is an RCU callback that executes
> &gt; on each CPU (see the on_each_cpu() in the rcu_barrier() function.)
> &gt; 
> &gt; This RCU callback function is queued using call_rcu(), which queues
> &gt; that callback at the end of the CPU's callback list.  Thus, all
> &gt; RCU callback functions that were already queued on that CPU will
> &gt; be invoked before rcu_barrier_callback() in invoked.
> &gt; 
> &gt; The rcu_barrier_callback() does an atomic_dec_and_test() operation on the
> &gt; rcu_barrier_cpu_count global variable, and only when this variable becomes
> &gt; zero does it invoke complete().  This atomic_dec_and_test() operation is
> &gt; fully ordered, and thus ensures that all the earlier atomic_dec_and_test()
> &gt; operations on this variable are globally seen to happen before the last
> &gt; such operation (the one that decrements rcu_barrier_cpu_count to zero).
> &gt; 
> &gt; This last rcu_barrier_callback() will then invoke complete().  This will
> &gt; ensure that the wakeup in wait_for_completion() happens only after all
> &gt; previously queued RCU callbacks are invoked.
> &gt; 
> &gt; Almost, anyway.
> &gt; 
> &gt; There are rare but real race-condition bugs in this ancient version
> &gt; of rcu_barrier().  Can you tell me what they are?
> &gt; 
> &gt; 							Thanx, Paul
