Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6B1C433E0
	for <rcu@archiver.kernel.org>; Thu,  4 Feb 2021 21:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DAFD64E7B
	for <rcu@archiver.kernel.org>; Thu,  4 Feb 2021 21:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhBDVtN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 4 Feb 2021 16:49:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:50244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230380AbhBDVr3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 4 Feb 2021 16:47:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12D4D64F8C;
        Thu,  4 Feb 2021 21:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612475209;
        bh=SBBN0EsctZYkzPy2hiXWJir3lTd8QZohp23sNGUKEjQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Jb1blzZCHPuhqarWcRTAAmXfNb3gD2CqG3jmDVVgXmXyj4S/QGq4mJJTtBfC3RN45
         CuBP4b07mVWLT5FUvuYTFrWZe//nsxbeVia7dNlt7ABVBhsdXiWDH2lRT4/UGzxyo/
         MSvGpKuNZwZPCkSg0Ckmixv5MFtKvKMk7LmhZm1LgTfky/lLzAqu6/LDIU7SOp/Lyd
         fcNRRZsuV0VCCU9ONMvjR/2SjvgxKBKwIHE84k8j7kwe3d2P/ZVg47FYdpsp28Ax+s
         tJ7+HIhgDhQGK/oLSXcOag//iHXjVTMoJvSta34sM12lhpL94hcLQNSkV8AAlJC7WN
         4eQRLRgFg2F6Q==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 982AA3522F5F; Thu,  4 Feb 2021 13:46:48 -0800 (PST)
Date:   Thu, 4 Feb 2021 13:46:48 -0800
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
Subject: Re: [PATCH 1/2] rcuscale: add kfree_rcu() single-argument scale test
Message-ID: <20210204214648.GL2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210129200505.5273-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129200505.5273-1-urezki@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jan 29, 2021 at 09:05:04PM +0100, Uladzislau Rezki (Sony) wrote:
> To stress and test a single argument of kfree_rcu() call, we
> should to have a special coverage for it. We used to have it
> in the test-suite related to vmalloc stressing. The reason is
> the rcuscale is a correct place for RCU related things.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

This is a great addition, but it would be even better if there was
a way to say "test both in one run".  One way to do this is to have
torture_param() variables for both kfree_rcu_test_single and (say)
kfree_rcu_test_double, both bool and both initialized to false.  If both
have the same value (false or true) both are tested, otherwise only
the one with value true is tested.  The value of this is that it allows
testing of both options with one test.

See the gp_cond, gp_exp, gp_normal, gp_poll, and gp_sync torture_param()
variables in kernel/rcu/rcutorture.c and how they are handled in
rcu_torture_write_types() for one way to do this.

If you wanted to vary the intensity of the testing (but I don't see why
this would be useful), the various weight_* torture_param() variables
are dealt with by kernel/scftorture.c in scf_torture_init().

Thoughts?

							Thanx, Paul

> ---
>  kernel/rcu/rcuscale.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> index 06491d5530db..e17745a155f9 100644
> --- a/kernel/rcu/rcuscale.c
> +++ b/kernel/rcu/rcuscale.c
> @@ -94,6 +94,7 @@ torture_param(bool, shutdown, RCUSCALE_SHUTDOWN,
>  torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
>  torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable");
>  torture_param(int, kfree_rcu_test, 0, "Do we run a kfree_rcu() scale test?");
> +torture_param(int, kfree_rcu_test_single, 0, "Do we run a kfree_rcu() single-argument scale test?");
>  torture_param(int, kfree_mult, 1, "Multiple of kfree_obj size to allocate.");
>  
>  static char *scale_type = "rcu";
> @@ -667,10 +668,14 @@ kfree_scale_thread(void *arg)
>  
>  		for (i = 0; i < kfree_alloc_num; i++) {
>  			alloc_ptr = kmalloc(kfree_mult * sizeof(struct kfree_obj), GFP_KERNEL);
> +
>  			if (!alloc_ptr)
>  				return -ENOMEM;
>  
> -			kfree_rcu(alloc_ptr, rh);
> +			if (kfree_rcu_test_single)
> +				kfree_rcu(alloc_ptr);
> +			else
> +				kfree_rcu(alloc_ptr, rh);
>  		}
>  
>  		cond_resched();
> -- 
> 2.20.1
> 
