Return-Path: <SRS0=HuQd=5F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB136C4332D
	for <rcu@archiver.kernel.org>; Fri, 20 Mar 2020 19:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B833A20739
	for <rcu@archiver.kernel.org>; Fri, 20 Mar 2020 19:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584731681;
	bh=hYZPv/s3zHSOCzc894+itwpGI/83A+dyfFG4Q+wXZ44=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=cQh7DxXgtCTXOrMtawXCvGtKoJzTKW44FHJMSrzI7RRtzmiFrXqgCezwY8GXQKRb+
	 kGT6CtzEsPSFj4ATolqoFhNrUnUWldJV75rZkiPY6vf8uZXuiMMJ8uzeR7ewfJVZsa
	 s26d63MjzT5P4YkgpP+87t70G8i+CU67pJoPrIdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgCTTOl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 20 Mar 2020 15:14:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbgCTTOk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 20 Mar 2020 15:14:40 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1973720775;
        Fri, 20 Mar 2020 19:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584731679;
        bh=hYZPv/s3zHSOCzc894+itwpGI/83A+dyfFG4Q+wXZ44=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NbhvTVIBn5tozA14O5JR0yx4ULvUgTdmRwrkaeKCXs7/DHD99j7+o0lujjk2BNCgB
         aja8dXQbPcUJ6/hzP7WeuuikfcAW/XuZ0L9IPx4P9GSKgfj+tmSONaP28YddMDy8ag
         SpRSXwwpr5kxMg5OLlzts0GOUX6yiwC7ywaQjkMg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D2F1235226B4; Fri, 20 Mar 2020 12:14:38 -0700 (PDT)
Date:   Fri, 20 Mar 2020 12:14:38 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH RFC v2 tip/core/rcu 04/22] rcu-tasks: Move Tasks RCU to
 its own file
Message-ID: <20200320191438.GS3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200319001024.GA28798@paulmck-ThinkPad-P72>
 <20200320071228.9740-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320071228.9740-1-hdanton@sina.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Mar 20, 2020 at 03:12:28PM +0800, Hillf Danton wrote:
> 
> On Wed, 18 Mar 2020 17:10:42 -0700 "Paul E. McKenney" wrote:
> > 
> > +/* RCU-tasks kthread that detects grace periods and invokes callbacks. */
> > +static int __noreturn rcu_tasks_kthread(void *arg)
> > +{
> > +	unsigned long flags;
> > +	struct task_struct *g, *t;
> > +	unsigned long lastreport;
> > +	struct rcu_head *list;
> > +	struct rcu_head *next;
> > +	LIST_HEAD(rcu_tasks_holdouts);
> > +	int fract;
> > +
> > +	/* Run on housekeeping CPUs by default.  Sysadm can move if desired. */
> > +	housekeeping_affine(current, HK_FLAG_RCU);
> > +
> > +	/*
> > +	 * Each pass through the following loop makes one check for
> > +	 * newly arrived callbacks, and, if there are some, waits for
> > +	 * one RCU-tasks grace period and then invokes the callbacks.
> > +	 * This loop is terminated by the system going down.  ;-)
> > +	 */
> > +	for (;;) {
> > +
> > +		/* Pick up any new callbacks. */
> > +		raw_spin_lock_irqsave(&rcu_tasks_cbs_lock, flags);
> > +		list = rcu_tasks_cbs_head;
> > +		rcu_tasks_cbs_head = NULL;
> > +		rcu_tasks_cbs_tail = &rcu_tasks_cbs_head;
> > +		raw_spin_unlock_irqrestore(&rcu_tasks_cbs_lock, flags);
> > +
> > +		/* If there were none, wait a bit and start over. */
> > +		if (!list) {
> > +			wait_event_interruptible(rcu_tasks_cbs_wq,
> > +						 READ_ONCE(rcu_tasks_cbs_head));
> > +			if (!rcu_tasks_cbs_head) {
> > +				WARN_ON(signal_pending(current));
> > +				schedule_timeout_interruptible(HZ/10);
> > +			}
> > +			continue;
> > +		}
> > +
> > +		/*
> > +		 * Wait for all pre-existing t->on_rq and t->nvcsw
> > +		 * transitions to complete.  Invoking synchronize_rcu()
> > +		 * suffices because all these transitions occur with
> > +		 * interrupts disabled.  Without this synchronize_rcu(),
> > +		 * a read-side critical section that started before the
> > +		 * grace period might be incorrectly seen as having started
> > +		 * after the grace period.
> > +		 *
> > +		 * This synchronize_rcu() also dispenses with the
> > +		 * need for a memory barrier on the first store to
> > +		 * ->rcu_tasks_holdout, as it forces the store to happen
> > +		 * after the beginning of the grace period.
> > +		 */
> > +		synchronize_rcu();
> > +
> > +		/*
> > +		 * There were callbacks, so we need to wait for an
> > +		 * RCU-tasks grace period.  Start off by scanning
> > +		 * the task list for tasks that are not already
> > +		 * voluntarily blocked.  Mark these tasks and make
> > +		 * a list of them in rcu_tasks_holdouts.
> > +		 */
> > +		rcu_read_lock();
> > +		for_each_process_thread(g, t) {
> > +			if (t != current && READ_ONCE(t->on_rq) &&
> > +			    !is_idle_task(t)) {
> > +				get_task_struct(t);
> > +				t->rcu_tasks_nvcsw = READ_ONCE(t->nvcsw);
> > +				WRITE_ONCE(t->rcu_tasks_holdout, true);
> > +				list_add(&t->rcu_tasks_holdout_list,
> > +					 &rcu_tasks_holdouts);
> > +			}
> > +		}
> 
> Nit: report stall if it would take a jiffy longer than
> rcu_task_stall_timeout to collect the tasks?

Fair point!

That said, the wait time below is in hundreds of milliseconds and the
stall time defaults to ten minutes, so it is not clear that such a check
out constitute non-dead code.

							Thanx, Paul

> > +		rcu_read_unlock();
> > +
> > +		/*
> > +		 * Wait for tasks that are in the process of exiting.
> > +		 * This does only part of the job, ensuring that all
> > +		 * tasks that were previously exiting reach the point
> > +		 * where they have disabled preemption, allowing the
> > +		 * later synchronize_rcu() to finish the job.
> > +		 */
> > +		synchronize_srcu(&tasks_rcu_exit_srcu);
> > +
> > +		/*
> > +		 * Each pass through the following loop scans the list
> > +		 * of holdout tasks, removing any that are no longer
> > +		 * holdouts.  When the list is empty, we are done.
> > +		 */
> > +		lastreport = jiffies;
> > +
> > +		/* Start off with HZ/10 wait and slowly back off to 1 HZ wait*/
> > +		fract = 10;
> > +
> > +		for (;;) {
> > +			bool firstreport;
> > +			bool needreport;
> > +			int rtst;
> > +			struct task_struct *t1;
> > +
> > +			if (list_empty(&rcu_tasks_holdouts))
> > +				break;
> > +
> > +			/* Slowly back off waiting for holdouts */
> > +			schedule_timeout_interruptible(HZ/fract);
> > +
> > +			if (fract > 1)
> > +				fract--;
> > +
> > +			rtst = READ_ONCE(rcu_task_stall_timeout);
> > +			needreport = rtst > 0 &&
> > +				     time_after(jiffies, lastreport + rtst);
> > +			if (needreport)
> > +				lastreport = jiffies;
> > +			firstreport = true;
> > +			WARN_ON(signal_pending(current));
> > +			list_for_each_entry_safe(t, t1, &rcu_tasks_holdouts,
> > +						rcu_tasks_holdout_list) {
> > +				check_holdout_task(t, needreport, &firstreport);
> > +				cond_resched();
> > +			}
> > +		}
> > +
> > +		/*
> > +		 * Because ->on_rq and ->nvcsw are not guaranteed
> > +		 * to have a full memory barriers prior to them in the
> > +		 * schedule() path, memory reordering on other CPUs could
> > +		 * cause their RCU-tasks read-side critical sections to
> > +		 * extend past the end of the grace period.  However,
> > +		 * because these ->nvcsw updates are carried out with
> > +		 * interrupts disabled, we can use synchronize_rcu()
> > +		 * to force the needed ordering on all such CPUs.
> > +		 *
> > +		 * This synchronize_rcu() also confines all
> > +		 * ->rcu_tasks_holdout accesses to be within the grace
> > +		 * period, avoiding the need for memory barriers for
> > +		 * ->rcu_tasks_holdout accesses.
> > +		 *
> > +		 * In addition, this synchronize_rcu() waits for exiting
> > +		 * tasks to complete their final preempt_disable() region
> > +		 * of execution, cleaning up after the synchronize_srcu()
> > +		 * above.
> > +		 */
> > +		synchronize_rcu();
> > +
> > +		/* Invoke the callbacks. */
> > +		while (list) {
> > +			next = list->next;
> > +			local_bh_disable();
> > +			list->func(list);
> > +			local_bh_enable();
> > +			list = next;
> > +			cond_resched();
> > +		}
> > +		/* Paranoid sleep to keep this from entering a tight loop */
> > +		schedule_timeout_uninterruptible(HZ/10);
> > +	}
> > +}
> 
