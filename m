Return-Path: <SRS0=YclE=6B=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65544C2D0EF
	for <rcu@archiver.kernel.org>; Fri, 17 Apr 2020 18:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D130206E9
	for <rcu@archiver.kernel.org>; Fri, 17 Apr 2020 18:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587149691;
	bh=EJ7wtzRb8W8avDmPClZ6n+yGNqscFVzhqtg5iPdWQX0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=guXX04oMk3AVapVfM6/S5B0i0cS4syEL6F9PVsQKBxLnKthK0PWuYrT3iyXcMTd8+
	 9owWshQafb/tiMxXWRH6FTYbiNeyxJ/wuVD20To1C5xrLAxqAifW2/C+T0T4gxo+N0
	 uSMH2AoCDBZ+0zZmkNwvbENTrxkj0nS0TTV9oVXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbgDQSyv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 17 Apr 2020 14:54:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726432AbgDQSyu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 17 Apr 2020 14:54:50 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2F3C2223C;
        Fri, 17 Apr 2020 18:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587149689;
        bh=EJ7wtzRb8W8avDmPClZ6n+yGNqscFVzhqtg5iPdWQX0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uNPEJQgQCOPaAmW5//a99tfg9elajp8rbSrVt1UVHKhkmTw5YCBinK3sQzRsK5zLb
         U8UbN/jkgDGHTmocm/kjYEI2pEM3OAqn9QWXc4nmx4lyXT4gpDZwFSoXaLWy8gZe5S
         y9uUBQBqExCgDEcgugt6R4hCgFlsMAHX6U1UL/+Q=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 79AE935233A2; Fri, 17 Apr 2020 11:54:49 -0700 (PDT)
Date:   Fri, 17 Apr 2020 11:54:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, urezki@gmail.com
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200417185449.GM17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200416151824.a372pdiphube3x3l@linutronix.de>
 <20200416184112.GA149999@google.com>
 <20200416185934.GD149999@google.com>
 <20200416152623.48125628@gandalf.local.home>
 <20200416203637.GA176663@google.com>
 <20200416210057.GY17661@paulmck-ThinkPad-P72>
 <20200416213444.4cc6kzxmwl32s2eh@linutronix.de>
 <20200417030515.GE176663@google.com>
 <20200417150442.gyrxhjymvfwsvum5@linutronix.de>
 <20200417182641.GB168907@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417182641.GB168907@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Apr 17, 2020 at 02:26:41PM -0400, Joel Fernandes wrote:
> On Fri, Apr 17, 2020 at 05:04:42PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2020-04-16 23:05:15 [-0400], Joel Fernandes wrote:
> > > On Thu, Apr 16, 2020 at 11:34:44PM +0200, Sebastian Andrzej Siewior wrote:
> > > > On 2020-04-16 14:00:57 [-0700], Paul E. McKenney wrote:
> > > > > 
> > > > > We might need different calling-context restrictions for the two variants
> > > > > of kfree_rcu().  And we might need to come up with some sort of lockdep
> > > > > check for "safe to use normal spinlock in -rt".
> > > > 
> > > > Oh. We do have this already, it is called CONFIG_PROVE_RAW_LOCK_NESTING.
> > > > This one will scream if you do
> > > > 	raw_spin_lock();
> > > > 	spin_lock();
> > > > 
> > > > Sadly, as of today, there is code triggering this which needs to be
> > > > addressed first (but it is one list of things to do).
> > > > 
> > > > Given the thread so far, is it okay if I repost the series with
> > > > migrate_disable() instead of accepting a possible migration before
> > > > grabbing the lock? I would prefer to avoid the extra RT case (avoiding
> > > > memory allocations in a possible atomic context) until we get there.
> > > 
> > > I prefer something like the following to make it possible to invoke
> > > kfree_rcu() from atomic context considering call_rcu() is already callable
> > > from such contexts. Thoughts?
> > 
> > So it looks like it would work. However, could we please delay this
> > until we have an actual case on RT? I just added
> > 	WARN_ON(!preemptible());
> 
> I am not sure if waiting for it to break in the future is a good idea. I'd
> rather design it in a forward thinking way. There could be folks replacing
> "call_rcu() + kfree in a callback" with kfree_rcu() for example. If they were
> in !preemptible(), we'd break on page allocation.
> 
> Also as a sidenote, the additional pre-allocation of pages that Vlad is
> planning on adding would further reduce the need for pages from the page
> allocator.
> 
> Paul, what is your opinion on this?

My experience with call_rcu(), of which kfree_rcu() is a specialization,
is that it gets invoked with preemption disabled, with interrupts
disabled, and during early boot, as in even before rcu_init() has been
invoked.  This experience does make me lean towards raw spinlocks.

But to Sebastian's point, if we are going to use raw spinlocks, we need
to keep the code paths holding those spinlocks as short as possible.
I suppose that the inability to allocate memory with raw spinlocks held
helps, but it is worth checking.

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> > 
> > to kfree_call_rcu() on v5.6.4-rt4 and nothing triggered.
> > 
> > This is the list of users I had (just to figure out if this is used at
> > all):
> > - addrconf_ifdown
> > - cgroup_free
> > - cgroup_migrate_finish
> > - css_task_iter_end
> > - disk_expand_part_tbl
> > - drop_sysctl_table
> > - __hw_addr_flush
> > - inetdev_event
> > - ip6addrlbl_net_exit
> > - ip6addrlbl_net_exit
> > - ops_exit_list.isra.0
> > - rtnl_register_internal
> > - simple_set_acl
> > - swevent_hlist_put_cpu
> > - timerfd_release
> > - vfs_rename
> > - __xfs_set_acl
> > 
> > Sebastian
