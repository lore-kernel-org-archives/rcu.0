Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F59C433E0
	for <rcu@archiver.kernel.org>; Fri, 19 Feb 2021 10:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2BC764EB7
	for <rcu@archiver.kernel.org>; Fri, 19 Feb 2021 10:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhBSKup (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 19 Feb 2021 05:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhBSKun (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 19 Feb 2021 05:50:43 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7C9C061756;
        Fri, 19 Feb 2021 02:50:02 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id c8so17802915ljd.12;
        Fri, 19 Feb 2021 02:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y0Yx7VVnU/W2+L2dh6W1FITCqjGsxYkHil+6YG9in0k=;
        b=msbNF1ONnsEShcFrdua+cfZoCXOUij7q0SMsPSaeDRXeLRDncODD9ce4hoIzVYpACc
         Ai5gQXmQeqxCsW9tS2/PL/5tG33GCr8Xa31T0xQ+6Q4bUXJexFtBoUVXoAVp15zUBDDh
         em5LTD8dnMxsFKKpOj3ey+0mAOx05Vi6LaRsBvnJ9JNXowuVGwNZBHgGP+BlyO67L39f
         JiRbFkuIwaHC4DnmpgXRza4nwcYJ4De91VWM6l2YPx8WchovXxfgDcIXSpfDnnJcPOkH
         XP0g2AZnm4YDBtRWVfe6R40p/3WEGXTm4JpxKdyPzaCWIAHmKzNylQXxj1hYx+EIj7vP
         FL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y0Yx7VVnU/W2+L2dh6W1FITCqjGsxYkHil+6YG9in0k=;
        b=m2th8xqVx8bRe5ISheQjjLHr7DL8ifoAgCpjVeVEtTzU1ywWa7oqYqTJCTGVTTthsy
         u6FuLnkfmSfv1w4GolLg26SwrzuF269QfW60WC73wgqmTePyZq7dR5f+BZA/ZbRTiGIH
         /OCrV2V5KGbCC2hyv2DFbrsfGJtNEVZNSrY6GClmoYa2WVj6RzheynAOMX02W+tQb+pA
         jxGV1B2pnQ2n30XTiu4XQzkEXP6B1M2xQRVRCT4+uJr9efdZXRhKYVkFLOTcp3xpcyNo
         QDfd7ooy4En6fTQr8lRUhupTq4bs7lTaa08Mdlz1OL2KQxL6HIk3BLt+CEfS55mUfFKm
         ZThA==
X-Gm-Message-State: AOAM532cKN2oTLx8ZXIe48iUS/C8GWQulzvo5gtZBLnz84qslGI6XRix
        MPxfwdrC8bJCjqt2uxLi7Bg=
X-Google-Smtp-Source: ABdhPJwY506EqwNoo46pMPEhxNoBnvKa7HC9qr2YAjyy8WR4AgzfglUReP8TrV7MZtRdKXu577P4EQ==
X-Received: by 2002:a05:6512:39c5:: with SMTP id k5mr1974743lfu.478.1613731800568;
        Fri, 19 Feb 2021 02:50:00 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id j16sm366852lfk.68.2021.02.19.02.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 02:50:00 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Fri, 19 Feb 2021 11:49:58 +0100
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Michal Hocko <mhocko@suse.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH] kprobes: Fix to delay the kprobes jump optimization
Message-ID: <20210219104958.GA34308@pc638.lan>
References: <161365856280.719838.12423085451287256713.stgit@devnote2>
 <20210218151554.GQ2743@paulmck-ThinkPad-P72>
 <20210219081755.eucq4srbam6wg2gm@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219081755.eucq4srbam6wg2gm@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Feb 19, 2021 at 09:17:55AM +0100, Sebastian Andrzej Siewior wrote:
> On 2021-02-18 07:15:54 [-0800], Paul E. McKenney wrote:
> > Thank you, but the original report of a problem was from Sebastian
> > and the connection to softirq was Uladzislau.  So could you please
> > add these before (or even in place of) my Reported-by?
> > 
> > Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Reported-by: Uladzislau Rezki <urezki@gmail.com>
> > 
> > Other than that, looks good!
> 
> Perfect. I'm kind of lost here, nevertheless ;) Does this mean that the
> RCU selftest can now be delayed?
> 
If above fix works, we can initialize rcu_init_tasks_generic() from the
core_initcall() including selftst. It means that such initialization can
be done later:

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 5cc6deaa5df2..ae7d0cdfa9bd 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -88,12 +88,6 @@ void rcu_sched_clock_irq(int user);
 void rcu_report_dead(unsigned int cpu);
 void rcutree_migrate_callbacks(int cpu);
 
-#ifdef CONFIG_TASKS_RCU_GENERIC
-void rcu_init_tasks_generic(void);
-#else
-static inline void rcu_init_tasks_generic(void) { }
-#endif
-
 #ifdef CONFIG_RCU_STALL_COMMON
 void rcu_sysrq_start(void);
 void rcu_sysrq_end(void);
diff --git a/init/main.c b/init/main.c
index c68d784376ca..3024c4db17a9 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1512,7 +1512,6 @@ static noinline void __init kernel_init_freeable(void)
 
 	init_mm_internals();
 
-	rcu_init_tasks_generic();
 	do_pre_smp_initcalls();
 	lockup_detector_init();
 
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 17c8ebe131af..2797f9a042f4 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -966,11 +966,6 @@ static void rcu_tasks_trace_pregp_step(void)
 static void rcu_tasks_trace_pertask(struct task_struct *t,
 				    struct list_head *hop)
 {
-	// During early boot when there is only the one boot CPU, there
-	// is no idle task for the other CPUs. Just return.
-	if (unlikely(t == NULL))
-		return;
-
 	WRITE_ONCE(t->trc_reader_special.b.need_qs, false);
 	WRITE_ONCE(t->trc_reader_checked, false);
 	t->trc_ipi_to_cpu = -1;
@@ -1300,7 +1295,7 @@ late_initcall(rcu_tasks_verify_self_tests);
 static void rcu_tasks_initiate_self_tests(void) { }
 #endif /* #else #ifdef CONFIG_PROVE_RCU */
 
-void __init rcu_init_tasks_generic(void)
+static void __init rcu_init_tasks_generic(void)
 {
 #ifdef CONFIG_TASKS_RCU
 	rcu_spawn_tasks_kthread();
@@ -1318,6 +1313,7 @@ void __init rcu_init_tasks_generic(void)
 	rcu_tasks_initiate_self_tests();
 }
 
+core_initcall(rcu_init_tasks_generic);
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
 static inline void rcu_tasks_bootup_oddness(void) {}
 void show_rcu_tasks_gp_kthreads(void) {}


--
Vlad Rezki
