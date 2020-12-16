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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F3EC4361B
	for <rcu@archiver.kernel.org>; Wed, 16 Dec 2020 15:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0A6423104
	for <rcu@archiver.kernel.org>; Wed, 16 Dec 2020 15:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgLPPur (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 16 Dec 2020 10:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgLPPur (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 16 Dec 2020 10:50:47 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73801C061794;
        Wed, 16 Dec 2020 07:50:06 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id x20so29986804lfe.12;
        Wed, 16 Dec 2020 07:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dVC82aZtq7EOX+1Jzw8lfBhIqrAn6nAuPMTE2J6bpU8=;
        b=LYLsFuSlIsE634FXs60xyDXc0N6Xm3cnUTs5fg8P5Sy/3i/vGJTzPwwuuj9FORTnAc
         M+LKWYVake6RSVidmylg9l8k1zTSnJUGMMlW62Cv1NKk8Z/bw1h9MLTzMcCx+wkbba4C
         CqGhBTz9y3l7UVmRkOO9utaNNTUopatcuqk0uNvXQo+kMESAemDkfW8XSCqjJZkDXTcx
         QbKZSZs1diszerxWrP/aI/Ie1nle8sp5DCtTAu5H61o4g3kLdoZZquwMM3sa1Qe0I+t/
         pmKiYugQjgsFXkKAh+RnIe5go372EGs9H2SHty6tRRzbKeh+d/rVqVHsxfzP/Iqwpnn5
         NG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dVC82aZtq7EOX+1Jzw8lfBhIqrAn6nAuPMTE2J6bpU8=;
        b=EeslHEWLjPGuIGZXcEhh6Fu7Sn+uVCmhe1BVajMC37R44cBpvjXGmpO72RPAabkAyw
         Ad4/mtPM2AFpvmczCLFvVeGsdDAwOUysKdEyaHu1SGKWB/3zsLq+uU8JsYR7+NDItgnt
         PZslsdV9Cc4i/ZMVoX/dPTx0kM/RyJEQpJ1b2C6QG/XG2jQ1yIIDhG8nbjvwlZltYlTX
         BZrc3IRulgxjDF56nNGfh99AedqvGTROwafZCEKCw9zYbcu210LMjv9Cvco8oHGbJcdL
         XrqqpVmbWxT9yCJtLMcpd2tP67uBFBr6AiLfWmc+S30gNkvtbbMcIrODQrUCeld0gBCt
         6+sg==
X-Gm-Message-State: AOAM532GnfCNPvl9wDbTQBppCiln3uHd7eLb1wNU9NNwZrrGPbAzcYw1
        LrRiqMftsVW6HEyyAPJ213+0ugkSluLBPQ==
X-Google-Smtp-Source: ABdhPJyQX4vkLOhoEs/vUyIi/NKQ5gO0V+yzhJz25Sf1cK3pmRBXcX1BiDzETZ1UrsWnqYquzBoUJw==
X-Received: by 2002:a2e:9b8a:: with SMTP id z10mr8409752lji.126.1608133803879;
        Wed, 16 Dec 2020 07:50:03 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id 10sm266131lfh.208.2020.12.16.07.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 07:50:02 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 16 Dec 2020 16:49:59 +0100
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
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
Message-ID: <20201216154959.GA2408@pc638.lan>
References: <20201209202732.5896-1-urezki@gmail.com>
 <20201209202732.5896-2-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209202732.5896-2-urezki@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> Add self tests for checking of RCU-tasks API functionality.
> It covers:
>     - wait API functions;
>     - invoking/completion call_rcu_tasks*().
> 
> Self-tests are run when CONFIG_PROVE_RCU kernel parameter is set.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  kernel/rcu/tasks.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 67a162949763..9407772780c1 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1225,6 +1225,16 @@ void show_rcu_tasks_gp_kthreads(void)
>  }
>  #endif /* #ifndef CONFIG_TINY_RCU */
>  
> +static struct rcu_head rhp;
> +static int rcu_execurted_test_counter;
> +static int rcu_run_test_counter;
> +
> +static void test_rcu_tasks_callback(struct rcu_head *r)
> +{
> +	pr_info("RCU-tasks test callback executed %d\n",
> +		++rcu_execurted_test_counter);
> +}
> +
>  void __init rcu_init_tasks_generic(void)
>  {
>  #ifdef CONFIG_TASKS_RCU
> @@ -1238,7 +1248,41 @@ void __init rcu_init_tasks_generic(void)
>  #ifdef CONFIG_TASKS_TRACE_RCU
>  	rcu_spawn_tasks_trace_kthread();
>  #endif
> +
> +	if (IS_ENABLED(CONFIG_PROVE_RCU)) {
> +		pr_info("Running RCU-tasks wait API self tests\n");
> +#ifdef CONFIG_TASKS_RCU
> +		rcu_run_test_counter++;
> +		call_rcu_tasks(&rhp, test_rcu_tasks_callback);
> +		synchronize_rcu_tasks();
> +#endif
> +
> +#ifdef CONFIG_TASKS_RUDE_RCU
> +		rcu_run_test_counter++;
> +		call_rcu_tasks_trace(&rhp, test_rcu_tasks_callback);
> +		synchronize_rcu_tasks_rude();
> +#endif
> +
> +#ifdef CONFIG_TASKS_TRACE_RCU
> +		rcu_run_test_counter++;
> +		call_rcu_tasks_trace(&rhp, test_rcu_tasks_callback);
> +		synchronize_rcu_tasks_trace();
> +#endif
> +	}
> +}
> +
> +static int rcu_tasks_verify_self_tests(void)
> +{
> +	int ret = 0;
> +
> +	if (rcu_run_test_counter != rcu_execurted_test_counter) {
> +		WARN_ON(1);
> +		ret = -1;
> +	}
> +
> +	return ret;
>  }
> +late_initcall(rcu_tasks_verify_self_tests);
>  
>  #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
>  static inline void rcu_tasks_bootup_oddness(void) {}
Please find a v2 of the patch that is in question. First version
uses the same rhp for all RCU flavors what is wrong. Initially
i had three different one per one flavor. But for some reason
end up with only one.


From e7c6096af5a7916f29c0b4b05e1644b3b3a6c589 Mon Sep 17 00:00:00 2001
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Date: Wed, 9 Dec 2020 21:27:32 +0100
Subject: [PATCH v2 1/1] rcu-tasks: Add RCU-tasks self tests

This commit adds self tests for early-boot use of RCU-tasks grace periods.
It tests all three variants (Rude, Tasks, and Tasks Trace) and covers
both synchronous (e.g., synchronize_rcu_tasks()) and asynchronous (e.g.,
call_rcu_tasks()) grace-period APIs.

Self-tests are run only in kernels built with CONFIG_PROVE_RCU=y.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tasks.h | 69 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 36607551f966..7478d912734a 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1224,6 +1224,35 @@ void show_rcu_tasks_gp_kthreads(void)
 }
 #endif /* #ifndef CONFIG_TINY_RCU */

+struct test_desc {
+       struct rcu_head rh;
+       const char *name;
+       bool run;
+};
+
+static struct test_desc tests[] = {
+       { .name = "call_rcu_tasks()" },
+       { .name = "call_rcu_rude()"  },
+       { .name = "call_rcu_trace()" },
+};
+
+static int rcu_executed_test_counter;
+
+static void test_rcu_tasks_callback(struct rcu_head *rhp)
+{
+       int i;
+
+       pr_info("RCU-tasks test callback executed %d\n",
+               ++rcu_executed_test_counter);
+
+       for (i = 0; i < ARRAY_SIZE(tests); i++) {
+               if (rhp == &tests[i].rh) {
+                       tests[i].run = false;
+                       break;
+               }
+       }
+}
+
 void __init rcu_init_tasks_generic(void)
 {
 #ifdef CONFIG_TASKS_RCU
@@ -1237,7 +1266,47 @@ void __init rcu_init_tasks_generic(void)
 #ifdef CONFIG_TASKS_TRACE_RCU
        rcu_spawn_tasks_trace_kthread();
 #endif
+
+       // Run the self-tests.
+       if (IS_ENABLED(CONFIG_PROVE_RCU)) {
+               pr_info("Running RCU-tasks wait API self tests\n");
+#ifdef CONFIG_TASKS_RCU
+               tests[0].run = true;
+               call_rcu_tasks(&tests[0].rh, test_rcu_tasks_callback);
+               synchronize_rcu_tasks();
+#endif
+
+#ifdef CONFIG_TASKS_RUDE_RCU
+               tests[1].run = true;
+               call_rcu_tasks_rude(&tests[1].rh, test_rcu_tasks_callback);
+               synchronize_rcu_tasks_rude();
+#endif
+
+#ifdef CONFIG_TASKS_TRACE_RCU
+               tests[2].run = true;
+               call_rcu_tasks_trace(&tests[2].rh, test_rcu_tasks_callback);
+               synchronize_rcu_tasks_trace();
+#endif
+       }
+}
+
+static int rcu_tasks_verify_self_tests(void)
+{
+       int ret, i;
+
+       for (i = 0, ret = 0; i < ARRAY_SIZE(tests); i++) {
+               if (tests[i].run) {             // still hanging.
+                       pr_err("%s has been failed.\n", tests[i].name);
+                       ret = -1;
+               }
+       }
+
+       if (ret)
+               WARN_ON(1);
+
+       return ret;
 }
+late_initcall(rcu_tasks_verify_self_tests);

 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
 static inline void rcu_tasks_bootup_oddness(void) {}
-- 
2.20.1

--
Vlad Rezki
