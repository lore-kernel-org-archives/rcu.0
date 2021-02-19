Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD84DC433DB
	for <rcu@archiver.kernel.org>; Fri, 19 Feb 2021 19:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B67660235
	for <rcu@archiver.kernel.org>; Fri, 19 Feb 2021 19:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhBSTgv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 19 Feb 2021 14:36:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:58712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229649AbhBSTgu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 19 Feb 2021 14:36:50 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF98264E86;
        Fri, 19 Feb 2021 19:36:08 +0000 (UTC)
Date:   Fri, 19 Feb 2021 14:36:07 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
Message-ID: <20210219143607.3cdf9ed8@gandalf.local.home>
In-Reply-To: <161365856280.719838.12423085451287256713.stgit@devnote2>
References: <161365856280.719838.12423085451287256713.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, 18 Feb 2021 23:29:23 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Commit 36dadef23fcc ("kprobes: Init kprobes in early_initcall")
> moved the kprobe setup in early_initcall(), which includes kprobe
> jump optimization.
> The kprobes jump optimizer involves synchronize_rcu_tasks() which
> depends on the ksoftirqd and rcu_spawn_tasks_*(). However, since
> those are setup in core_initcall(), kprobes jump optimizer can not
> run at the early_initcall().
> 
> To avoid this issue, make the kprobe optimization disabled in the
> early_initcall() and enables it in subsys_initcall().
> 
> Note that non-optimized kprobes is still available after
> early_initcall(). Only jump optimization is delayed.
> 
> Fixes: 36dadef23fcc ("kprobes: Init kprobes in early_initcall")
> Reported-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>

I pulled this into my queue to be tested, and when that completes
(hopefully without failure), I'll add this to my pull request for the
current merge window (which I still need to send).

Thanks!

-- Steve
