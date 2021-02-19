Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C848EC433DB
	for <rcu@archiver.kernel.org>; Fri, 19 Feb 2021 20:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87EEA64D9C
	for <rcu@archiver.kernel.org>; Fri, 19 Feb 2021 20:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhBSUDQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 19 Feb 2021 15:03:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:33686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229765AbhBSUDP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 19 Feb 2021 15:03:15 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B5BD64D9C;
        Fri, 19 Feb 2021 20:02:32 +0000 (UTC)
Date:   Fri, 19 Feb 2021 15:02:31 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <20210219150231.31dc72a2@gandalf.local.home>
In-Reply-To: <20210219183336.GA23049@paulmck-ThinkPad-P72>
References: <161365856280.719838.12423085451287256713.stgit@devnote2>
        <20210218151554.GQ2743@paulmck-ThinkPad-P72>
        <20210219081755.eucq4srbam6wg2gm@linutronix.de>
        <20210219104958.GA34308@pc638.lan>
        <20210219105710.d626zexj6vzt6k6y@linutronix.de>
        <20210219111301.GA34441@pc638.lan>
        <20210219111738.go6i2fdzvavpotxd@linutronix.de>
        <20210219112357.GA34462@pc638.lan>
        <20210219112751.GA34528@pc638.lan>
        <20210219181811.GY2743@paulmck-ThinkPad-P72>
        <20210219183336.GA23049@paulmck-ThinkPad-P72>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, 19 Feb 2021 10:33:36 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> commit 4f659bf04fc4610523544493d6db92fc8670b086
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Fri Feb 12 16:20:40 2021 -0800
> 
>     softirq: Don't try waking ksoftirqd before it has been spawned
>     
>     If there is heavy softirq activity, the softirq system will attempt
>     to awaken ksoftirqd and will stop the traditional back-of-interrupt
>     softirq processing.  This is all well and good, but only if the
>     ksoftirqd kthreads already exist, which is not the case during early
>     boot, in which case the system hangs.
>     
>     One reproducer is as follows:
>     
>     tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 2 --configs "TREE03" --kconfig "CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y" --bootargs "threadirqs=1" --trust-make
>     
>     This commit therefore adds a couple of existence checks for ksoftirqd
>     and forces back-of-interrupt softirq processing when ksoftirqd does not
>     yet exist.  With this change, the above test passes.
>     
>     Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>     Reported-by: Uladzislau Rezki <urezki@gmail.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Hmm, I wonder if this is what patchwork picked up regarding the
reported-by.

And I checked, it did not add the "Signed-off-by" from you to Masami's
patch ;-)

The dangers of posting patches in threads of other patches :-/

-- Steve
