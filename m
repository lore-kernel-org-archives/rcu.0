Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D3CC433B4
	for <rcu@archiver.kernel.org>; Thu, 13 May 2021 17:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DD0161106
	for <rcu@archiver.kernel.org>; Thu, 13 May 2021 17:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhEMRu3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 13 May 2021 13:50:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230262AbhEMRu2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 13 May 2021 13:50:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7A0E613CB;
        Thu, 13 May 2021 17:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620928158;
        bh=oJiCrKtQ6fV0+/s+FJKcfvJjceDGTVwAVqgQY2Mrxjw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f+nRTCJ/d1mYC8KPVjToy47q26Q9FNOY+l1GOn7LfxLkaDpac6GkiCpOt3B1wpvj6
         PIfNPy2ce4xRs7UFWFcZ8q520A/77uXWVTh8cIfRt/OeAkR7Tv0MgCAUi2Mv7WD2zd
         SfC0+aN6EuUX8E+H2D3NYlaumL9Gvvhm9Vg9O+Kkkjh2Fpca2ffRv7W8Xvzex70qWv
         +/5rp7sg9K0OhRzkeRC0KZbdF5Ac3W6fYeq7k8524OUsJYfRw507XBkfPvMMuKZx06
         xKqhrHufsXOg+QUufiUVniBeZqoAkeZdGPD7fv+r/xPNX5lLqFogfODghaMIOPPDMR
         r6XTK57LzYaZg==
Date:   Fri, 14 May 2021 02:49:12 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Subject: Re: [PATCH tip/core/rcu 3/4] rcu-tasks: Make ksoftirqd provide RCU
 Tasks quiescent states
Message-Id: <20210514024912.a38f755add13a0f1dc73395a@kernel.org>
In-Reply-To: <20210513142110.GY975577@paulmck-ThinkPad-P17-Gen-1>
References: <20210512182747.3445812-4-paulmck@kernel.org>
        <20210513155417.93ab2299139ba35025ec8ef7@kernel.org>
        <20210513142110.GY975577@paulmck-ThinkPad-P17-Gen-1>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, 13 May 2021 07:21:10 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Thu, May 13, 2021 at 03:54:17PM +0900, Masami Hiramatsu wrote:
> > Hi Paul,
> > 
> > On Wed, 12 May 2021 11:27:46 -0700
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > 
> > > Heavy networking load can cause a CPU to execute continuously and
> > > indefinitely within ksoftirqd, in which case there will be no voluntary
> > > task switches and thus no RCU-tasks quiescent states.  This commit
> > > therefore causes the exiting rcu_softirq_qs() to provide an RCU-tasks
> > > quiescent state.
> > > 
> > > This of course means that __do_softirq() and its callers cannot be
> > > invoked from within a tracing trampoline.
> > 
> > I would like to confirm that you mean "tracing trampoline" here is
> > the code on the trampoline buffer, not the handler code which is
> > invoked from the trampoline buffer but it is protected by preempt_disable(),
> > am I understand correctly?
> 
> Maybe?  ;-)
> 
> If the handler code is invoked from the trampoline buffer, but
> returns somewhere else, then it is OK for the handler code to invoke
> __do_softirq() or its callers.
> 
> In addition, if the handler code is invoked from the trampoline buffer is
> guaranteed never to be running in the context of the ksoftirqd kthread,
> then it is also OK for the handler code to invoke __do_softirq() or
> its callers.
> 
> Otherwise, if the handler code might return back into the trampoline
> buffer and if that code might be running in the context of the ksoftirqd
> kthread, invoking __do_softirq() or one of its callers could result in
> the trampoline buffer no longer being there when it was returned to.

Hmm, the optprobe may be involved in this case. It always return to
the trampoline and handler does not disable irqs (only disable preempt).
BTW, what will call the __do_softirq()? Is hardirq safe?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
