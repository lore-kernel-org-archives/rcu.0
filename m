Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E408C11F64
	for <rcu@archiver.kernel.org>; Thu,  1 Jul 2021 16:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE24161413
	for <rcu@archiver.kernel.org>; Thu,  1 Jul 2021 16:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhGAQdq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Jul 2021 12:33:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230125AbhGAQdp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Jul 2021 12:33:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B312613EF;
        Thu,  1 Jul 2021 16:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625157075;
        bh=8mP9sfoc1/ETuq+n2l6rWeC+cQQkPSrq9Nt9mwZGBkM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HkFiMZt/uasyL3XcwsaGXC+75sCk9/8sredgMs08HiPRioBzi+7W4Y7dbfNUqeslQ
         i3M0Ax/5HeUZ7MRkpT6xlW+tuhrXmlm2shRf/D2WWWEofX5ROgTndY7Z8AS27Ku4mU
         piXs1N8sfLi60WoX7CgFH84evdDB5KXI7qidAIKl3/E2AvnEEDBGDwC+vw5Wpiecuy
         ea2moP0sM650HMIwhxCoTHq4Nn7IgMDLUr5nR8wHDW5bzGFzzrP8ogi5oVoPfHBVLd
         mvXOjimZVkVJ0MWc8XUoaR55rMl4+3s325+D5y3NeYTILRzvphzJxhoPmh5BZmBvQ3
         ABny0DwTtxBsQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 13D8D5C09AE; Thu,  1 Jul 2021 09:31:15 -0700 (PDT)
Date:   Thu, 1 Jul 2021 09:31:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     Liu Song <fishland@aliyun.com>, liu.song11@zte.com.cn,
        rcu@vger.kernel.org
Subject: Re: [PATCH] rcu: Use per_cpu_ptr to get the pointer of per_cpu
 variable
Message-ID: <20210701163115.GE4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210630140802.39138-1-fishland@aliyun.com>
 <85a49682-a196-65e5-b0a4-52f51b76626c@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85a49682-a196-65e5-b0a4-52f51b76626c@codeaurora.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 01, 2021 at 08:24:32PM +0530, Neeraj Upadhyay wrote:
> 
> 
> On 6/30/2021 7:38 PM, Liu Song wrote:
> > From: Liu Song <liu.song11@zte.com.cn>
> > 
> > In rcu, most codes have used per_cpu_ptr to obtain per_cpu variable
> > pointers. This patch adjusts a few codes that have not done so.
> > 
> 
> Minor: Can we also add below statement?
> "This patch doesn't introduce any functional change."
> 
> > Signed-off-by: Liu Song <liu.song11@zte.com.cn>

Applied with the usual wordsmithing, including adding words to this
effect, so thank you all!  I removed the obsolete chunk that Neeraj
pointed out as well.

Please take a look and check to see if all is well.

							Thanx, Paul

------------------------------------------------------------------------

commit 9a6b5a10785f4d9b4f073736e6648fa3851882bd
Author: Liu Song <liu.song11@zte.com.cn>
Date:   Wed Jun 30 22:08:02 2021 +0800

    rcu: Use per_cpu_ptr to get the pointer of per_cpu variable
    
    There are a few remaining locations in kernel/rcu that still use
    "&per_cpu()".  This commit replaces them with "per_cpu_ptr(&)", and does
    not introduce any functional change..
    
    Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
    Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>
    Signed-off-by: Liu Song <liu.song11@zte.com.cn>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index f9f52daacd1c..806160c44b17 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -923,7 +923,7 @@ static void trc_read_check_handler(void *t_in)
 	// Allow future IPIs to be sent on CPU and for task.
 	// Also order this IPI handler against any later manipulations of
 	// the intended task.
-	smp_store_release(&per_cpu(trc_ipi_to_cpu, smp_processor_id()), false); // ^^^
+	smp_store_release(per_cpu_ptr(&trc_ipi_to_cpu, smp_processor_id()), false); // ^^^
 	smp_store_release(&texp->trc_ipi_to_cpu, -1); // ^^^
 }
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a627a200a5ae..f42b98af3ed3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1290,7 +1290,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	 */
 	jtsq = READ_ONCE(jiffies_to_sched_qs);
 	ruqp = per_cpu_ptr(&rcu_data.rcu_urgent_qs, rdp->cpu);
-	rnhqp = &per_cpu(rcu_data.rcu_need_heavy_qs, rdp->cpu);
+	rnhqp = per_cpu_ptr(&rcu_data.rcu_need_heavy_qs, rdp->cpu);
 	if (!READ_ONCE(*rnhqp) &&
 	    (time_after(jiffies, rcu_state.gp_start + jtsq * 2) ||
 	     time_after(jiffies, rcu_state.jiffies_resched) ||
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index a8d0fcf0826f..677ee3d8671b 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -351,7 +351,7 @@ static void rcu_dump_cpu_stacks(void)
 
 static void print_cpu_stall_fast_no_hz(char *cp, int cpu)
 {
-	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 
 	sprintf(cp, "last_accelerate: %04lx/%04lx dyntick_enabled: %d",
 		rdp->last_accelerate & 0xffff, jiffies & 0xffff,
