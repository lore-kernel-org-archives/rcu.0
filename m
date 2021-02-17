Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD462C433DB
	for <rcu@archiver.kernel.org>; Wed, 17 Feb 2021 17:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CBE064DF3
	for <rcu@archiver.kernel.org>; Wed, 17 Feb 2021 17:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbhBQRsR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 17 Feb 2021 12:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbhBQRsQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 17 Feb 2021 12:48:16 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD420C061756;
        Wed, 17 Feb 2021 09:47:35 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id w36so23043080lfu.4;
        Wed, 17 Feb 2021 09:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/wwUw8iZ+brDJH5K5W8fBtfI5NnI8b3Q+hwCExh1eK8=;
        b=JLkBCgK6wZ68vUAeey1R/xIIW6+Fcp4Imv+Wb2rNwlAqA+MH6LE2SKDALVx0KFx//1
         T2BbKER5p8fFkxtvBPmOiGF1aI1yR4HxS+flk7a7nmsw8l/zPXVdpkfhNwMR6+Q9NLh3
         fNhr7CnpOnffnK3rMIrg+qhzeB5NQzt+lKYvGHZiP1KND2RaV757wvpsJZiXHz8r+bUi
         trYn+Zz9u3pI/V+1R6J9Ez/JsAjv/CW8NP3jVOXLB893Tj80Ks4DDxoboS/xItN6Ua5T
         hOxeY+3Wq8b00c/d2SvQhpaM1Z5lLsTZ0C03oW6A+boJ4iArUSZ1imyrlwhEJuWISivz
         Rsog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/wwUw8iZ+brDJH5K5W8fBtfI5NnI8b3Q+hwCExh1eK8=;
        b=LdEfbz+0YW1H0F3EJqqq83jPRGISL+rjGKPUZPw4YYuWG7oDgrvXh4yqw7qBPNqOkF
         rPbJ6vTAciwVpfs5cUNxanqvDUrMqHMDjvNStBCIMGzVmA78gD/l1P3LqFgws70DN+XT
         rhq2MR89f/qsR+q1degRAOhe67ZERnkOb0onUP4P4UTsEcvldx9lZ1fR/8l8JPKwsX7P
         LQb19+zlf3tgyKIDwnaKLOWPLCPNs3Vb4OGlLyecok9LtKjQLavIZiGzPVcISfOb46kh
         LRR0rq2jRyPs+XEUBm/1eFnfnuxZLoHjaTD1i50j3xKt4OUhGCKd3X4ND+iRFtlT1cUZ
         hJeQ==
X-Gm-Message-State: AOAM532+u97d3vs5p+G6OvQrb51M7OgdsnfRphwINykrKGm5Z79c66Bl
        5HWsicIS2QFnYTAmVEozkA4=
X-Google-Smtp-Source: ABdhPJxnW5Ota9OGTxF7vwCtE70jG5mFyd1v10LPUhgQqUgdeRb9kMZM4+HW1k2Do0EDIwYYr0a2Ag==
X-Received: by 2002:a05:6512:22c9:: with SMTP id g9mr33587lfu.325.1613584054251;
        Wed, 17 Feb 2021 09:47:34 -0800 (PST)
Received: from pc636 (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id k30sm314777lfo.166.2021.02.17.09.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 09:47:33 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 17 Feb 2021 18:47:31 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
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
Message-ID: <20210217174731.GA5126@pc636>
References: <20210129200505.5273-1-urezki@gmail.com>
 <20210204214648.GL2743@paulmck-ThinkPad-P72>
 <20210209201343.GA15619@pc638.lan>
 <20210210010052.GZ2743@paulmck-ThinkPad-P72>
 <20210215162705.GA45713@pc638.lan>
 <20210216173502.GY2743@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210216173502.GY2743@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Feb 16, 2021 at 09:35:02AM -0800, Paul E. McKenney wrote:
> On Mon, Feb 15, 2021 at 05:27:05PM +0100, Uladzislau Rezki wrote:
> > On Tue, Feb 09, 2021 at 05:00:52PM -0800, Paul E. McKenney wrote:
> > > On Tue, Feb 09, 2021 at 09:13:43PM +0100, Uladzislau Rezki wrote:
> > > > On Thu, Feb 04, 2021 at 01:46:48PM -0800, Paul E. McKenney wrote:
> > > > > On Fri, Jan 29, 2021 at 09:05:04PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > > > To stress and test a single argument of kfree_rcu() call, we
> > > > > > should to have a special coverage for it. We used to have it
> > > > > > in the test-suite related to vmalloc stressing. The reason is
> > > > > > the rcuscale is a correct place for RCU related things.
> > > > > > 
> > > > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > 
> > > > > This is a great addition, but it would be even better if there was
> > > > > a way to say "test both in one run".  One way to do this is to have
> > > > > torture_param() variables for both kfree_rcu_test_single and (say)
> > > > > kfree_rcu_test_double, both bool and both initialized to false.  If both
> > > > > have the same value (false or true) both are tested, otherwise only
> > > > > the one with value true is tested.  The value of this is that it allows
> > > > > testing of both options with one test.
> > > > > 
> > > > Make sense to me :)
> > > > 
> > > > >From ba083a543a123455455c81230b7b5a9aa2a9cb7f Mon Sep 17 00:00:00 2001
> > > > From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> > > > Date: Fri, 29 Jan 2021 19:51:27 +0100
> > > > Subject: [PATCH v2 1/1] rcuscale: add kfree_rcu() single-argument scale test
> > > > 
> > > > To stress and test a single argument of kfree_rcu() call, we
> > > > should to have a special coverage for it. We used to have it
> > > > in the test-suite related to vmalloc stressing. The reason is
> > > > the rcuscale is a correct place for RCU related things.
> > > > 
> > > > Therefore introduce two torture_param() variables, one is for
> > > > single-argument scale test and another one for double-argument
> > > > scale test.
> > > > 
> > > > By default kfree_rcu_test_single and kfree_rcu_test_double are
> > > > initialized to false. If both have the same value (false or true)
> > > > both are tested in one run, otherwise only the one with value
> > > > true is tested. The value of this is that it allows testing of
> > > > both options with one test.
> > > > 
> > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > ---
> > > >  kernel/rcu/rcuscale.c | 33 ++++++++++++++++++++++++++++-----
> > > >  1 file changed, 28 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> > > > index 06491d5530db..0cde5c17f06c 100644
> > > > --- a/kernel/rcu/rcuscale.c
> > > > +++ b/kernel/rcu/rcuscale.c
> > > > @@ -625,6 +625,8 @@ rcu_scale_shutdown(void *arg)
> > > >  torture_param(int, kfree_nthreads, -1, "Number of threads running loops of kfree_rcu().");
> > > >  torture_param(int, kfree_alloc_num, 8000, "Number of allocations and frees done in an iteration.");
> > > >  torture_param(int, kfree_loops, 10, "Number of loops doing kfree_alloc_num allocations and frees.");
> > > > +torture_param(int, kfree_rcu_test_single, 0, "Do we run a kfree_rcu() single-argument scale test?");
> > > > +torture_param(int, kfree_rcu_test_double, 0, "Do we run a kfree_rcu() double-argument scale test?");
> > > 
> > > Good!  But why int instead of bool?
> > > 
> > > >  static struct task_struct **kfree_reader_tasks;
> > > >  static int kfree_nrealthreads;
> > > > @@ -641,7 +643,7 @@ kfree_scale_thread(void *arg)
> > > >  {
> > > >  	int i, loop = 0;
> > > >  	long me = (long)arg;
> > > > -	struct kfree_obj *alloc_ptr;
> > > > +	struct kfree_obj *alloc_ptr[2];
> > > 
> > > You lost me on this one...
> > > 
> > > >  	u64 start_time, end_time;
> > > >  	long long mem_begin, mem_during = 0;
> > > >  
> > > > @@ -665,12 +667,33 @@ kfree_scale_thread(void *arg)
> > > >  			mem_during = (mem_during + si_mem_available()) / 2;
> > > >  		}
> > > >  
> > > > +		// By default kfree_rcu_test_single and kfree_rcu_test_double are
> > > > +		// initialized to false. If both have the same value (false or true)
> > > > +		// both are tested in one run, otherwise only the one with value
> > > > +		// true is tested.
> > > >  		for (i = 0; i < kfree_alloc_num; i++) {
> > > > -			alloc_ptr = kmalloc(kfree_mult * sizeof(struct kfree_obj), GFP_KERNEL);
> > > > -			if (!alloc_ptr)
> > > > -				return -ENOMEM;
> > > > +			alloc_ptr[0] = kmalloc(kfree_mult * sizeof(struct kfree_obj), GFP_KERNEL);
> > > > +			alloc_ptr[1] = (kfree_rcu_test_single == kfree_rcu_test_double) ?
> > > > +				kmalloc(kfree_mult * sizeof(struct kfree_obj), GFP_KERNEL) : NULL;
> > > > +
> > > > +			// 0 ptr. is freed either over single or double argument.
> > > > +			if (alloc_ptr[0]) {
> > > > +				if (kfree_rcu_test_single == kfree_rcu_test_double ||
> > > > +						kfree_rcu_test_single) {
> > > > +					kfree_rcu(alloc_ptr[0]);
> > > > +				} else {
> > > > +					kfree_rcu(alloc_ptr[0], rh);
> > > > +				}
> > > > +			}
> > > > +
> > > > +			// 1 ptr. is always freed over double argument.
> > > > +			if (alloc_ptr[1])
> > > > +				kfree_rcu(alloc_ptr[1], rh);
> > > >  
> > > > -			kfree_rcu(alloc_ptr, rh);
> > > > +			if (!alloc_ptr[0] ||
> > > > +					(kfree_rcu_test_single == kfree_rcu_test_double &&
> > > > +						!alloc_ptr[1]))
> > > > +				return -ENOMEM;
> > > 
> > > How about something like this?
> > > 
> > > 	bool krts = kfree_rcu_test_single || kfree_rcu_test_single == kfree_rcu_test_double;
> > > 	bool krtd = kfree_rcu_test_double || kfree_rcu_test_single == kfree_rcu_test_double;
> > > 	bool krtb = kfree_rcu_test_single && kfree_rcu_test_double;
> > > 	DEFINE_TORTURE_RANDOM(tr);
> > > 
> > > 	...
> > > 
> > > 			alloc_ptr = kmalloc(kfree_mult * sizeof(struct kfree_obj), GFP_KERNEL);
> > > 			if (!alloc_ptr)
> > > 				return -ENOMEM;
> > > 			if (krtd || (krtb && (torture_random(&tr) & 0x800)))
> > > 				kfree_rcu(alloc_ptr, rh);
> > > 			else
> > > 				kfree_rcu(alloc_ptr);
> > > 
> > > >  		}
> > > >  
> > > >  		cond_resched();
> > >
> > Sorry for my late answer. I got it differently as we discussed offline.
> > Please see below the v3. Hope we are on the same page now :)
> 
> This does look good to me!  Could you please send it as an email
> containing only the patch, just to make it official?  And to catch the
> attention of anyone who might have tuned out of this email thread.  ;-)
> 
I will send out as a fresh patch :)

--
Vlad Rezki
