Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69ACC433F5
	for <rcu@archiver.kernel.org>; Fri,  7 Oct 2022 08:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiJGIfh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 7 Oct 2022 04:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiJGIfe (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 7 Oct 2022 04:35:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3154233E1D
        for <rcu@vger.kernel.org>; Fri,  7 Oct 2022 01:35:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC78561AFB
        for <rcu@vger.kernel.org>; Fri,  7 Oct 2022 08:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C393C433C1;
        Fri,  7 Oct 2022 08:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665131731;
        bh=tB7QbW+MrkAo8hiWaa/USfJzRfi3HhV4J6V9hNU7vcI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AlxX5VwOTPL7d3gozwnwi8ixtAgTxN/FZeSv4iUWcBDu1Jb9cdyerG/scFQRwjIKv
         Hszj8dw2CsvxzNP1a+ctrx/wpAvij3vIrU1HKkXdcxY9IIXe9zOLx99b3rB8NDUQr8
         HFNGwfN29H5jUr4b1eD3Wdr/++IxObyfzYn62CgpUP/ltddceQMYQvJAy2Yi8uH+cq
         sWX1qK1GkFi0L3YlJ2WltMunp6InihmMuu90oRiQw+AasLvH827pVGIXT9PKbV15FR
         LjUZHxTgeHnW2DVEqJ/Cjag9bHz0AuIUFSBI1/NR1Z2N6A1ax5N9tjwuAAxtKIkQ4z
         uzmMjI63mLnPw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C44785C0A1F; Fri,  7 Oct 2022 01:35:30 -0700 (PDT)
Date:   Fri, 7 Oct 2022 01:35:30 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     5486 <3164135486@qq.com>
Cc:     rcu <rcu@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN77ya5Zue5aSN77ya5Zue?=
 =?utf-8?B?5aSN77ya5Zue5aSN77yaUmU6?=
Message-ID: <20221007083530.GF4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <tencent_B5C892CCA3FDFBC56745B8D50EEB1862AC05@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_B5C892CCA3FDFBC56745B8D50EEB1862AC05@qq.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Good diagram, thank you!

But that call to on_each_cpu() looks like this:

	on_each_cpu(rcu_barrier_func, NULL, 0, 1);

Doesn't that last parameter of "1" mean that on_each_cpu() cannot return
until after CPU 3's call to rcu_barrier_func() finishes?

							Thanx, Paul

On Fri, Oct 07, 2022 at 04:03:12PM +0800, 5486 wrote:
> 原始邮件
>                        
>                      
> 
> 发件人："Paul E. McKenney"< paulmck@kernel.org &gt;;
> 
> 发件时间：2022/10/7 2:43
> 
> 收件人："5486"< 3164135486@qq.com &gt;;
> 
> 抄送人："rcu"< rcu@vger.kernel.org &gt;;
> 
> 主题：回复：回复：回复：Re:
> 
> 
> On Fri, Oct 07, 2022 at 12:55:49AM +0800, 5486 wrote:
> &gt; &gt;&nbsp;Note that the last argument to on_each_cpu() is "1", that is,
> &gt; &gt;&nbsp;on_each_cpu() does not return until rcu_barrier_func() has executed on
> &gt; &gt;&nbsp;all CPUs.
> &gt; o .
> &gt; 
> &gt; 
> &gt; 
> &gt; &gt;Can your scenario happen?
> &gt; 
> &gt; rcu_barrier_func&nbsp; execution is not enough,the goal is finish all the rcu callback functions.
> &gt; 
> &gt; so it can.
> 
> OK, then please show the sequence of calls to rcu_barrier_func() and
> rcu_barrier_callback() on their respective CPUs, along with their effects
> on rcu_barrier_cpu_count, in order to show exactly how this can happen.
> 
> 							Thanx, Paul
> 
> &gt; 原始邮件
> &gt;                        
> &gt;                      
> &gt; 
> &gt; 发件人："Paul E. McKenney"< paulmck@kernel.org &gt;;
> &gt; 
> &gt; 发件时间：2022/10/7 0:46
> &gt; 
> &gt; 收件人："5486"< 3164135486@qq.com &gt;;
> &gt; 
> &gt; 抄送人："rcu"< rcu@vger.kernel.org &gt;;
> &gt; 
> &gt; 主题：回复：回复：Re:
> &gt; 
> &gt; 
> &gt; On Fri, Oct 07, 2022 at 12:38:56AM +0800, 5486 wrote:
> &gt; &gt; In fact suppose there are for cpuscpu0 cpu1 cpu2 cpu3
> &gt; &gt; 
> &gt; &gt; 
> &gt; &gt; the value of rcu_barrier_cpu_count may be
> &gt; &gt; 
> &gt; &gt; 
> &gt; &gt; 1 &nbsp;cpu0 2 -&gt; 1 cpu1 2 -&gt; 1 cpu2 2 -&gt; 1
> &gt; &gt; then on_each_cpu finished rcu_barrier_cpu_count decreased to be 0
> &gt; &gt; then complete(&amp;rcu_barrier_completion); rcu_barrier finished.but rcu_barrier_func of cpu3 may not&nbsp;have been executed.
> &gt; 
> &gt; Note that the last argument to on_each_cpu() is "1", that is,
> &gt; on_each_cpu() does not return until rcu_barrier_func() has executed on
> &gt; all CPUs.
> &gt; 
> &gt; Can your scenario happen?
> &gt; 
> &gt; 							Thanx, Paul
> &gt; 
> &gt; &gt; 原始邮件
> &gt; &gt;                        
> &gt; &gt;                      
> &gt; &gt; 
> &gt; &gt; 发件人："Paul E. McKenney"< paulmck@kernel.org &gt;;
> &gt; &gt; 
> &gt; &gt; 发件时间：2022/10/6 19:57
> &gt; &gt; 
> &gt; &gt; 收件人："5486"< 3164135486@qq.com &gt;;
> &gt; &gt; 
> &gt; &gt; 抄送人："rcu"< rcu@vger.kernel.org &gt;;
> &gt; &gt; 
> &gt; &gt; 主题：回复：Re:
> &gt; &gt; 
> &gt; &gt; 
> &gt; &gt; On Thu, Oct 06, 2022 at 05:56:35PM +0800, 5486 wrote:
> &gt; &gt; &gt; My problem is &nbsp;some grace period can take very little time shorter than the one iteration of on_each_cpu itself。So the complete() can execute on one cpu before the last of all. &nbsp;
> &gt; &gt; 
> &gt; &gt; And that is the bug.  Very good!
> &gt; &gt; 
> &gt; &gt; &gt; but now 
> &gt; &gt; &gt; The key is on_each_cpu &nbsp;,it is really clever that on_each_cpu &nbsp;will prevent completion of any grace periods. Concealed Mechanism！
> &gt; &gt; &gt; Is it?
> &gt; &gt; &gt; In this ancient version code have &nbsp;real race-condition bugs .I will take some time to study to find it and reply to you.
> &gt; &gt; &gt; it is about on_each_cpu have not prohibit preemption? ,I did not cover more things related to the operationg system.
> &gt; &gt; 
> &gt; &gt; Suppose the code instead read as follows?
> &gt; &gt; 
> &gt; &gt; void rcu_barrier(void)
> &gt; &gt; {
> &gt; &gt; 	BUG_ON(in_interrupt());
> &gt; &gt; 	/* Take cpucontrol semaphore to protect against CPU hotplug */
> &gt; &gt; 	down(&amp;rcu_barrier_sema);
> &gt; &gt; 	init_completion(&amp;rcu_barrier_completion);
> &gt; &gt; 	atomic_set(&amp;rcu_barrier_cpu_count, 1);
> &gt; &gt; 	on_each_cpu(rcu_barrier_func, NULL, 0, 1);
> &gt; &gt; 	if (atomic_dec_and_test(&amp;rcu_barrier_cpu_count))
> &gt; &gt; 		complete(&amp;rcu_barrier_completion);
> &gt; &gt; 	wait_for_completion(&amp;rcu_barrier_completion);
> &gt; &gt; 	up(&amp;rcu_barrier_sema);
> &gt; &gt; }
> &gt; &gt; 
> &gt; &gt; Would that work?  Or are there additional bugs?
> &gt; &gt; 
> &gt; &gt; 							Thanx, Paul
> &gt; &gt; 
> &gt; &gt; &gt; Chao,Li
> &gt; &gt; &gt; 
> &gt; &gt; &gt;                        
> &gt; &gt; &gt; 原始邮件
> &gt; &gt; &gt;                        
> &gt; &gt; &gt;                      
> &gt; &gt; &gt; 
> &gt; &gt; &gt; 发件人："Paul E. McKenney"< paulmck@kernel.org &gt;;
> &gt; &gt; &gt; 
> &gt; &gt; &gt; 发件时间：2022/10/5 21:01
> &gt; &gt; &gt; 
> &gt; &gt; &gt; 收件人："5486"< 3164135486@qq.com &gt;;
> &gt; &gt; &gt; 
> &gt; &gt; &gt; 抄送人："rcu"< rcu@vger.kernel.org &gt;;
> &gt; &gt; &gt; 
> &gt; &gt; &gt; 主题：Re: Dear Pualmack help i have a problem with rcu code
> &gt; &gt; &gt; 
> &gt; &gt; &gt; 
> &gt; &gt; &gt; On Tue, Oct 04, 2022 at 03:04:19AM +0800, 5486 wrote:
> &gt; &gt; &gt; &gt; Dear&nbsp;Pualmack i have problem.
> &gt; &gt; &gt; &gt; I have been reading the patch
> &gt; &gt; &gt; &gt; https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/kernel?id=ab4720ec76b756e1f8705e207a7b392b0453afd6
> &gt; &gt; &gt; &gt; 
> &gt; &gt; &gt; &gt; 
> &gt; &gt; &gt; &gt; 
> &gt; &gt; &gt; &gt; +	wait_for_completion(&amp;rcu_barrier_completion);
> &gt; &gt; &gt; &gt; 
> &gt; &gt; &gt; &gt; How this guarantees all completes to be done ?
> &gt; &gt; &gt; &gt; I learn one wait_for_completion corresponds to one&nbsp;x-&gt;done++ once a time
> &gt; &gt; &gt; 
> &gt; &gt; &gt; 2005!  That takes me back a bit!
> &gt; &gt; &gt; 
> &gt; &gt; &gt; Adding the rcu email list on CC to archive this and for others to
> &gt; &gt; &gt; weigh in.
> &gt; &gt; &gt; 
> &gt; &gt; &gt; The trick is that rcu_barrier_callback() is an RCU callback that executes
> &gt; &gt; &gt; on each CPU (see the on_each_cpu() in the rcu_barrier() function.)
> &gt; &gt; &gt; 
> &gt; &gt; &gt; This RCU callback function is queued using call_rcu(), which queues
> &gt; &gt; &gt; that callback at the end of the CPU's callback list.  Thus, all
> &gt; &gt; &gt; RCU callback functions that were already queued on that CPU will
> &gt; &gt; &gt; be invoked before rcu_barrier_callback() in invoked.
> &gt; &gt; &gt; 
> &gt; &gt; &gt; The rcu_barrier_callback() does an atomic_dec_and_test() operation on the
> &gt; &gt; &gt; rcu_barrier_cpu_count global variable, and only when this variable becomes
> &gt; &gt; &gt; zero does it invoke complete().  This atomic_dec_and_test() operation is
> &gt; &gt; &gt; fully ordered, and thus ensures that all the earlier atomic_dec_and_test()
> &gt; &gt; &gt; operations on this variable are globally seen to happen before the last
> &gt; &gt; &gt; such operation (the one that decrements rcu_barrier_cpu_count to zero).
> &gt; &gt; &gt; 
> &gt; &gt; &gt; This last rcu_barrier_callback() will then invoke complete().  This will
> &gt; &gt; &gt; ensure that the wakeup in wait_for_completion() happens only after all
> &gt; &gt; &gt; previously queued RCU callbacks are invoked.
> &gt; &gt; &gt; 
> &gt; &gt; &gt; Almost, anyway.
> &gt; &gt; &gt; 
> &gt; &gt; &gt; There are rare but real race-condition bugs in this ancient version
> &gt; &gt; &gt; of rcu_barrier().  Can you tell me what they are?
> &gt; &gt; &gt; 
> &gt; &gt; &gt; 							Thanx, Paul


