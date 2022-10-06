Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F378DC433FE
	for <rcu@archiver.kernel.org>; Thu,  6 Oct 2022 11:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiJFL5Q (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 6 Oct 2022 07:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJFL5P (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 6 Oct 2022 07:57:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8D09DDA7
        for <rcu@vger.kernel.org>; Thu,  6 Oct 2022 04:57:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24C88B81A76
        for <rcu@vger.kernel.org>; Thu,  6 Oct 2022 11:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C982FC433C1;
        Thu,  6 Oct 2022 11:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665057431;
        bh=OryE8+7tKZXtQBPDrR47ro8e8NblvCMj51IsGauDFKI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BnBRrFhPEsD52tBNPT8N72RuKjUkvGbmrxWEJKAArg7TwJs66CcTc0DTsnNMwSPlK
         ueDm5YPpLWGLvrGaA1oPToE6NcCGvanz8LD7UUoycua3yrLEiBSjw3BL5Pv89KeU5Q
         cmdtfU1m4UUVuyyT9EgZNH7pL4QwX4XiUVW/DHPRo+RTcKTj5KsMRf1cXHz/5UpDGD
         Q0bEur5kPBnTkWiT3lbaOYaToc46XbYztV7OU76Vb/XN3mx++ADGxGpOqWu6YneZ5y
         fQ4sXpiJRxoUmuA0a0sY8xxj3/Ynj1OZZyYuJeyWXDp0olMv0eGpJ7fOTQEx7Pb9+M
         ihUdhZC4O3FLA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 69CA35C102F; Thu,  6 Oct 2022 04:57:11 -0700 (PDT)
Date:   Thu, 6 Oct 2022 04:57:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     5486 <3164135486@qq.com>
Cc:     rcu@vger.kernel.org
Subject: Re: =?utf-8?B?5Zue5aSN77yaUmU=?= =?utf-8?Q?=3A?= Dear Pualmack help
 i have a problem with rcu code
Message-ID: <20221006115711.GS4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <tencent_8D1F53610CBBCEE3E2313BCB310FB46F4E07@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_8D1F53610CBBCEE3E2313BCB310FB46F4E07@qq.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Oct 06, 2022 at 05:56:35PM +0800, 5486 wrote:
> My problem is &nbsp;some grace period can take very little time shorter than the one iteration of on_each_cpu itself。So the complete() can execute on one cpu before the last of all. &nbsp;

And that is the bug.  Very good!

> but now 
> The key is on_each_cpu &nbsp;,it is really clever that on_each_cpu &nbsp;will prevent completion of any grace periods. Concealed Mechanism！
> Is it?
> In this ancient version code have &nbsp;real race-condition bugs .I will take some time to study to find it and reply to you.
> it is about on_each_cpu have not prohibit preemption? ,I did not cover more things related to the operationg system.

Suppose the code instead read as follows?

void rcu_barrier(void)
{
	BUG_ON(in_interrupt());
	/* Take cpucontrol semaphore to protect against CPU hotplug */
	down(&rcu_barrier_sema);
	init_completion(&rcu_barrier_completion);
	atomic_set(&rcu_barrier_cpu_count, 1);
	on_each_cpu(rcu_barrier_func, NULL, 0, 1);
	if (atomic_dec_and_test(&rcu_barrier_cpu_count))
		complete(&rcu_barrier_completion);
	wait_for_completion(&rcu_barrier_completion);
	up(&rcu_barrier_sema);
}

Would that work?  Or are there additional bugs?

							Thanx, Paul

> Chao,Li
> 
>                        
> 原始邮件
>                        
>                      
> 
> 发件人："Paul E. McKenney"< paulmck@kernel.org &gt;;
> 
> 发件时间：2022/10/5 21:01
> 
> 收件人："5486"< 3164135486@qq.com &gt;;
> 
> 抄送人："rcu"< rcu@vger.kernel.org &gt;;
> 
> 主题：Re: Dear Pualmack help i have a problem with rcu code
> 
> 
> On Tue, Oct 04, 2022 at 03:04:19AM +0800, 5486 wrote:
> &gt; Dear&nbsp;Pualmack i have problem.
> &gt; I have been reading the patch
> &gt; https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/kernel?id=ab4720ec76b756e1f8705e207a7b392b0453afd6
> &gt; 
> &gt; 
> &gt; 
> &gt; +	wait_for_completion(&amp;rcu_barrier_completion);
> &gt; 
> &gt; How this guarantees all completes to be done ?
> &gt; I learn one wait_for_completion corresponds to one&nbsp;x-&gt;done++ once a time
> 
> 2005!  That takes me back a bit!
> 
> Adding the rcu email list on CC to archive this and for others to
> weigh in.
> 
> The trick is that rcu_barrier_callback() is an RCU callback that executes
> on each CPU (see the on_each_cpu() in the rcu_barrier() function.)
> 
> This RCU callback function is queued using call_rcu(), which queues
> that callback at the end of the CPU's callback list.  Thus, all
> RCU callback functions that were already queued on that CPU will
> be invoked before rcu_barrier_callback() in invoked.
> 
> The rcu_barrier_callback() does an atomic_dec_and_test() operation on the
> rcu_barrier_cpu_count global variable, and only when this variable becomes
> zero does it invoke complete().  This atomic_dec_and_test() operation is
> fully ordered, and thus ensures that all the earlier atomic_dec_and_test()
> operations on this variable are globally seen to happen before the last
> such operation (the one that decrements rcu_barrier_cpu_count to zero).
> 
> This last rcu_barrier_callback() will then invoke complete().  This will
> ensure that the wakeup in wait_for_completion() happens only after all
> previously queued RCU callbacks are invoked.
> 
> Almost, anyway.
> 
> There are rare but real race-condition bugs in this ancient version
> of rcu_barrier().  Can you tell me what they are?
> 
> 							Thanx, Paul
