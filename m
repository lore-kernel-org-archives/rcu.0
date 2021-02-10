Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0267C433E0
	for <rcu@archiver.kernel.org>; Wed, 10 Feb 2021 01:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0D86601FF
	for <rcu@archiver.kernel.org>; Wed, 10 Feb 2021 01:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhBJBDs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 9 Feb 2021 20:03:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:45280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234925AbhBJBBe (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 9 Feb 2021 20:01:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E852664DD1;
        Wed, 10 Feb 2021 01:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612918853;
        bh=K/elv7DhX3bRsav/YirM2iHEqkRBlokAyCQh0C7pFAw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IoWAeBLRDtaC/SMsbv2i+Ql8knfpEFT6A/MxDa6jJmNg3UUeKfubVfHqCrUk4I6WH
         uIbNJ++yT6/zgTjEG3LWeuPf/nTZZlTduAGRIOIAZJQibaQbOiffxx9GRAksBpdycc
         UOV8K9f+rLqGGNtM+P6mucDC4PFStrNBlR560pdtjVTNUBVW3NcJWZdV2JGPdfr6GK
         N38mBWE6J/UEfZTBomDwCUG2mapcjI3+1vnfNx/6M9o+7dMsP0HVGNm7q0u7mV5H1P
         CDudTkdEkcfgRkyrnagGdCPSZWwcUGW8qB2sJyB+4v+Rk4RNP0CwQ9TQAdOVF2nHK7
         0S6d3o1pUZc/A==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8BA233522585; Tue,  9 Feb 2021 17:00:52 -0800 (PST)
Date:   Tue, 9 Feb 2021 17:00:52 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/2] rcuscale: add kfree_rcu() single-argument scale test
Message-ID: <20210210010052.GZ2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210129200505.5273-1-urezki@gmail.com>
 <20210204214648.GL2743@paulmck-ThinkPad-P72>
 <20210209201343.GA15619@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209201343.GA15619@pc638.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Feb 09, 2021 at 09:13:43PM +0100, Uladzislau Rezki wrote:
> On Thu, Feb 04, 2021 at 01:46:48PM -0800, Paul E. McKenney wrote:
> > On Fri, Jan 29, 2021 at 09:05:04PM +0100, Uladzislau Rezki (Sony) wrote:
> > > To stress and test a single argument of kfree_rcu() call, we
> > > should to have a special coverage for it. We used to have it
> > > in the test-suite related to vmalloc stressing. The reason is
> > > the rcuscale is a correct place for RCU related things.
> > > 
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > 
> > This is a great addition, but it would be even better if there was
> > a way to say "test both in one run".  One way to do this is to have
> > torture_param() variables for both kfree_rcu_test_single and (say)
> > kfree_rcu_test_double, both bool and both initialized to false.  If both
> > have the same value (false or true) both are tested, otherwise only
> > the one with value true is tested.  The value of this is that it allows
> > testing of both options with one test.
> > 
> Make sense to me :)
> 
> >From ba083a543a123455455c81230b7b5a9aa2a9cb7f Mon Sep 17 00:00:00 2001
> From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> Date: Fri, 29 Jan 2021 19:51:27 +0100
> Subject: [PATCH v2 1/1] rcuscale: add kfree_rcu() single-argument scale test
> 
> To stress and test a single argument of kfree_rcu() call, we
> should to have a special coverage for it. We used to have it
> in the test-suite related to vmalloc stressing. The reason is
> the rcuscale is a correct place for RCU related things.
> 
> Therefore introduce two torture_param() variables, one is for
> single-argument scale test and another one for double-argument
> scale test.
> 
> By default kfree_rcu_test_single and kfree_rcu_test_double are
> initialized to false. If both have the same value (false or true)
> both are tested in one run, otherwise only the one with value
> true is tested. The value of this is that it allows testing of
> both options with one test.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  kernel/rcu/rcuscale.c | 33 ++++++++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> index 06491d5530db..0cde5c17f06c 100644
> --- a/kernel/rcu/rcuscale.c
> +++ b/kernel/rcu/rcuscale.c
> @@ -625,6 +625,8 @@ rcu_scale_shutdown(void *arg)
>  torture_param(int, kfree_nthreads, -1, "Number of threads running loops of kfree_rcu().");
>  torture_param(int, kfree_alloc_num, 8000, "Number of allocations and frees done in an iteration.");
>  torture_param(int, kfree_loops, 10, "Number of loops doing kfree_alloc_num allocations and frees.");
> +torture_param(int, kfree_rcu_test_single, 0, "Do we run a kfree_rcu() single-argument scale test?");
> +torture_param(int, kfree_rcu_test_double, 0, "Do we run a kfree_rcu() double-argument scale test?");

Good!  But why int instead of bool?

>  static struct task_struct **kfree_reader_tasks;
>  static int kfree_nrealthreads;
> @@ -641,7 +643,7 @@ kfree_scale_thread(void *arg)
>  {
>  	int i, loop = 0;
>  	long me = (long)arg;
> -	struct kfree_obj *alloc_ptr;
> +	struct kfree_obj *alloc_ptr[2];

You lost me on this one...

>  	u64 start_time, end_time;
>  	long long mem_begin, mem_during = 0;
>  
> @@ -665,12 +667,33 @@ kfree_scale_thread(void *arg)
>  			mem_during = (mem_during + si_mem_available()) / 2;
>  		}
>  
> +		// By default kfree_rcu_test_single and kfree_rcu_test_double are
> +		// initialized to false. If both have the same value (false or true)
> +		// both are tested in one run, otherwise only the one with value
> +		// true is tested.
>  		for (i = 0; i < kfree_alloc_num; i++) {
> -			alloc_ptr = kmalloc(kfree_mult * sizeof(struct kfree_obj), GFP_KERNEL);
> -			if (!alloc_ptr)
> -				return -ENOMEM;
> +			alloc_ptr[0] = kmalloc(kfree_mult * sizeof(struct kfree_obj), GFP_KERNEL);
> +			alloc_ptr[1] = (kfree_rcu_test_single == kfree_rcu_test_double) ?
> +				kmalloc(kfree_mult * sizeof(struct kfree_obj), GFP_KERNEL) : NULL;
> +
> +			// 0 ptr. is freed either over single or double argument.
> +			if (alloc_ptr[0]) {
> +				if (kfree_rcu_test_single == kfree_rcu_test_double ||
> +						kfree_rcu_test_single) {
> +					kfree_rcu(alloc_ptr[0]);
> +				} else {
> +					kfree_rcu(alloc_ptr[0], rh);
> +				}
> +			}
> +
> +			// 1 ptr. is always freed over double argument.
> +			if (alloc_ptr[1])
> +				kfree_rcu(alloc_ptr[1], rh);
>  
> -			kfree_rcu(alloc_ptr, rh);
> +			if (!alloc_ptr[0] ||
> +					(kfree_rcu_test_single == kfree_rcu_test_double &&
> +						!alloc_ptr[1]))
> +				return -ENOMEM;

How about something like this?

	bool krts = kfree_rcu_test_single || kfree_rcu_test_single == kfree_rcu_test_double;
	bool krtd = kfree_rcu_test_double || kfree_rcu_test_single == kfree_rcu_test_double;
	bool krtb = kfree_rcu_test_single && kfree_rcu_test_double;
	DEFINE_TORTURE_RANDOM(tr);

	...

			alloc_ptr = kmalloc(kfree_mult * sizeof(struct kfree_obj), GFP_KERNEL);
			if (!alloc_ptr)
				return -ENOMEM;
			if (krtd || (krtb && (torture_random(&tr) & 0x800)))
				kfree_rcu(alloc_ptr, rh);
			else
				kfree_rcu(alloc_ptr);

>  		}
>  
>  		cond_resched();

And this is why I was so confused about the earlier OOMs.  We need
something stronger, and not here, but rather inside the above loop.
The function rcu_torture_fwd_prog_cond_resched() does what is needed,
which needs to be moved to kernel/torture.c or to be a static inline in
include/linux/torture.h so that it can be invoked here.

The flooding we are looking to emulate has to have frequent trips into
userspace, and rcu_torture_fwd_prog_cond_resched() is the way that we
emulate those trips.

But please make this change be a separate patch.

							Thanx, Paul
