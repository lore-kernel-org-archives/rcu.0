Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08201C63777
	for <rcu@archiver.kernel.org>; Thu, 26 Nov 2020 21:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9495920872
	for <rcu@archiver.kernel.org>; Thu, 26 Nov 2020 21:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7vIXpop"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387493AbgKZVm1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 26 Nov 2020 16:42:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:58760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgKZVm1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 26 Nov 2020 16:42:27 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A66320872;
        Thu, 26 Nov 2020 21:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606426946;
        bh=Hy1ZQK9dRMU3ToqMmxOyHjgGadc+D2Wc65UGFap7/Kg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=l7vIXpopAMloE7428TO49IBDwok55u7vtDQbfzUgssbE87lVSbVZREo5mAlTASoT7
         eLR8K1pM4HUuzl3RsLIqiJdFfXVN4GJcj/PyWeoS98u5hfc787uEnGZU6/sLQbtXn0
         Q6RJYt+ISJdmlOAYmGtVJWJ6gevxkaVL2f1YEdq0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 367243522FFC; Thu, 26 Nov 2020 13:42:26 -0800 (PST)
Date:   Thu, 26 Nov 2020 13:42:26 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: kdump always hangs in rcu_barrier() -> wait_for_completion()
Message-ID: <20201126214226.GS1437@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <SN6PR2101MB1807BDF049D7155201A8178DBFFA1@SN6PR2101MB1807.namprd21.prod.outlook.com>
 <20201126154630.GR1437@paulmck-ThinkPad-P72>
 <MW2PR2101MB18014505C01027A9486D45EEBFF91@MW2PR2101MB1801.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW2PR2101MB18014505C01027A9486D45EEBFF91@MW2PR2101MB1801.namprd21.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Nov 26, 2020 at 09:25:28PM +0000, Dexuan Cui wrote:
> > From: Paul E. McKenney <paulmck@kernel.org>
> > Sent: Thursday, November 26, 2020 7:47 AM
> >  ...
> > The rcu_segcblist_n_cbs() function returns non-zero because something
> > invoked call_rcu() some time previously.  The ftrace facility (or just
> > a printk) should help you work out where that call_rcu() is located.
> 
> call_rcu() is indeed called multiple times, but as you said, this should
> be normal.

Good to know, thank you!

> > My best guess is that the underlying bug is that you are invoking
> > rcu_barrier() before the RCU grace-period kthread has been created.
> > This means that RCU grace periods cannot complete, which in turn means
> > that if there has been even one invocation of call_rcu() since boot,
> > rcu_barrier() cannot complete, which is what you are in fact seeing.
> > Please note that it is perfectly legal to invoke call_rcu() very early in
> > the boot process, as in even before the call to rcu_init().  Therefore,
> > if this is the case, the bug is the early call to rcu_barrier(), not
> > the early calls to call_rcu().
> >
> > To check this, at the beginning of rcu_barrier(), check the value of
> > rcu_state.gp_kthread.  If my guess is correct, it will be NULL.
> 
> Unluckily, it's not NULL here. :-)

You can't have everything!  ;-)

> > Another possibility is that rcu_state.gp_kthread is non-NULL, but that
> > something else is preventing RCU grace periods from completing, but in
> 
> It looks like somehow the scheduling is not working here: in rcu_barrier()
> , if I replace the wait_for_completion() with
> wait_for_completion_timeout(&rcu_state.barrier_completion, 30*HZ), the
> issue persists.

Have you tried using sysreq-t to see what the various tasks are doing?

One way that this can happen is if whatever task is currently running
has managed to enter long loop with interrupts disabled.

> > that case you should see RCU CPU stall warnings.  Unless of course they
> > have been disabled.
> > 							Thanx, Paul
> 
> I guess I didn't disable the wanrings (I don't even know how to do that :)

Having interrupts disabled on all CPUs would have the effect of disabling
the RCU CPU stall warnings.

The intended method is in Documentation/admin-guide/kernel-parameters.txt.
Search for rcu_cpu_stall_suppress.  Not that it seems important at this
point.

							Thanx, Paul

> grep RCU .config
> # RCU Subsystem
> CONFIG_TREE_RCU=y
> # CONFIG_RCU_EXPERT is not set
> CONFIG_SRCU=y
> CONFIG_TREE_SRCU=y
> CONFIG_TASKS_RCU_GENERIC=y
> CONFIG_TASKS_RUDE_RCU=y
> CONFIG_TASKS_TRACE_RCU=y
> CONFIG_RCU_STALL_COMMON=y
> CONFIG_RCU_NEED_SEGCBLIST=y
> CONFIG_RCU_NOCB_CPU=y
> # end of RCU Subsystem
> CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
> # RCU Debugging
> # CONFIG_RCU_SCALE_TEST is not set
> # CONFIG_RCU_TORTURE_TEST is not set
> # CONFIG_RCU_REF_SCALE_TEST is not set
> CONFIG_RCU_CPU_STALL_TIMEOUT=30
> CONFIG_RCU_TRACE=y
> CONFIG_RCU_EQS_DEBUG=y
> # end of RCU Debugging
> 
> Thanks,
> -- Dexuan
> 
