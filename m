Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F03C433E0
	for <rcu@archiver.kernel.org>; Wed, 17 Feb 2021 21:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B47264E6C
	for <rcu@archiver.kernel.org>; Wed, 17 Feb 2021 21:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbhBQVYz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 17 Feb 2021 16:24:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:50272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231630AbhBQVYr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 17 Feb 2021 16:24:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE33864E6C;
        Wed, 17 Feb 2021 21:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613597045;
        bh=m2z/x1Zrj0A4fqoRWSZo7Xax9iL04VQAEJ0SYZrLHys=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=COcGE94+mVQ/Mr+h+fiY7w9xxW3RaIR0HS5jqWAyH9hUBE4jRKau7KlRPscLNhfkl
         lO/deqlC8pVqOMRRdSeE5APP9KGoatdQSnpbh3jwSQlZhQxUgQG2Izi8ZlM5fN0NkL
         ommgd3wHYUVTfIVwDYT2mw5yug7IgPC8XuqPlh84vVXWnHzYa2yEttw5bOKJatPZ5J
         o8yeBBYnB67NepUGdEy/blK3j6IgPEInSYTFPL95oPep8oQjkKBs0L9M5jHmpnsFVO
         uBWbhfUZHbEoPAFiOQ0PHn7vtyy8r6wAYt+s7TknlqHn+kmC1Ck3OqAEWxFv1+TNN3
         M0MDnwqAxAtZg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B7A3E3522611; Wed, 17 Feb 2021 13:24:04 -0800 (PST)
Date:   Wed, 17 Feb 2021 13:24:04 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
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
Subject: Re: [PATCH v3 1/1] rcuscale: add kfree_rcu() single-argument scale
 test
Message-ID: <20210217212404.GK2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210217185110.2099-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217185110.2099-1-urezki@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Feb 17, 2021 at 07:51:10PM +0100, Uladzislau Rezki (Sony) wrote:
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
> both are randomly tested, otherwise only the one with value true
> is tested. The value of this is that it allows testing of both
> options with one test.
> 
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Queued with the usual wordsmithing, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/rcuscale.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> index 06491d5530db..0fb540e2b22b 100644
> --- a/kernel/rcu/rcuscale.c
> +++ b/kernel/rcu/rcuscale.c
> @@ -625,6 +625,8 @@ rcu_scale_shutdown(void *arg)
>  torture_param(int, kfree_nthreads, -1, "Number of threads running loops of kfree_rcu().");
>  torture_param(int, kfree_alloc_num, 8000, "Number of allocations and frees done in an iteration.");
>  torture_param(int, kfree_loops, 10, "Number of loops doing kfree_alloc_num allocations and frees.");
> +torture_param(bool, kfree_rcu_test_single, false, "Do we run a kfree_rcu() single-argument scale test?");
> +torture_param(bool, kfree_rcu_test_double, false, "Do we run a kfree_rcu() double-argument scale test?");
>  
>  static struct task_struct **kfree_reader_tasks;
>  static int kfree_nrealthreads;
> @@ -644,10 +646,13 @@ kfree_scale_thread(void *arg)
>  	struct kfree_obj *alloc_ptr;
>  	u64 start_time, end_time;
>  	long long mem_begin, mem_during = 0;
> +	bool kfree_rcu_test_both;
> +	DEFINE_TORTURE_RANDOM(tr);
>  
>  	VERBOSE_SCALEOUT_STRING("kfree_scale_thread task started");
>  	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
>  	set_user_nice(current, MAX_NICE);
> +	kfree_rcu_test_both = (kfree_rcu_test_single == kfree_rcu_test_double);
>  
>  	start_time = ktime_get_mono_fast_ns();
>  
> @@ -670,7 +675,15 @@ kfree_scale_thread(void *arg)
>  			if (!alloc_ptr)
>  				return -ENOMEM;
>  
> -			kfree_rcu(alloc_ptr, rh);
> +			// By default kfree_rcu_test_single and kfree_rcu_test_double are
> +			// initialized to false. If both have the same value (false or true)
> +			// both are randomly tested, otherwise only the one with value true
> +			// is tested.
> +			if ((kfree_rcu_test_single && !kfree_rcu_test_double) ||
> +					(kfree_rcu_test_both && torture_random(&tr) & 0x800))
> +				kfree_rcu(alloc_ptr);
> +			else
> +				kfree_rcu(alloc_ptr, rh);
>  		}
>  
>  		cond_resched();
> -- 
> 2.20.1
> 
