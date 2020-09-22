Return-Path: <SRS0=9ZY9=C7=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D02C2D0E2
	for <rcu@archiver.kernel.org>; Tue, 22 Sep 2020 23:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F71B221F0
	for <rcu@archiver.kernel.org>; Tue, 22 Sep 2020 23:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600817070;
	bh=ww3myNQZZR3QHK5oyvZMyTi/dByPpeDC+MTZ6QuHf78=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=SKMPQX65LNcxqDMhvF0azQqGQ5Enc660ViKbZQMzbGPv6HWZWCO20suxtfSoUFvJM
	 /Dici5byIGXA1bclx6UD2evhxSodGBMoVfnGkefZZSACND2LIgEbiPlOt0aTr7XVMC
	 PCT3OG8b7J73a7KWuDSJWWIR4IjIy692nk81BVVk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgIVXYa (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 22 Sep 2020 19:24:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgIVXY3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 22 Sep 2020 19:24:29 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AB3A221EF;
        Tue, 22 Sep 2020 23:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600817067;
        bh=ww3myNQZZR3QHK5oyvZMyTi/dByPpeDC+MTZ6QuHf78=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ISYDf/M9hlYfZ3ezrb8br7mx/ICu2OTuOU8SlGObl2sPoqK9bgUJ2xVv0xdrqD+xs
         5Yu1+wrVSoSvxTBweTGAvURq4ongAW0MYdV31gUeVwIF922ZPIHDGTedTdtZuLLJDB
         xC0mPZs1SdrEe1XAhZik2FLG3M8m5VacVk0S2nPs=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C3B1F3522CEC; Tue, 22 Sep 2020 16:24:26 -0700 (PDT)
Date:   Tue, 22 Sep 2020 16:24:26 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Hou Tao <houtao1@huawei.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH 2/2] locktorture: call percpu_free_rwsem() to do
 percpu-rwsem cleanup
Message-ID: <20200922232426.GL29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200917135910.137389-1-houtao1@huawei.com>
 <20200917135910.137389-3-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917135910.137389-3-houtao1@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 17, 2020 at 09:59:10PM +0800, Hou Tao wrote:
> When do percpu-rwsem writer lock torture, the RCU callback
> rcu_sync_func() may still be pending after locktorture module
> is removed, and it will lead to the following Oops:
> 
>   BUG: unable to handle page fault for address: ffffffffc00eb920
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 6500a067 P4D 6500a067 PUD 6500c067 PMD 13a36c067 PTE 800000013691c163
>   Oops: 0000 [#1] PREEMPT SMP
>   CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.9.0-rc5+ #4
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
>   RIP: 0010:rcu_cblist_dequeue+0x12/0x30
>   Call Trace:
>    <IRQ>
>    rcu_core+0x1b1/0x860
>    __do_softirq+0xfe/0x326
>    asm_call_on_stack+0x12/0x20
>    </IRQ>
>    do_softirq_own_stack+0x5f/0x80
>    irq_exit_rcu+0xaf/0xc0
>    sysvec_apic_timer_interrupt+0x2e/0xb0
>    asm_sysvec_apic_timer_interrupt+0x12/0x20
> 
> Fix it by adding an exit hook in lock_torture_ops and
> use it to call percpu_free_rwsem() for percpu rwsem torture
> before the module is removed, so we can ensure rcu_sync_func()
> completes before module exits.
> 
> Also needs to call exit hook if lock_torture_init() fails half-way,
> so use ctx->cur_ops != NULL to signal that init hook has been called.

Good catch, but please see below for comments and questions.

> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/locking/locktorture.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> index bebdf98e6cd78..e91033e9b6f95 100644
> --- a/kernel/locking/locktorture.c
> +++ b/kernel/locking/locktorture.c
> @@ -74,6 +74,7 @@ static void lock_torture_cleanup(void);
>   */
>  struct lock_torture_ops {
>  	void (*init)(void);
> +	void (*exit)(void);

This is fine, but why not also add a flag to the lock_torture_cxt
structure that is set when the ->init() function is called?  Perhaps
something like this in lock_torture_init():

	if (cxt.cur_ops->init) {
		cxt.cur_ops->init();
		cxt.initcalled = true;
	}

>  	int (*writelock)(void);
>  	void (*write_delay)(struct torture_random_state *trsp);
>  	void (*task_boost)(struct torture_random_state *trsp);
> @@ -571,6 +572,11 @@ void torture_percpu_rwsem_init(void)
>  	BUG_ON(percpu_init_rwsem(&pcpu_rwsem));
>  }
>  
> +static void torture_percpu_rwsem_exit(void)
> +{
> +	percpu_free_rwsem(&pcpu_rwsem);
> +}
> +
>  static int torture_percpu_rwsem_down_write(void) __acquires(pcpu_rwsem)
>  {
>  	percpu_down_write(&pcpu_rwsem);
> @@ -595,6 +601,7 @@ static void torture_percpu_rwsem_up_read(void) __releases(pcpu_rwsem)
>  
>  static struct lock_torture_ops percpu_rwsem_lock_ops = {
>  	.init		= torture_percpu_rwsem_init,
> +	.exit		= torture_percpu_rwsem_exit,
>  	.writelock	= torture_percpu_rwsem_down_write,
>  	.write_delay	= torture_rwsem_write_delay,
>  	.task_boost     = torture_boost_dummy,
> @@ -786,9 +793,10 @@ static void lock_torture_cleanup(void)
>  
>  	/*
>  	 * Indicates early cleanup, meaning that the test has not run,
> -	 * such as when passing bogus args when loading the module. As
> -	 * such, only perform the underlying torture-specific cleanups,
> -	 * and avoid anything related to locktorture.
> +	 * such as when passing bogus args when loading the module.
> +	 * However cxt->cur_ops.init() may have been invoked, so beside
> +	 * perform the underlying torture-specific cleanups, cur_ops.exit()
> +	 * will be invoked if needed.
>  	 */
>  	if (!cxt.lwsa && !cxt.lrsa)
>  		goto end;
> @@ -828,6 +836,12 @@ static void lock_torture_cleanup(void)
>  	cxt.lrsa = NULL;
>  
>  end:
> +	/* If init() has been called, then do exit() accordingly */
> +	if (cxt.cur_ops) {
> +		if (cxt.cur_ops->exit)
> +			cxt.cur_ops->exit();
> +		cxt.cur_ops = NULL;
> +	}

The above can then be:

	if (cxt.initcalled && cxt.cur_ops->exit)
		cxt.cur_ops->exit();

Maybe you also need to clear cxt.initcalled at this point, but I don't
immediately see why that would be needed.

>  	torture_cleanup_end();
>  }
>  
> @@ -835,6 +849,7 @@ static int __init lock_torture_init(void)
>  {
>  	int i, j;
>  	int firsterr = 0;
> +	struct lock_torture_ops *cur_ops;

And then you don't need this extra pointer.  Not that this pointer is bad
in and of itself, but using (!cxt.cur_ops) to indicate that the ->init()
function has not been called is an accident waiting to happen.

And the changes below are no longer needed.

Or am I missing something subtle?

							Thanx, Paul

>  	static struct lock_torture_ops *torture_ops[] = {
>  		&lock_busted_ops,
>  		&spin_lock_ops, &spin_lock_irq_ops,
> @@ -853,8 +868,8 @@ static int __init lock_torture_init(void)
>  
>  	/* Process args and tell the world that the torturer is on the job. */
>  	for (i = 0; i < ARRAY_SIZE(torture_ops); i++) {
> -		cxt.cur_ops = torture_ops[i];
> -		if (strcmp(torture_type, cxt.cur_ops->name) == 0)
> +		cur_ops = torture_ops[i];
> +		if (strcmp(torture_type, cur_ops->name) == 0)
>  			break;
>  	}
>  	if (i == ARRAY_SIZE(torture_ops)) {
> @@ -869,12 +884,13 @@ static int __init lock_torture_init(void)
>  	}
>  
>  	if (nwriters_stress == 0 &&
> -	    (!cxt.cur_ops->readlock || nreaders_stress == 0)) {
> +	    (!cur_ops->readlock || nreaders_stress == 0)) {
>  		pr_alert("lock-torture: must run at least one locking thread\n");
>  		firsterr = -EINVAL;
>  		goto unwind;
>  	}
>  
> +	cxt.cur_ops = cur_ops;
>  	if (cxt.cur_ops->init)
>  		cxt.cur_ops->init();
>  
> -- 
> 2.25.0.4.g0ad7144999
> 
