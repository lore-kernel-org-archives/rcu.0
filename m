Return-Path: <SRS0=pJ0D=6A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDD1C2BB55
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 17:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 396C321924
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 17:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587058137;
	bh=e3OIDoAaKmgA2ORluDa3a3MNLCtioUGirSBq647ozkY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=JsnTSxuh4jWt8Y2CDU7uJTevnzgSOhFP/4E9RBsCDt5+5MRkKkgp/DyuF0noC/64X
	 1YARH3V8rd8fugxi1WqY5eV8/6wtGqpmI30pxm7jcIbWdWmx1eBAZ2jyHFPJm76Vcl
	 8r9RUju9T/TIyiqsS+1r3RRaoID1aT4/yN4bmsjo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404789AbgDPR24 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Apr 2020 13:28:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394077AbgDPR2z (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Apr 2020 13:28:55 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 865102076D;
        Thu, 16 Apr 2020 17:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587058134;
        bh=e3OIDoAaKmgA2ORluDa3a3MNLCtioUGirSBq647ozkY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=y8sDkI0fQgZtC53jJUi0BSKOUlRrDx1aCaT1DIx6BKufmn0SifdikzsRXPNIsRl9N
         lkm2Ojv8Ce9sstHWLUuPHTkiVlUPt14jrIB/KddxzkZikx1EVeuMfprUgGlFN/lApS
         ox8QCXoSykPsKJnq1EWssR2zTf4NjdHoKwPdSFxY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5306C35226A9; Thu, 16 Apr 2020 10:28:54 -0700 (PDT)
Date:   Thu, 16 Apr 2020 10:28:54 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200416172854.GQ17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200415160034.662274-2-bigeasy@linutronix.de>
 <20200416144254.GC90777@google.com>
 <20200416150038.GA7772@pc636>
 <20200416152027.wkpxr2fvuf4jkgct@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416152027.wkpxr2fvuf4jkgct@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 16, 2020 at 05:20:27PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-04-16 17:01:43 [+0200], Uladzislau Rezki wrote:
> > > > @@ -3139,10 +3136,8 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > >  	unsigned long flags;
> > > >  	struct kfree_rcu_cpu *krcp;
> > > >  
> > > > -	local_irq_save(flags);	// For safely calling this_cpu_ptr().
> > > > -	krcp = this_cpu_ptr(&krc);
> > > > -	if (krcp->initialized)
> > > > -		spin_lock(&krcp->lock);
> > > > +	krcp = raw_cpu_ptr(&krc);
> > > > +	spin_lock_irqsave(&krcp->lock, flags);
> > > 
> > It is not a good way to access to per-CPU variable. There is a race in
> > your code. So, we will rework it anyway soon. To guarantee that we stay
> > on the same CPU, first we disable IRQ's then we access per-CPU var and
> > take a spinlock.
> 
> What is the worst thing that can happen if a CPU migration happens
> between raw_cpu_ptr() and spin_lock_irqsave() ?

In the general case, not necessarily relevant to this code, one scenario
requiring this sort of thing is where the critical section needs access
to per-CPU data that cannot be accessed off-CPU, but needs to update
data that is protected by a per-CPU lock.  This works well when the
data is frequently accessed by its own CPU, but nevertheless might be
accessed at any time by some other CPU.

Perhaps it is better to think of this as a specialized reader-writer
lock protecting per-CPU data.  A given CPU is always permitted to read
its own data, as is any CPU holding that CPU's lock.  To update its own
data, a CPU must hold its own lock.

Of course, readers in reader-writer locking often do updates.  Given that
caveat, an example of this pattern may be found in RCU's note_gp_changes()
function.

But RCU does plenty of acquisitions of irq-disabled locks where the task
might be migrated during acquisition, for one example, please see RCU's
rcu_report_qs_rdp() function.  This is admittedly strictly speaking not a
per-CPU case, but each rcu_node structure does have a subset of the CPUs
assigned to it, and it is quite possible that the task might migrate
to some CPU associated with some other rcu_node structure during the
lock acquisition.  That is OK, because the per-rcu_node data is strictly
protected by this per-rcu_node lock.

So, which category does kfree_call_rcu() fit into?

							Thanx, Paul
