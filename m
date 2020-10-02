Return-Path: <SRS0=VPhX=DJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50786C4363D
	for <rcu@archiver.kernel.org>; Fri,  2 Oct 2020 19:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16CEA20795
	for <rcu@archiver.kernel.org>; Fri,  2 Oct 2020 19:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601667257;
	bh=In5JbTWYeiRev+GIO/kfK+LZm4s3FAyuDAim/oahzDI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=reMZcTKoKq7aSpUBzTFzGhM19dMJjijDHkoQYK702GbNrsuWp6ArxivRRh6wJr42t
	 g68Uj+huZtzVPraNUgadkPQAs7xeU9tC3G0K7U41wTBIUY6j+sGFoLl6HZ/pYbvRl1
	 54am8y1FD8JJlzY9RyY734WtnDPGDs2paQT2rJHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgJBTeO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 2 Oct 2020 15:34:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387806AbgJBTeO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 2 Oct 2020 15:34:14 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A7CB20758;
        Fri,  2 Oct 2020 19:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601667253;
        bh=In5JbTWYeiRev+GIO/kfK+LZm4s3FAyuDAim/oahzDI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fcIkQQTVNZLNfACcV35+XzG2jQe0yqzDg/oCQb1adalSIFxRrBvz2aa7IzqVXu3e8
         xuNItn0sEdIjj7zsIYY9tqNdizs56VxCLFwTgUjaxIwsDFJzN+rOUaZFMEY3Pta8nQ
         UOuPpcU0RLyTAAb8lcdpkEJLv+w3I7LVqTLcxlec=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id EA38B35230A9; Fri,  2 Oct 2020 12:34:12 -0700 (PDT)
Date:   Fri, 2 Oct 2020 12:34:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Randy Dunlap <rdunlap@infradead.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 2/2] docs: Update RCU's hotplug requirements with a bit
 about design
Message-ID: <20201002193412.GJ29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200929192928.3749502-1-joel@joelfernandes.org>
 <20200929192928.3749502-2-joel@joelfernandes.org>
 <20200929193248.GA3749988@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929193248.GA3749988@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Sep 29, 2020 at 03:32:48PM -0400, Joel Fernandes wrote:
> Hi Paul,
> 
> On Tue, Sep 29, 2020 at 03:29:28PM -0400, Joel Fernandes (Google) wrote:
> > RCU's hotplug design will help understand the requirements an RCU
> > implementation needs to fullfill, such as dead-lock avoidance.
> > 
> > The rcu_barrier() section of the "Hotplug CPU" section already talks
> > about deadlocks, however the description of what else can deadlock other
> > than rcu_barrier is rather incomplete.
> > 
> > This commit therefore continues the section by describing how RCU's
> > design handles CPU hotplug in a deadlock-free way.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  .../RCU/Design/Requirements/Requirements.rst  | 30 +++++++++++++++++--
> >  1 file changed, 28 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
> > index 1ae79a10a8de..e0413aa989dd 100644
> > --- a/Documentation/RCU/Design/Requirements/Requirements.rst
> > +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
> > @@ -1929,8 +1929,10 @@ The Linux-kernel CPU-hotplug implementation has notifiers that are used
> >  to allow the various kernel subsystems (including RCU) to respond
> >  appropriately to a given CPU-hotplug operation. Most RCU operations may
> >  be invoked from CPU-hotplug notifiers, including even synchronous
> > -grace-period operations such as ``synchronize_rcu()`` and
> > -``synchronize_rcu_expedited()``.
> > +grace-period operations such as. However, the synchronous variants
> > +(``synchronize_rcu()`` and ``synchronize_rcu_expedited()``) should not
> > +from notifiers that execute via ``stop_machine()`` -- specifically those
> 
> The "should not from notifiers" should be "should not be used from
> notifiers" here. Sorry and hope you can fix it up.

Thank you, and queued for further review.  How does the below look
for a general fixup?

						Thanx, Paul

------------------------------------------------------------------------

commit a93716177eeac726037828b28e6b1a45e828688a
Author: Joel Fernandes (Google) <joel@joelfernandes.org>
Date:   Tue Sep 29 15:29:28 2020 -0400

    docs: Update RCU's hotplug requirements with a bit about design
    
    The rcu_barrier() section of the "Hotplug CPU" section discusses
    deadlocks, however the description of deadlocks other than those involving
    rcu_barrier() is rather incomplete.
    
    This commit therefore continues the section by describing how RCU's
    design handles CPU hotplug in a deadlock-free way.
    
    Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 1ae79a1..98557fe 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1929,16 +1929,45 @@ The Linux-kernel CPU-hotplug implementation has notifiers that are used
 to allow the various kernel subsystems (including RCU) to respond
 appropriately to a given CPU-hotplug operation. Most RCU operations may
 be invoked from CPU-hotplug notifiers, including even synchronous
-grace-period operations such as ``synchronize_rcu()`` and
-``synchronize_rcu_expedited()``.
-
-However, all-callback-wait operations such as ``rcu_barrier()`` are also
-not supported, due to the fact that there are phases of CPU-hotplug
-operations where the outgoing CPU's callbacks will not be invoked until
-after the CPU-hotplug operation ends, which could also result in
-deadlock. Furthermore, ``rcu_barrier()`` blocks CPU-hotplug operations
-during its execution, which results in another type of deadlock when
-invoked from a CPU-hotplug notifier.
+grace-period operations such as (``synchronize_rcu()`` and
+``synchronize_rcu_expedited()``).  However, these synchronous operations
+do block and therefore cannot be invoked from notifiers that execute via
+``stop_machine()``, specifically those between the ``CPUHP_AP_OFFLINE``
+and ``CPUHP_AP_ONLINE`` states.
+
+In addition, all-callback-wait operations such as ``rcu_barrier()`` may
+not be invoked from any CPU-hotplug notifier.  This restriction is due
+to the fact that there are phases of CPU-hotplug operations where the
+outgoing CPU's callbacks will not be invoked until after the CPU-hotplug
+operation ends, which could also result in deadlock. Furthermore,
+``rcu_barrier()`` blocks CPU-hotplug operations during its execution,
+which results in another type of deadlock when invoked from a CPU-hotplug
+notifier.
+
+Finally, RCU must avoid deadlocks due to interaction between hotplug,
+timers and grace period processing. It does so by maintaining its own set
+of books that duplicate the centrally maintained ``cpu_online_mask``,
+and also by reporting quiescent states explictly when a CPU goes
+offline.  This explicit reporting of quiescent states avoids any need
+for the force-quiescent-state loop (FQS) to report quiescent states for
+offline CPUs.  However, as a debugging measure, the FQS loop does splat
+if offline CPUs block an RCU grace period for too long.
+
+An offline CPU's quiescent state will be reported either:
+1.  As the CPU goes offline using RCU's hotplug notifier (``rcu_report_dead()``).
+2.  When grace period initialization (``rcu_gp_init()``) detects a
+    race either with CPU offlining or with a task unblocking on a leaf
+    ``rcu_node`` structure whose CPUs are all offline.
+
+The CPU-online path (``rcu_cpu_starting()``) should never need to report
+a quiescent state for an offline CPU.  However, as a debugging measure,
+it does emit a warning if a quiescent state was not already reported
+for that CPU.
+
+During the checking/modification of RCU's hotplug bookkeeping, the
+corresponding CPU's leaf node lock is held. This avoids race conditions
+between RCU's hotplug notifier hooks, the grace period initialization
+code, and the FQS loop, all of which refer to or modify this bookkeeping.
 
 Scheduler and RCU
 ~~~~~~~~~~~~~~~~~
