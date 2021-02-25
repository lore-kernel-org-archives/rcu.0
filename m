Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6473C433DB
	for <rcu@archiver.kernel.org>; Thu, 25 Feb 2021 14:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68D7F64EB7
	for <rcu@archiver.kernel.org>; Thu, 25 Feb 2021 14:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhBYOXd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 25 Feb 2021 09:23:33 -0500
Received: from mail.efficios.com ([167.114.26.124]:41660 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhBYOXb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 25 Feb 2021 09:23:31 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 5D5EC31D705;
        Thu, 25 Feb 2021 09:22:49 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id CMvxleI3lHWk; Thu, 25 Feb 2021 09:22:49 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 0C8DC31D1E6;
        Thu, 25 Feb 2021 09:22:49 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 0C8DC31D1E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1614262969;
        bh=5AwSGkef8Ae6ouZFtUD3Z4g5cvPxFOrSreD0Z5ZT0qE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=gBXS4nZ5ux9HdD46OZFPd1jeEGi+TI4iwr1a8g3NC3dh01zPWLs+bc8oaa3D4GsXn
         98n5kwBfkTaLdX/gpF/s9JeDUtLgbgEzQaHP9o6PwlrakRdOcYnNImPO214/xCn3S7
         p5HjTpsjJZ30h5eaUCI9wUTID80E+gq3yh6XDT6sySXo48kWnkTF+BpfZKO5QG+YM2
         Ys7jA+xdqZKb4W3fE/qUT9NLs40aXRT+rRAxaqMZ1HdF4kU/tNaHjHcj8FeFsgOXLT
         ETmLpbNZsE2+OW7LfThj+VsKanYUx6p9QGa2OhMu8qIlAKpLzs8aXYQJGJU3eXs8VY
         TBPc6LJfqfDkA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pWsDtSoAVXZh; Thu, 25 Feb 2021 09:22:49 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id F24BA31D279;
        Thu, 25 Feb 2021 09:22:48 -0500 (EST)
Date:   Thu, 25 Feb 2021 09:22:48 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     paulmck <paulmck@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        rcu <rcu@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>
Message-ID: <354598689.4868.1614262968890.JavaMail.zimbra@efficios.com>
Subject: tasks-trace RCU: question about grace period forward progress
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF86 (Linux)/8.8.15_GA_4007)
Thread-Index: sSG7Ub40qB4Id9CUEFqvfU2H9yo9Lg==
Thread-Topic: tasks-trace RCU: question about grace period forward progress
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul,

Answering a question from Peter on IRC got me to look at rcu_read_lock_trace(), and I see this:

static inline void rcu_read_lock_trace(void)
{
        struct task_struct *t = current;

        WRITE_ONCE(t->trc_reader_nesting, READ_ONCE(t->trc_reader_nesting) + 1);
        barrier();
        if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB) &&
            t->trc_reader_special.b.need_mb)
                smp_mb(); // Pairs with update-side barriers
        rcu_lock_acquire(&rcu_trace_lock_map);
}

static inline void rcu_read_unlock_trace(void)
{
        int nesting;
        struct task_struct *t = current;

        rcu_lock_release(&rcu_trace_lock_map);
        nesting = READ_ONCE(t->trc_reader_nesting) - 1;
        barrier(); // Critical section before disabling.
        // Disable IPI-based setting of .need_qs.
        WRITE_ONCE(t->trc_reader_nesting, INT_MIN);
        if (likely(!READ_ONCE(t->trc_reader_special.s)) || nesting) {
                WRITE_ONCE(t->trc_reader_nesting, nesting);
                return;  // We assume shallow reader nesting.
        }
        rcu_read_unlock_trace_special(t, nesting);
}

AFAIU, each thread keeps track of whether it is nested within a RCU read-side critical
section with a counter, and grace periods iterate over all threads to make sure they
are not within a read-side critical section before they can complete:

# define rcu_tasks_trace_qs(t)                                          \
        do {                                                            \
                if (!likely(READ_ONCE((t)->trc_reader_checked)) &&      \
                    !unlikely(READ_ONCE((t)->trc_reader_nesting))) {    \
                        smp_store_release(&(t)->trc_reader_checked, true); \
                        smp_mb(); /* Readers partitioned by store. */   \
                }                                                       \
        } while (0)

It reminds me of the liburcu urcu-mb flavor which also deals with per-thread
state to track whether threads are nested within a critical section:

https://github.com/urcu/userspace-rcu/blob/master/include/urcu/static/urcu-mb.h#L90
https://github.com/urcu/userspace-rcu/blob/master/include/urcu/static/urcu-mb.h#L125

static inline void _urcu_mb_read_lock_update(unsigned long tmp)
{
	if (caa_likely(!(tmp & URCU_GP_CTR_NEST_MASK))) {
		_CMM_STORE_SHARED(URCU_TLS(urcu_mb_reader).ctr, _CMM_LOAD_SHARED(urcu_mb_gp.ctr));
		cmm_smp_mb();
	} else
		_CMM_STORE_SHARED(URCU_TLS(urcu_mb_reader).ctr, tmp + URCU_GP_COUNT);
}

static inline void _urcu_mb_read_lock(void)
{
	unsigned long tmp;

	urcu_assert(URCU_TLS(urcu_mb_reader).registered);
	cmm_barrier();
	tmp = URCU_TLS(urcu_mb_reader).ctr;
	urcu_assert((tmp & URCU_GP_CTR_NEST_MASK) != URCU_GP_CTR_NEST_MASK);
	_urcu_mb_read_lock_update(tmp);
}

The main difference between the two algorithm is that task-trace within the
kernel lacks the global "urcu_mb_gp.ctr" state snapshot, which is either
incremented or flipped between 0 and 1 by the grace period. This allow RCU readers
outermost nesting starting after the beginning of the grace period not to prevent
progress of the grace period.

Without this, a steady flow of incoming tasks-trace-RCU readers can prevent the
grace period from ever completing.

Or is this handled in a clever way that I am missing here ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
