Return-Path: <SRS0=YclE=6B=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65C0C2D0EF
	for <rcu@archiver.kernel.org>; Fri, 17 Apr 2020 15:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD2D620857
	for <rcu@archiver.kernel.org>; Fri, 17 Apr 2020 15:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgDQPEs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 17 Apr 2020 11:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgDQPEs (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 17 Apr 2020 11:04:48 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39C0C061A0C
        for <rcu@vger.kernel.org>; Fri, 17 Apr 2020 08:04:47 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jPSXq-0001cE-9x; Fri, 17 Apr 2020 17:04:42 +0200
Date:   Fri, 17 Apr 2020 17:04:42 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, urezki@gmail.com
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200417150442.gyrxhjymvfwsvum5@linutronix.de>
References: <20200415160034.662274-2-bigeasy@linutronix.de>
 <20200416144254.GC90777@google.com>
 <20200416151824.a372pdiphube3x3l@linutronix.de>
 <20200416184112.GA149999@google.com>
 <20200416185934.GD149999@google.com>
 <20200416152623.48125628@gandalf.local.home>
 <20200416203637.GA176663@google.com>
 <20200416210057.GY17661@paulmck-ThinkPad-P72>
 <20200416213444.4cc6kzxmwl32s2eh@linutronix.de>
 <20200417030515.GE176663@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200417030515.GE176663@google.com>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2020-04-16 23:05:15 [-0400], Joel Fernandes wrote:
> On Thu, Apr 16, 2020 at 11:34:44PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2020-04-16 14:00:57 [-0700], Paul E. McKenney wrote:
> > > 
> > > We might need different calling-context restrictions for the two variants
> > > of kfree_rcu().  And we might need to come up with some sort of lockdep
> > > check for "safe to use normal spinlock in -rt".
> > 
> > Oh. We do have this already, it is called CONFIG_PROVE_RAW_LOCK_NESTING.
> > This one will scream if you do
> > 	raw_spin_lock();
> > 	spin_lock();
> > 
> > Sadly, as of today, there is code triggering this which needs to be
> > addressed first (but it is one list of things to do).
> > 
> > Given the thread so far, is it okay if I repost the series with
> > migrate_disable() instead of accepting a possible migration before
> > grabbing the lock? I would prefer to avoid the extra RT case (avoiding
> > memory allocations in a possible atomic context) until we get there.
> 
> I prefer something like the following to make it possible to invoke
> kfree_rcu() from atomic context considering call_rcu() is already callable
> from such contexts. Thoughts?

So it looks like it would work. However, could we please delay this
until we have an actual case on RT? I just added
	WARN_ON(!preemptible());

to kfree_call_rcu() on v5.6.4-rt4 and nothing triggered.

This is the list of users I had (just to figure out if this is used at
all):
- addrconf_ifdown
- cgroup_free
- cgroup_migrate_finish
- css_task_iter_end
- disk_expand_part_tbl
- drop_sysctl_table
- __hw_addr_flush
- inetdev_event
- ip6addrlbl_net_exit
- ip6addrlbl_net_exit
- ops_exit_list.isra.0
- rtnl_register_internal
- simple_set_acl
- swevent_hlist_put_cpu
- timerfd_release
- vfs_rename
- __xfs_set_acl

Sebastian
