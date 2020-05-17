Return-Path: <SRS0=GvEc=67=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA61BC433E0
	for <rcu@archiver.kernel.org>; Sun, 17 May 2020 10:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9D4520657
	for <rcu@archiver.kernel.org>; Sun, 17 May 2020 10:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgEQK1a (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 17 May 2020 06:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgEQK1a (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 17 May 2020 06:27:30 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FC9C061A0C;
        Sun, 17 May 2020 03:27:29 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jaGVI-0001pW-Da; Sun, 17 May 2020 12:26:44 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id CBD0A100F17; Sun, 17 May 2020 12:26:43 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     paulmck@kernel.org,
        "Joel Fernandes \(Google\)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>, frextrite@gmail.com,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        madhuparnabhowmik04@gmail.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        peterz@infradead.org, Petr Mladek <pmladek@suse.com>,
        rcu@vger.kernel.org, rostedt@goodmis.org, vpillai@digitalocean.com
Subject: Re: [PATCH v3 0/5] RCU dyntick nesting counter cleanups for rcu -dev
In-Reply-To: <20200516171223.GC2639@paulmck-ThinkPad-P72>
References: <20200504120505.89351-1-joel@joelfernandes.org> <20200504171532.GR2869@paulmck-ThinkPad-P72> <20200504174413.GA8883@paulmck-ThinkPad-P72> <20200516171223.GC2639@paulmck-ThinkPad-P72>
Date:   Sun, 17 May 2020 12:26:43 +0200
Message-ID: <87wo5adfh8.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Paul,

"Paul E. McKenney" <paulmck@kernel.org> writes:
> And I have allegedly resolved the conflicts with Thomas's and Peter's
> series, or at least the noinstr-rcu-nmi-2020-05-15 branch of that series.
> At least one conflict was completely invisible to "git rebase" (but
> fortunately blindingly obvious to the compiler).  This naturally makes
> me suspect that additional adjustments might be needed.  Especially
> given that misplaced instrumentation_begin() and instrumentation_end()
> calls are invisible not only to the compiler, but also to rcutorture in
> my setup.  (For example, tracing before instrumentation_begin() or after
> instrumentation_end() is a bug.)

there is tooling to verify that. If you merge

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-v7-full

into your dev branch (trivial conflict) and after building it, run:

 objtool check -fal $BUILDIR/vmlinux.o

Note: This only covers built-in code. So if you have code you want to
check make sure it's not built as module.

Just did that and it complains about:

../build/vmlinux.o: warning: objtool: rcu_eqs_enter.constprop.0()+0xa9: call to rcu_preempt_deferred_qs() leaves .noinstr.text section

But that's even the case on my branch without your changes.

The call to rcu_preempt_deferred_qs() is definitely before
instrumentation_end() so this needs to be investigated on the objtool
side. Peter?

Thanks,

        tglx
