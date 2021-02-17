Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5EAC433E0
	for <rcu@archiver.kernel.org>; Wed, 17 Feb 2021 14:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4615064E02
	for <rcu@archiver.kernel.org>; Wed, 17 Feb 2021 14:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbhBQOss (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 17 Feb 2021 09:48:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:46740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233557AbhBQOsr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 17 Feb 2021 09:48:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09CE564DFF;
        Wed, 17 Feb 2021 14:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613573286;
        bh=zobywRe6oEzSDSIToNERyYqXja9w/fADQLlstyoTVek=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KEXxsECClCrupmOt8VB3fu4qdpEilnkyBTNWYKJCiXdeNBEfyzQwSJ+wla2+7Jm/o
         D3tspG5yL46U6EE5Y+LuAjqPaFCXIHspb1PwaiaCHevFxCWISZSeQuYS/Y9Zg6tDuj
         QEEXXTBe/SbUZlZc8ZHbiEL/ef2chBlMF1+iM9w4NTfG4EEV6E/8zjm69Ur0Yvb3x4
         JwNg31Ro4+YSKFUmukKLN5jksdHju9fsWxleqo5RyfDhDVDWoqovBUkgGXnz5ifvmB
         qyESL/yS3uQqgNkiABmNU/nufd7qRgiqwzuWBfdVg52SxptyDOPKMc3UKAxX2E0umb
         heraiL6vGyKHA==
Date:   Wed, 17 Feb 2021 23:47:59 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     paulmck@kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        mhiramat@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH 2/2] rcu-tasks: add RCU-tasks self tests
Message-Id: <20210217234759.b82e39049a2e99cf6358e1c2@kernel.org>
In-Reply-To: <20210216173003.GX2743@paulmck-ThinkPad-P72>
References: <20201209202732.5896-1-urezki@gmail.com>
        <20201209202732.5896-2-urezki@gmail.com>
        <20210212192059.wytqwdf4qm4rnq3d@linutronix.de>
        <20210212211207.GA2046@pc638.lan>
        <20210212234851.GP2743@paulmck-ThinkPad-P72>
        <20210213003709.GA27846@paulmck-ThinkPad-P72>
        <20210213004328.GB27846@paulmck-ThinkPad-P72>
        <20210213113030.GA1878@pc638.lan>
        <20210213164554.GS2743@paulmck-ThinkPad-P72>
        <20210215112826.xc6b4se6ujwvrwco@linutronix.de>
        <20210216173003.GX2743@paulmck-ThinkPad-P72>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, 16 Feb 2021 09:30:03 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Mon, Feb 15, 2021 at 12:28:26PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2021-02-13 08:45:54 [-0800], Paul E. McKenney wrote:
> > > Glad you like it!  But let's see which (if any) of these patches solves
> > > the problem for Sebastian.
> > 
> > Looking at that, is there any reason for doing this that can not be
> > solved by moving the self-test a little later? Maybe once we reached at
> > least SYSTEM_SCHEDULING?
> 
> One problem is that ksoftirqd and the kprobes use are early_initcall(),
> so we cannot count on ksoftirqd being spawned when kprobes first uses
> synchronize_rcu_tasks().  Moving the selftest later won't fix this
> problem, but rather just paper it over.
> 
> > This happens now even before lockdep is up or the console is registered.
> > So if something bad happens, you end up with a blank terminal.
> 
> I was getting a splat, but I could easily believe that there are
> configurations where the hang is totally silent.  In other words, I do
> agree that this needs a proper fix.  All we need do is work out an
> agreeable value of "proper".  ;-)
> 
> > There is nothing else that early in the boot process that requires
> > working softirq. The only exception to this is wait_task_inactive()
> > which is used while starting a new thread (including the ksoftirqd)
> > which is why it was moved to schedule_hrtimeout().
> 
> Moving kprobes initialization to early_initcall() [1] means that there
> can be a call to synchronize_rcu_tasks() before the current spawning of
> ksoftirqd.  Because synchronize_rcu_tasks() needs timers to work, it needs
> softirq to work.  I know two straightforward ways to make that happen:
> 
> 1.	Spawn ksoftirqd earlier.
> 
> 2.	Suppress attempts to awaken ksoftirqd before it exists,
> 	forcing all ksoftirq execution on the back of interrupts.
> 
> Uladzislau and I each produced patches for #1, and I produced a patch
> for #2.
> 
> The only other option I know of is to push the call to init_kprobes()
> later in the boot sequence, perhaps to its original subsys_initcall(),
> or maybe only as late as core_initcall().  I added Masami and Steve on
> CC for their thoughts on this.
> 
> Is there some other proper fix that I am missing?

Oh, I missed that the synchronize_rcu_tasks() will be involved the kprobes
in early stage. Does the problem only exist in the synchronize_rcu_tasks()
instead of synchronize_rcu()? If so I can just stop optimizer in early stage
because I just want to enable kprobes in early stage, but not optprobes.

Does the following patch help?

From e5fafcda3ff918cd52619f795a3f22fb95c72b11 Mon Sep 17 00:00:00 2001
From: Masami Hiramatsu <mhiramat@kernel.org>
Date: Wed, 17 Feb 2021 23:35:20 +0900
Subject: [PATCH] kprobes: Fix to delay the kprobes jump optimization

Since the kprobes jump optimization involves synchronize_rcu_tasks()
which depends on the ksoftirqd, that can not be enabled at the
early_initcall() boot stage. So this makes the kprobe optimization
disabled in the early_initcall() and enables it in subsys_initcall().

Note that non-optimized kprobes is still available after
early_initcall(). Only jump optimization is delayed.

Fixes: 36dadef23fcc ("kprobes: Init kprobes in early_initcall")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index d5a3eb74a657..779d8322e307 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -861,7 +861,6 @@ static void try_to_optimize_kprobe(struct kprobe *p)
 	cpus_read_unlock();
 }
 
-#ifdef CONFIG_SYSCTL
 static void optimize_all_kprobes(void)
 {
 	struct hlist_head *head;
@@ -887,6 +886,7 @@ static void optimize_all_kprobes(void)
 	mutex_unlock(&kprobe_mutex);
 }
 
+#ifdef CONFIG_SYSCTL
 static void unoptimize_all_kprobes(void)
 {
 	struct hlist_head *head;
@@ -2497,18 +2497,14 @@ static int __init init_kprobes(void)
 		}
 	}
 
-#if defined(CONFIG_OPTPROBES)
-#if defined(__ARCH_WANT_KPROBES_INSN_SLOT)
-	/* Init kprobe_optinsn_slots */
-	kprobe_optinsn_slots.insn_size = MAX_OPTINSN_SIZE;
-#endif
-	/* By default, kprobes can be optimized */
-	kprobes_allow_optimization = true;
-#endif
-
 	/* By default, kprobes are armed */
 	kprobes_all_disarmed = false;
 
+#if defined(CONFIG_OPTPROBES) && defined(__ARCH_WANT_KPROBES_INSN_SLOT)
+	/* Init kprobe_optinsn_slots for allocation */
+	kprobe_optinsn_slots.insn_size = MAX_OPTINSN_SIZE;
+#endif
+
 	err = arch_init_kprobes();
 	if (!err)
 		err = register_die_notifier(&kprobe_exceptions_nb);
@@ -2523,6 +2519,21 @@ static int __init init_kprobes(void)
 }
 early_initcall(init_kprobes);
 
+#if defined(CONFIG_OPTPROBES)
+static int __init init_optprobes(void)
+{
+	/*
+	 * Enable kprobe optimization - this kicks the optimizer which
+	 * depends on synchronize_rcu_tasks() and ksoftirqd, that is
+	 * not spawned in early initcall. So delay the optimization.
+	 */
+	optimize_all_kprobes();
+
+	return 0;
+}
+subsys_initcall(init_optprobes);
+#endif
+
 #ifdef CONFIG_DEBUG_FS
 static void report_probe(struct seq_file *pi, struct kprobe *p,
 		const char *sym, int offset, char *modname, struct kprobe *pp)
-- 
2.25.1


-- 
Masami Hiramatsu <mhiramat@kernel.org>
