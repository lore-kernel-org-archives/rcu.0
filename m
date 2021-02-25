Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63558C433E6
	for <rcu@archiver.kernel.org>; Thu, 25 Feb 2021 15:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28E0764F27
	for <rcu@archiver.kernel.org>; Thu, 25 Feb 2021 15:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhBYPso (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 25 Feb 2021 10:48:44 -0500
Received: from mail.efficios.com ([167.114.26.124]:56058 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbhBYPsQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 25 Feb 2021 10:48:16 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id A61A531D38F;
        Thu, 25 Feb 2021 10:47:33 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id FwTvnPePBsJb; Thu, 25 Feb 2021 10:47:33 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3325731DCA8;
        Thu, 25 Feb 2021 10:47:33 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3325731DCA8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1614268053;
        bh=Dwsmhua/nRZFvhh4nU5tUhxY4iuNco/M6opv1tYMNFM=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ClzkcOdTtrGLQWqjYN8LyN8LNZj89bbN+00UcIk6uA21XdXDIDjTcqRqWcU2iyBYl
         CPyp3tl1mv5q7a8W2YHCAEengUr1qnQuNDQjE6d90qjTb98y+QB74UhN4k5JqbZpeN
         tboVmwtKvw9eBpAzdrOFRLIMPzhYg2KYcdX4Xc3ezqdj0P5CXxtb8L2WG3yTj1jdt+
         vdu82Nn0jVG8/3bCPTdOWhmhOiK98CW4iOOa03WaEwrEtr61vNJzGwvB6lfb8x91Tk
         7XndXyE6XQdtePWn+0nX9CU5j66QkBiVZUrIYaCRbttU+5qmt5AH+hXStGGovfMSH5
         Zl0QjKpEYV31A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rVclInozgsqV; Thu, 25 Feb 2021 10:47:33 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 1B9D831DCA7;
        Thu, 25 Feb 2021 10:47:33 -0500 (EST)
Date:   Thu, 25 Feb 2021 10:47:32 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     paulmck <paulmck@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        rcu <rcu@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>
Message-ID: <47558398.5024.1614268052985.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210225153656.GQ2743@paulmck-ThinkPad-P72>
References: <354598689.4868.1614262968890.JavaMail.zimbra@efficios.com> <20210225153656.GQ2743@paulmck-ThinkPad-P72>
Subject: Re: tasks-trace RCU: question about grace period forward progress
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF86 (Linux)/8.8.15_GA_4007)
Thread-Topic: tasks-trace RCU: question about grace period forward progress
Thread-Index: pwK/WXjIrT7rEqZmBrlQyKVe9bflUA==
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

----- On Feb 25, 2021, at 10:36 AM, paulmck paulmck@kernel.org wrote:

> On Thu, Feb 25, 2021 at 09:22:48AM -0500, Mathieu Desnoyers wrote:
>> Hi Paul,
>> 
>> Answering a question from Peter on IRC got me to look at rcu_read_lock_trace(),
>> and I see this:
>> 
>> static inline void rcu_read_lock_trace(void)
>> {
>>         struct task_struct *t = current;
>> 
>>         WRITE_ONCE(t->trc_reader_nesting, READ_ONCE(t->trc_reader_nesting) + 1);
>>         barrier();
>>         if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB) &&
>>             t->trc_reader_special.b.need_mb)
>>                 smp_mb(); // Pairs with update-side barriers
>>         rcu_lock_acquire(&rcu_trace_lock_map);
>> }
>> 
>> static inline void rcu_read_unlock_trace(void)
>> {
>>         int nesting;
>>         struct task_struct *t = current;
>> 
>>         rcu_lock_release(&rcu_trace_lock_map);
>>         nesting = READ_ONCE(t->trc_reader_nesting) - 1;
>>         barrier(); // Critical section before disabling.
>>         // Disable IPI-based setting of .need_qs.
>>         WRITE_ONCE(t->trc_reader_nesting, INT_MIN);
>>         if (likely(!READ_ONCE(t->trc_reader_special.s)) || nesting) {
>>                 WRITE_ONCE(t->trc_reader_nesting, nesting);
>>                 return;  // We assume shallow reader nesting.
>>         }
>>         rcu_read_unlock_trace_special(t, nesting);
>> }
>> 
>> AFAIU, each thread keeps track of whether it is nested within a RCU read-side
>> critical
>> section with a counter, and grace periods iterate over all threads to make sure
>> they
>> are not within a read-side critical section before they can complete:
>> 
>> # define rcu_tasks_trace_qs(t)                                          \
>>         do {                                                            \
>>                 if (!likely(READ_ONCE((t)->trc_reader_checked)) &&      \
>>                     !unlikely(READ_ONCE((t)->trc_reader_nesting))) {    \
>>                         smp_store_release(&(t)->trc_reader_checked, true); \
>>                         smp_mb(); /* Readers partitioned by store. */   \
>>                 }                                                       \
>>         } while (0)
>> 
>> It reminds me of the liburcu urcu-mb flavor which also deals with per-thread
>> state to track whether threads are nested within a critical section:
>> 
>> https://github.com/urcu/userspace-rcu/blob/master/include/urcu/static/urcu-mb.h#L90
>> https://github.com/urcu/userspace-rcu/blob/master/include/urcu/static/urcu-mb.h#L125
>> 
>> static inline void _urcu_mb_read_lock_update(unsigned long tmp)
>> {
>> 	if (caa_likely(!(tmp & URCU_GP_CTR_NEST_MASK))) {
>> 		_CMM_STORE_SHARED(URCU_TLS(urcu_mb_reader).ctr,
>> 		_CMM_LOAD_SHARED(urcu_mb_gp.ctr));
>> 		cmm_smp_mb();
>> 	} else
>> 		_CMM_STORE_SHARED(URCU_TLS(urcu_mb_reader).ctr, tmp + URCU_GP_COUNT);
>> }
>> 
>> static inline void _urcu_mb_read_lock(void)
>> {
>> 	unsigned long tmp;
>> 
>> 	urcu_assert(URCU_TLS(urcu_mb_reader).registered);
>> 	cmm_barrier();
>> 	tmp = URCU_TLS(urcu_mb_reader).ctr;
>> 	urcu_assert((tmp & URCU_GP_CTR_NEST_MASK) != URCU_GP_CTR_NEST_MASK);
>> 	_urcu_mb_read_lock_update(tmp);
>> }
>> 
>> The main difference between the two algorithm is that task-trace within the
>> kernel lacks the global "urcu_mb_gp.ctr" state snapshot, which is either
>> incremented or flipped between 0 and 1 by the grace period. This allow RCU
>> readers
>> outermost nesting starting after the beginning of the grace period not to
>> prevent
>> progress of the grace period.
>> 
>> Without this, a steady flow of incoming tasks-trace-RCU readers can prevent the
>> grace period from ever completing.
>> 
>> Or is this handled in a clever way that I am missing here ?
> 
> There are several mechanisms designed to handle this.  The following
> paragraphs describe these at a high level.
> 
> The trc_wait_for_one_reader() is invoked on each task.  It uses the
> try_invoke_on_locked_down_task(), which, if the task is currently not
> running, keeps it that way and invokes trc_inspect_reader().  If the
> locked-down task is in a read-side critical section, the need_qs field
> is set, which will cause the task's next rcu_read_lock_trace() to report
> the quiescent state.

I suspect you meant "rcu_read_unlock_trace()" here.

> 
> If read-side memory barriers have been enabled, trc_inspect_reader()
> is able to check for a reader being active, and if not, reports the
> quiescent state.  If there is a reader, trc_inspect_reader() reports
> failure, which is another path to the following paragraph.
> 
> If the task could not be locked down due its currently running,
> then trc_wait_for_one_reader() attempts to send an IPI, which results in
> trc_read_check_handler() rechecking for a read-side critical section
> and either reporting the quiescent state immediately or proceding in the
> same way that trc_inspect_reader() does.  The trc_read_check_handler()
> of course checks to make sure that the target task is still running
> before doing anything.  If the attempt to send the IPI fails, then
> the task is rechecked in a later pass.
> 
> So what sequence of events did you find that causes these mechanisms
> to fail?

The explanation you provide takes care of my concerns, so I don't have
any remaining problematic scenario in mind.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
