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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A65C433E6
	for <rcu@archiver.kernel.org>; Mon, 21 Dec 2020 18:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B43522ADC
	for <rcu@archiver.kernel.org>; Mon, 21 Dec 2020 18:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgLUSt5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbgLUSt5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 21 Dec 2020 13:49:57 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA50C0613D3;
        Mon, 21 Dec 2020 10:49:16 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id a12so26122006lfl.6;
        Mon, 21 Dec 2020 10:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F2t+A6qu5O/ftcIcNCxbUDss9pwC6Y6gAl6Ea/8MQSI=;
        b=IrWp1WrMJ/OWeHdJYdJFjoJiQm4NKhdCHN4idcNqTkPQEPTc4UzRYTIAqSt+x35so8
         7Y1E9oQ/jL60iBOJkWvK7ojOkDvIPE6pK01jZKDczHNSc0pj1MrvILgFgYA64YSUm5xE
         GRgiSxqb+fzVxx0v+2N3OXZHFbR+2lwVPDcz/47q9gnXYRoJJvhsFAg3S4TmcNIJQ6EG
         84vie7Ek4n43Jm2zAnKp9KS7lYWJUyM9LSA7e9g16nyZhoC6ZShWGAcX1FW7Z6t/KTyV
         fymGpbU2zyYCTHLLBSzkMiezWMqy++uA0cjSoj8qkZ0BduQFBSk70kjJxl23plbwwixO
         /hpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F2t+A6qu5O/ftcIcNCxbUDss9pwC6Y6gAl6Ea/8MQSI=;
        b=q2cWnly68qvVrrSLbG/Wm1lMSUikCl8AVDCgUB3UwEcNMAcR0d4vBDlKymXQ6RP3Zv
         C5NZyoW+eMj4cl1vgwbW0h2KfC02ebtwhY8VxGCrl2jB35VY+w4yCl+BaqHTM6AHlZTm
         i9AAYOy6CnyqLiWfn6eFyBYyTUowD3wjO3quShZe4p86fK9aofB+FAdyi78Gd99rZD++
         u4aoJ+ywzZ/5vWIBOXSc6HrJOWZ1Gohq50RQF4cuY+LMxDWqYdkXTENK4J0ngP40GM0X
         5gqRG0klF/TW2rMgA5Cnw4YdlhgwUvstQg8/2ePGiGF+Uv61VYTRZKISq5CPbKNFYuSe
         u8Pg==
X-Gm-Message-State: AOAM531MbHbrodzLdpkJc6N+gKA7Xhel8vETTnSFQQiiajbO4Psj4hjX
        6JwBuvwpeOF5aXTnPPR818ct7F82aOk=
X-Google-Smtp-Source: ABdhPJyNHG0yc/f1GAURsq/z1rMvHgvKiQB1+p6a7uyPqqaKez0A9k/Cvoun/6LplZkrVIur1ooHig==
X-Received: by 2002:a2e:8608:: with SMTP id a8mr7894776lji.89.1608565092406;
        Mon, 21 Dec 2020 07:38:12 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id f15sm2135704lfc.10.2020.12.21.07.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 07:38:11 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 21 Dec 2020 16:38:09 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 2/2] rcu-tasks: add RCU-tasks self tests
Message-ID: <20201221153809.GA24756@pc638.lan>
References: <20201209202732.5896-1-urezki@gmail.com>
 <20201209202732.5896-2-urezki@gmail.com>
 <20201216154959.GA2408@pc638.lan>
 <20201216232955.GO2657@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216232955.GO2657@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Dec 16, 2020 at 03:29:55PM -0800, Paul E. McKenney wrote:
> On Wed, Dec 16, 2020 at 04:49:59PM +0100, Uladzislau Rezki wrote:
> > > Add self tests for checking of RCU-tasks API functionality.
> > > It covers:
> > >     - wait API functions;
> > >     - invoking/completion call_rcu_tasks*().
> > > 
> > > Self-tests are run when CONFIG_PROVE_RCU kernel parameter is set.
> > > 
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > ---
> > >  kernel/rcu/tasks.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 44 insertions(+)
> > > 
> > > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > > index 67a162949763..9407772780c1 100644
> > > --- a/kernel/rcu/tasks.h
> > > +++ b/kernel/rcu/tasks.h
> > > @@ -1225,6 +1225,16 @@ void show_rcu_tasks_gp_kthreads(void)
> > >  }
> > >  #endif /* #ifndef CONFIG_TINY_RCU */
> > >  
> > > +static struct rcu_head rhp;
> > > +static int rcu_execurted_test_counter;
> > > +static int rcu_run_test_counter;
> > > +
> > > +static void test_rcu_tasks_callback(struct rcu_head *r)
> > > +{
> > > +	pr_info("RCU-tasks test callback executed %d\n",
> > > +		++rcu_execurted_test_counter);
> > > +}
> > > +
> > >  void __init rcu_init_tasks_generic(void)
> > >  {
> > >  #ifdef CONFIG_TASKS_RCU
> > > @@ -1238,7 +1248,41 @@ void __init rcu_init_tasks_generic(void)
> > >  #ifdef CONFIG_TASKS_TRACE_RCU
> > >  	rcu_spawn_tasks_trace_kthread();
> > >  #endif
> > > +
> > > +	if (IS_ENABLED(CONFIG_PROVE_RCU)) {
> > > +		pr_info("Running RCU-tasks wait API self tests\n");
> > > +#ifdef CONFIG_TASKS_RCU
> > > +		rcu_run_test_counter++;
> > > +		call_rcu_tasks(&rhp, test_rcu_tasks_callback);
> > > +		synchronize_rcu_tasks();
> > > +#endif
> > > +
> > > +#ifdef CONFIG_TASKS_RUDE_RCU
> > > +		rcu_run_test_counter++;
> > > +		call_rcu_tasks_trace(&rhp, test_rcu_tasks_callback);
> > > +		synchronize_rcu_tasks_rude();
> > > +#endif
> > > +
> > > +#ifdef CONFIG_TASKS_TRACE_RCU
> > > +		rcu_run_test_counter++;
> > > +		call_rcu_tasks_trace(&rhp, test_rcu_tasks_callback);
> > > +		synchronize_rcu_tasks_trace();
> > > +#endif
> > > +	}
> > > +}
> > > +
> > > +static int rcu_tasks_verify_self_tests(void)
> > > +{
> > > +	int ret = 0;
> > > +
> > > +	if (rcu_run_test_counter != rcu_execurted_test_counter) {
> > > +		WARN_ON(1);
> > > +		ret = -1;
> > > +	}
> > > +
> > > +	return ret;
> > >  }
> > > +late_initcall(rcu_tasks_verify_self_tests);
> > >  
> > >  #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
> > >  static inline void rcu_tasks_bootup_oddness(void) {}
> > Please find a v2 of the patch that is in question. First version
> > uses the same rhp for all RCU flavors what is wrong. Initially
> > i had three different one per one flavor. But for some reason
> > end up with only one.
> > 
> > 
> > >From e7c6096af5a7916f29c0b4b05e1644b3b3a6c589 Mon Sep 17 00:00:00 2001
> > From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> > Date: Wed, 9 Dec 2020 21:27:32 +0100
> > Subject: [PATCH v2 1/1] rcu-tasks: Add RCU-tasks self tests
> > 
> > This commit adds self tests for early-boot use of RCU-tasks grace periods.
> > It tests all three variants (Rude, Tasks, and Tasks Trace) and covers
> > both synchronous (e.g., synchronize_rcu_tasks()) and asynchronous (e.g.,
> > call_rcu_tasks()) grace-period APIs.
> > 
> > Self-tests are run only in kernels built with CONFIG_PROVE_RCU=y.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Much improved, thank you!  A few more comments below.
> 
> > ---
> >  kernel/rcu/tasks.h | 69 ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 69 insertions(+)
> > 
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > index 36607551f966..7478d912734a 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -1224,6 +1224,35 @@ void show_rcu_tasks_gp_kthreads(void)
> >  }
> >  #endif /* #ifndef CONFIG_TINY_RCU */
> > 
> > +struct test_desc {
> 
> Please use something like "struct rcu_tasks_test_desc" to help the poor
> people who might need to grep for this.  Feel free to shorten it, but
> please make it descriptive and thus more likely to stay unique.
> 
> > +       struct rcu_head rh;
> > +       const char *name;
> > +       bool run;
> 
> If you make this "bool notrun" you don't need to initialize.
> 
> > +};
> > +
> > +static struct test_desc tests[] = {
> > +       { .name = "call_rcu_tasks()" },
> > +       { .name = "call_rcu_rude()"  },
> > +       { .name = "call_rcu_trace()" },
> > +};
> > +
> > +static int rcu_executed_test_counter;
> > +
> > +static void test_rcu_tasks_callback(struct rcu_head *rhp)
> > +{
> 
> 	struct rcu_tasks_test_desc *rttdp;
> 
> > +       int i;
> > +
> > +       pr_info("RCU-tasks test callback executed %d\n",
> > +               ++rcu_executed_test_counter);
> 
> 	rttdp = container_of(rhp, rh, struct rcu_tasks_test_desc);
> 	rttdp->notrun = true;
> 
> Or I suppose:
> 
> 	container_of(rhp, rh, struct rcu_tasks_test_desc)->notrun = true;
> 
> Then the loop below can go away.
> 
> > +
> > +       for (i = 0; i < ARRAY_SIZE(tests); i++) {
> > +               if (rhp == &tests[i].rh) {
> > +                       tests[i].run = false;
> > +                       break;
> > +               }
> > +       }
> > +}
> > +
> >  void __init rcu_init_tasks_generic(void)
> >  {
> >  #ifdef CONFIG_TASKS_RCU
> > @@ -1237,7 +1266,47 @@ void __init rcu_init_tasks_generic(void)
> >  #ifdef CONFIG_TASKS_TRACE_RCU
> >         rcu_spawn_tasks_trace_kthread();
> >  #endif
> > +
> > +       // Run the self-tests.
> > +       if (IS_ENABLED(CONFIG_PROVE_RCU)) {
> > +               pr_info("Running RCU-tasks wait API self tests\n");
> > +#ifdef CONFIG_TASKS_RCU
> > +               tests[0].run = true;
> 
> The s/run/notrun/ allows the three initializations of .run to go away.
> 
> > +               call_rcu_tasks(&tests[0].rh, test_rcu_tasks_callback);
> > +               synchronize_rcu_tasks();
> 
> Why not reverse the order of these two statements?  That would test
> call_rcu_tasks*()'s ability to do a grace period on their own, without
> help from the corresponding synchronize_rcu_tasks*().
> 
> > +#endif
> > +
> > +#ifdef CONFIG_TASKS_RUDE_RCU
> > +               tests[1].run = true;
> > +               call_rcu_tasks_rude(&tests[1].rh, test_rcu_tasks_callback);
> > +               synchronize_rcu_tasks_rude();
> > +#endif
> > +
> > +#ifdef CONFIG_TASKS_TRACE_RCU
> > +               tests[2].run = true;
> > +               call_rcu_tasks_trace(&tests[2].rh, test_rcu_tasks_callback);
> > +               synchronize_rcu_tasks_trace();
> > +#endif
> > +       }
> > +}
> > +
> > +static int rcu_tasks_verify_self_tests(void)
> > +{
> > +       int ret, i;
> 
> Why not initialize "ret" in the declaration?
> 
> > +
> > +       for (i = 0, ret = 0; i < ARRAY_SIZE(tests); i++) {
> > +               if (tests[i].run) {             // still hanging.
> > +                       pr_err("%s has been failed.\n", tests[i].name);
> > +                       ret = -1;
> > +               }
> > +       }
> > +
> > +       if (ret)
> > +               WARN_ON(1);
> > +
> > +       return ret;
> >  }
> > +late_initcall(rcu_tasks_verify_self_tests);
> > 
> >  #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
> >  static inline void rcu_tasks_bootup_oddness(void) {}
> > -- 
> > 2.20.1
> 
> Again, much improved!
> 
See below the v3 version. I hope i fixed all comments :)

From 06f7adfd84cbb1994d0e2693ee9dcdfd272a9bd0 Mon Sep 17 00:00:00 2001
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Date: Wed, 9 Dec 2020 21:27:32 +0100
Subject: [PATCH v3 1/1] rcu-tasks: Add RCU-tasks self tests

This commit adds self tests for early-boot use of RCU-tasks grace periods.
It tests all three variants (Rude, Tasks, and Tasks Trace) and covers
both synchronous (e.g., synchronize_rcu_tasks()) and asynchronous (e.g.,
call_rcu_tasks()) grace-period APIs.

Self-tests are run only in kernels built with CONFIG_PROVE_RCU=y.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tasks.h | 75 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 36607551f966..670212ed9648 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1224,6 +1224,43 @@ void show_rcu_tasks_gp_kthreads(void)
 }
 #endif /* #ifndef CONFIG_TINY_RCU */
 
+struct rcu_tasks_test_desc {
+	struct rcu_head rh;
+	const char *name;
+	bool notrun;
+};
+
+static struct rcu_tasks_test_desc tests[] = {
+	{
+		.name = "call_rcu_tasks()",
+		/* If not defined, the test is skipped. */
+		.notrun = !IS_ENABLED(CONFIG_TASKS_RCU),
+	},
+	{
+		.name = "call_rcu_tasks_rude()",
+		/* If not defined, the test is skipped. */
+		.notrun = !IS_ENABLED(CONFIG_TASKS_RUDE_RCU),
+	},
+	{
+		.name = "call_rcu_tasks_trace()",
+		/* If not defined, the test is skipped. */
+		.notrun = !IS_ENABLED(CONFIG_TASKS_TRACE_RCU)
+	}
+};
+
+static int rcu_executed_test_counter;
+
+static void test_rcu_tasks_callback(struct rcu_head *rhp)
+{
+	struct rcu_tasks_test_desc *rttd =
+		container_of(rhp, struct rcu_tasks_test_desc, rh);
+
+	pr_info("RCU-tasks test callback executed %d\n",
+		++rcu_executed_test_counter);
+
+	rttd->notrun = true;
+}
+
 void __init rcu_init_tasks_generic(void)
 {
 #ifdef CONFIG_TASKS_RCU
@@ -1237,7 +1274,45 @@ void __init rcu_init_tasks_generic(void)
 #ifdef CONFIG_TASKS_TRACE_RCU
 	rcu_spawn_tasks_trace_kthread();
 #endif
+
+	// Run the self-tests.
+	if (IS_ENABLED(CONFIG_PROVE_RCU)) {
+		pr_info("Running RCU-tasks wait API self tests\n");
+#ifdef CONFIG_TASKS_RCU
+		synchronize_rcu_tasks();
+		call_rcu_tasks(&tests[0].rh, test_rcu_tasks_callback);
+#endif
+
+#ifdef CONFIG_TASKS_RUDE_RCU
+		synchronize_rcu_tasks_rude();
+		call_rcu_tasks_rude(&tests[1].rh, test_rcu_tasks_callback);
+#endif
+
+#ifdef CONFIG_TASKS_TRACE_RCU
+		synchronize_rcu_tasks_trace();
+		call_rcu_tasks_trace(&tests[2].rh, test_rcu_tasks_callback);
+#endif
+	}
+}
+
+static int rcu_tasks_verify_self_tests(void)
+{
+	int ret = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		if (!tests[i].notrun) {		// still hanging.
+			pr_err("%s has been failed.\n", tests[i].name);
+			ret = -1;
+		}
+	}
+
+	if (ret)
+		WARN_ON(1);
+
+	return ret;
 }
+late_initcall(rcu_tasks_verify_self_tests);
 
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
 static inline void rcu_tasks_bootup_oddness(void) {}
-- 
2.20.1

--
Vlad Rezki
