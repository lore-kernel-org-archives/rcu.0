Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023E4C433DB
	for <rcu@archiver.kernel.org>; Fri, 19 Feb 2021 19:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B494E64E15
	for <rcu@archiver.kernel.org>; Fri, 19 Feb 2021 19:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhBSTPO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 19 Feb 2021 14:15:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:55682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229649AbhBSTPN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 19 Feb 2021 14:15:13 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F07464EB3;
        Fri, 19 Feb 2021 19:14:30 +0000 (UTC)
Date:   Fri, 19 Feb 2021 14:14:29 -0500
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
Message-ID: <20210219141429.53def012@gandalf.local.home>
In-Reply-To: <20210219181811.GY2743@paulmck-ThinkPad-P72>
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
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, 19 Feb 2021 10:18:11 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> We can further prevent entry into dyntick-idle state until
> the ksoftirqd kthreads have been spawned, which means that if softirq
> handlers must be deferred, they will be resumed within one jiffy by the
> next scheduler-clock interrupt.

Why not just prevent entry into dyntick-idle state until the system is
finished booting? As you said; There should be no latency-sensitive
applications running, until after we started the system.

-- Steve
