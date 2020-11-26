Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E66C56202
	for <rcu@archiver.kernel.org>; Thu, 26 Nov 2020 15:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70C9921D40
	for <rcu@archiver.kernel.org>; Thu, 26 Nov 2020 15:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7kkzcw6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391130AbgKZPqc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 26 Nov 2020 10:46:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:50968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727481AbgKZPqc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 26 Nov 2020 10:46:32 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E297321D1A;
        Thu, 26 Nov 2020 15:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606405591;
        bh=tMFcEUcsugJhclfbAIgWqCPLPAsTFSEY51zdjOIJUlk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=I7kkzcw63pBQbWrwysnZwfmyX3Y5XbhKwnookQG5c97fHnU3XubUUw5S0vb6UGx2g
         xWghVD9OX57oo/9J9IpBjeV0TUobnmYUEEXAwh8Lq7sCEUk+qkOWrHqZs+qKOLIdQ3
         Hvz6k1nbgAfIqkH4U1j++phqGg/GyMYmx1Xs+ESA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 83AF03520A96; Thu, 26 Nov 2020 07:46:30 -0800 (PST)
Date:   Thu, 26 Nov 2020 07:46:30 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: kdump always hangs in rcu_barrier() -> wait_for_completion()
Message-ID: <20201126154630.GR1437@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <SN6PR2101MB1807BDF049D7155201A8178DBFFA1@SN6PR2101MB1807.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR2101MB1807BDF049D7155201A8178DBFFA1@SN6PR2101MB1807.namprd21.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 25, 2020 at 04:56:33AM +0000, Dexuan Cui wrote:
> Hi,
> I happened to hit a kdump hang issue in a Linux VM running on some
> Hyper-V host. Please see the attached log: the kdump kernel always hangs,
> even if I configure only 1 virtual CPU to the VM.
> 
> I firstly hit the issue in RHEL 8.3's 4.18.x kernel, but later I found that 
> the latest upstream v5.10-rc5 also has the same issue (at least the
> symptom is exactly the same), so I dug into v5.10-rc5 and found that the
> kdump kernel always hangs in kernel_init() -> mark_readonly() ->
> rcu_barrier() -> wait_for_completion(&rcu_state.barrier_completion).
> 
> Let's take the 1-vCPU case for example (refer to the attached log): in the
> below code, somehow rcu_segcblist_n_cbs() returns true, so the call
> smp_call_function_single(cpu, rcu_barrier_func, (void *)cpu, 1) increases
> the counter by 1, and hence later the counter is still 1 after the
> atomic_sub_and_test(), and the complete() is not called.
> 
> static void rcu_barrier_func(void *cpu_in)
> {
>         ...
>         if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
>                 atomic_inc(&rcu_state.barrier_cpu_count);
>         } else {
>         ...
> }
> 
> void rcu_barrier(void)
> {
>         ...
>         atomic_set(&rcu_state.barrier_cpu_count, 2);
>         ...
>         for_each_possible_cpu(cpu) {
>                 rdp = per_cpu_ptr(&rcu_data, cpu);
>                 ...
>                 if (rcu_segcblist_n_cbs(&rdp->cblist) && cpu_online(cpu)) {
>                         ...
>                         smp_call_function_single(cpu, rcu_barrier_func, (void *)cpu, 1);
>                         ...
>                 }
>         }
>         ...
>         if (atomic_sub_and_test(2, &rcu_state.barrier_cpu_count))
>                 complete(&rcu_state.barrier_completion);
> 
>         ...
>         wait_for_completion(&rcu_state.barrier_completion);
> 
> Sorry for my ignorance of RCU -- I'm not sure why the rcu_segcblist_n_cbs()
> returns 1 here. In the normal kernel, it returns 0, so the normal kernel does not
> hang.

The rcu_segcblist_n_cbs() function returns non-zero because something
invoked call_rcu() some time previously.  The ftrace facility (or just
a printk) should help you work out where that call_rcu() is located.

> Note: in the case of kdump kernel, if I remove the kernel parameter
> console=ttyS0 OR if I build the kernel with CONFIG_HZ=250, the issue can
> no longer reproduce. Currently my kernel uses CONFIG_HZ=1000 and I use
> console=ttyS0, so I'm able to reproduce the isue every time.
> 
> Note: the same kernel binary can not reproduce the issue when the VM
> runs on another Hyper-V host.
> 
> It looks there is some kind of race condition?

Quite possibly.  Perhaps there is some code somewhere in the kernel that
invokes call_rcu() after some number of jiffies, in which case reducing
CONFIG_HZ would delay that call_rcu() invocation until after this call
to rcu_barrier().  Perhaps that call_rcu() is also associated with the
console=ttyS0, so that it is delayed sufficiently with reduced CONFIG_HZ
and missing entirely without console=ttyS0.

> Looking forward to your insights!
> 
> I'm happy to test any patch or enable more tracing, if necessary. Thanks!

My best guess is that the underlying bug is that you are invoking
rcu_barrier() before the RCU grace-period kthread has been created.
This means that RCU grace periods cannot complete, which in turn means
that if there has been even one invocation of call_rcu() since boot,
rcu_barrier() cannot complete, which is what you are in fact seeing.
Please note that it is perfectly legal to invoke call_rcu() very early in
the boot process, as in even before the call to rcu_init().  Therefore,
if this is the case, the bug is the early call to rcu_barrier(), not
the early calls to call_rcu().

To check this, at the beginning of rcu_barrier(), check the value of
rcu_state.gp_kthread.  If my guess is correct, it will be NULL.

Another possibility is that rcu_state.gp_kthread is non-NULL, but that
something else is preventing RCU grace periods from completing, but in
that case you should see RCU CPU stall warnings.  Unless of course they
have been disabled.

Please let me know what you find!

							Thanx, Paul
