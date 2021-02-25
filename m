Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C828C433E6
	for <rcu@archiver.kernel.org>; Thu, 25 Feb 2021 15:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA92664F18
	for <rcu@archiver.kernel.org>; Thu, 25 Feb 2021 15:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbhBYPhv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 25 Feb 2021 10:37:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:47490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229845AbhBYPhm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 25 Feb 2021 10:37:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EDB6064F18;
        Thu, 25 Feb 2021 15:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614267417;
        bh=R9Eli10YzCndqU6U2LM2gvyN/iGDTqc7Fi1pRuQc29Y=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gfUCy4c1sOJt8Yw1kEIW/0vTs3dBNXfS9foDT7pqpIX4xhWExIm8/E8Rjum7C4mBl
         ZpQPlUOKEFTQj/ziCDn+kSkADPjtowHiDwXTpmpmiNFBAXkRzJZUXoWKYhSbxuElWl
         lq06h2+1AmGhLujNYECFQ4mgu9fCVJMuMc1Yc2+hw6M3bEZBz91iIz+YeTo3EVCZPl
         wMXsQL0rFd+R3j3/e75KDyc8QJh9fCuuEiFpMW/TuP5KJ3s2+zwAtqw+21TO8DhQFE
         DureyLVKyUYnzdsLlsVCSMy0cZP/Ef7LftJI/MMjOOnSskc90U4d3cV+BpsKzldezZ
         zhiqx+P21AsWg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7F2DD35227D5; Thu, 25 Feb 2021 07:36:56 -0800 (PST)
Date:   Thu, 25 Feb 2021 07:36:56 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        rcu <rcu@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>
Subject: Re: tasks-trace RCU: question about grace period forward progress
Message-ID: <20210225153656.GQ2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <354598689.4868.1614262968890.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <354598689.4868.1614262968890.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Feb 25, 2021 at 09:22:48AM -0500, Mathieu Desnoyers wrote:
> Hi Paul,
> 
> Answering a question from Peter on IRC got me to look at rcu_read_lock_trace(), and I see this:
> 
> static inline void rcu_read_lock_trace(void)
> {
>         struct task_struct *t = current;
> 
>         WRITE_ONCE(t->trc_reader_nesting, READ_ONCE(t->trc_reader_nesting) + 1);
>         barrier();
>         if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB) &&
>             t->trc_reader_special.b.need_mb)
>                 smp_mb(); // Pairs with update-side barriers
>         rcu_lock_acquire(&rcu_trace_lock_map);
> }
> 
> static inline void rcu_read_unlock_trace(void)
> {
>         int nesting;
>         struct task_struct *t = current;
> 
>         rcu_lock_release(&rcu_trace_lock_map);
>         nesting = READ_ONCE(t->trc_reader_nesting) - 1;
>         barrier(); // Critical section before disabling.
>         // Disable IPI-based setting of .need_qs.
>         WRITE_ONCE(t->trc_reader_nesting, INT_MIN);
>         if (likely(!READ_ONCE(t->trc_reader_special.s)) || nesting) {
>                 WRITE_ONCE(t->trc_reader_nesting, nesting);
>                 return;  // We assume shallow reader nesting.
>         }
>         rcu_read_unlock_trace_special(t, nesting);
> }
> 
> AFAIU, each thread keeps track of whether it is nested within a RCU read-side critical
> section with a counter, and grace periods iterate over all threads to make sure they
> are not within a read-side critical section before they can complete:
> 
> # define rcu_tasks_trace_qs(t)                                          \
>         do {                                                            \
>                 if (!likely(READ_ONCE((t)->trc_reader_checked)) &&      \
>                     !unlikely(READ_ONCE((t)->trc_reader_nesting))) {    \
>                         smp_store_release(&(t)->trc_reader_checked, true); \
>                         smp_mb(); /* Readers partitioned by store. */   \
>                 }                                                       \
>         } while (0)
> 
> It reminds me of the liburcu urcu-mb flavor which also deals with per-thread
> state to track whether threads are nested within a critical section:
> 
> https://github.com/urcu/userspace-rcu/blob/master/include/urcu/static/urcu-mb.h#L90
> https://github.com/urcu/userspace-rcu/blob/master/include/urcu/static/urcu-mb.h#L125
> 
> static inline void _urcu_mb_read_lock_update(unsigned long tmp)
> {
> 	if (caa_likely(!(tmp & URCU_GP_CTR_NEST_MASK))) {
> 		_CMM_STORE_SHARED(URCU_TLS(urcu_mb_reader).ctr, _CMM_LOAD_SHARED(urcu_mb_gp.ctr));
> 		cmm_smp_mb();
> 	} else
> 		_CMM_STORE_SHARED(URCU_TLS(urcu_mb_reader).ctr, tmp + URCU_GP_COUNT);
> }
> 
> static inline void _urcu_mb_read_lock(void)
> {
> 	unsigned long tmp;
> 
> 	urcu_assert(URCU_TLS(urcu_mb_reader).registered);
> 	cmm_barrier();
> 	tmp = URCU_TLS(urcu_mb_reader).ctr;
> 	urcu_assert((tmp & URCU_GP_CTR_NEST_MASK) != URCU_GP_CTR_NEST_MASK);
> 	_urcu_mb_read_lock_update(tmp);
> }
> 
> The main difference between the two algorithm is that task-trace within the
> kernel lacks the global "urcu_mb_gp.ctr" state snapshot, which is either
> incremented or flipped between 0 and 1 by the grace period. This allow RCU readers
> outermost nesting starting after the beginning of the grace period not to prevent
> progress of the grace period.
> 
> Without this, a steady flow of incoming tasks-trace-RCU readers can prevent the
> grace period from ever completing.
> 
> Or is this handled in a clever way that I am missing here ?

There are several mechanisms designed to handle this.  The following
paragraphs describe these at a high level.

The trc_wait_for_one_reader() is invoked on each task.  It uses the
try_invoke_on_locked_down_task(), which, if the task is currently not
running, keeps it that way and invokes trc_inspect_reader().  If the
locked-down task is in a read-side critical section, the need_qs field
is set, which will cause the task's next rcu_read_lock_trace() to report
the quiescent state.

If read-side memory barriers have been enabled, trc_inspect_reader()
is able to check for a reader being active, and if not, reports the
quiescent state.  If there is a reader, trc_inspect_reader() reports
failure, which is another path to the following paragraph.

If the task could not be locked down due its currently running,
then trc_wait_for_one_reader() attempts to send an IPI, which results in
trc_read_check_handler() rechecking for a read-side critical section
and either reporting the quiescent state immediately or proceding in the
same way that trc_inspect_reader() does.  The trc_read_check_handler()
of course checks to make sure that the target task is still running
before doing anything.  If the attempt to send the IPI fails, then
the task is rechecked in a later pass.

So what sequence of events did you find that causes these mechanisms
to fail?

							Thanx, Paul
