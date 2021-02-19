Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A913EC433E6
	for <rcu@archiver.kernel.org>; Fri, 19 Feb 2021 19:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6378D64EB3
	for <rcu@archiver.kernel.org>; Fri, 19 Feb 2021 19:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbhBSTew (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 19 Feb 2021 14:34:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:58438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229636AbhBSTev (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 19 Feb 2021 14:34:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C8A564E86;
        Fri, 19 Feb 2021 19:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613763250;
        bh=E7rfILP2938lotz9shFDf1Uj3+uNDR6SVU27aCroK1g=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ZIBY8SQYWAApq47wsBw3WUWwRFNrIRF49L5BSquQKY/9mGtnMO2FyThXSJP+LmneR
         dQuc0/CBC/DlS+TEuEGCF49Gb+NSS/6usYRO7jbf8kwuF0gGtq5GwoNAxq2RKWT+f+
         6IRfhqfLpjsFua6pBt15i577UAOJD2iZFN7/eKVkktYnoNib2MWIql6vZKg0NEWN8Q
         I/ql6vRtjba5qAXXkf5HdLB+Uwzy9/09aMsypTbompb4Kx0RaUbcE03/vICSSlbC32
         M368WmzYyidyyp2EGAXZ1qQlK+5XotyJ8hYdCUSdgXbg8GPqZ55MwdHOgr18f93gGR
         3RZrVrsos/bag==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id F29E43520E6A; Fri, 19 Feb 2021 11:34:09 -0800 (PST)
Date:   Fri, 19 Feb 2021 11:34:09 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Michal Hocko <mhocko@suse.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH] kprobes: Fix to delay the kprobes jump optimization
Message-ID: <20210219193409.GA8827@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210218151554.GQ2743@paulmck-ThinkPad-P72>
 <20210219081755.eucq4srbam6wg2gm@linutronix.de>
 <20210219104958.GA34308@pc638.lan>
 <20210219105710.d626zexj6vzt6k6y@linutronix.de>
 <20210219111301.GA34441@pc638.lan>
 <20210219111738.go6i2fdzvavpotxd@linutronix.de>
 <20210219112357.GA34462@pc638.lan>
 <20210219112751.GA34528@pc638.lan>
 <20210219181811.GY2743@paulmck-ThinkPad-P72>
 <20210219183336.GA23049@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219183336.GA23049@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Feb 19, 2021 at 10:33:36AM -0800, Paul E. McKenney wrote:
> On Fri, Feb 19, 2021 at 10:18:11AM -0800, Paul E. McKenney wrote:
> > On Fri, Feb 19, 2021 at 12:27:51PM +0100, Uladzislau Rezki wrote:
> > > On Fri, Feb 19, 2021 at 12:23:57PM +0100, Uladzislau Rezki wrote:
> > > > On Fri, Feb 19, 2021 at 12:17:38PM +0100, Sebastian Andrzej Siewior wrote:
> > > > > On 2021-02-19 12:13:01 [+0100], Uladzislau Rezki wrote:
> > > > > > I or Paul will ask for a test once it is settled down :) Looks like
> > > > > > it is, so we should fix for v5.12.
> > > > > 
> > > > > Okay. Since Paul asked for powerpc test on v5.11-rc I wanted check if
> > > > > parts of it are also -stable material.
> > 
> > If Masami's patch works for the PowerPC guys on v5.10-rc7, then it can
> > be backported.  The patch making RCU Tasks initialize itself early won't
> > have any effect and can be left or reverted, as we choose.  The self-test
> > patch will need to be either adjusted or reverted.
> > 
> > However...
> > 
> > The root cause of this problem is that softirq only kind-of works
> > during a window of time during boot.  It works only if the number and
> > duration of softirq handlers during this time is small enough, for some
> > ill-defined notion of "small enough".  If there are too many, whatever
> > that means exactly, then we get failed attempt to awaken ksoftirqd, which
> > (sometimes!) results in a silent hang.  Which, as you pointed out earlier,
> > is a really obnoxious error message.  And any minor change could kick
> > us into silent-hang state because of the heuristics used to hand off
> > to ksoftirqd.  The straw that broke the camel's back and all that.
> > 
> > One approach would be to add WARN_ON_ONCE() so that if softirq tries
> > to awaken ksoftirqd before it is spawned, we get a nice obvious splat.
> > Unfortunately, this gives false positives because there is code that
> > needs a softirq handler to run eventually, but is OK with that handler
> > being delayed until some random point in the early_initcall() sequence.
> > 
> > Besides which, if we are going to add a check, why not use that check
> > just make things work by forcing handler execution to remain within the
> > softirq back-of-interrupt context instead of awakening a not-yet-spawned
> > ksoftirqd?  We can further prevent entry into dyntick-idle state until
> > the ksoftirqd kthreads have been spawned, which means that if softirq
> > handlers must be deferred, they will be resumed within one jiffy by the
> > next scheduler-clock interrupt.
> > 
> > Yes, this can allow softirq handlers to impose large latencies, but only
> > during early boot, long before any latency-sensitive applications can
> > possibly have been created.  So this does not seem like a real problem.
> > 
> > Am I missing something here?
> 
> For definiteness, here is the first part of the change, posted earlier.
> The commit log needs to be updated.  I will post the change that keeps
> the tick going as a reply to this email.

And here it is.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 9c0ee82..1d4f5b8 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1320,6 +1320,11 @@ static void rcu_prepare_kthreads(int cpu)
  */
 int rcu_needs_cpu(u64 basemono, u64 *nextevt)
 {
+	/* Through early_initcall(), need tick for softirq handlers. */
+	if (!this_cpu_ksoftirqd()) {
+		*nextevt = 1;
+		return 1;
+	}
 	*nextevt = KTIME_MAX;
 	return !rcu_segcblist_empty(&this_cpu_ptr(&rcu_data)->cblist) &&
 		!rcu_rdp_is_offloaded(this_cpu_ptr(&rcu_data));
@@ -1415,6 +1420,12 @@ int rcu_needs_cpu(u64 basemono, u64 *nextevt)
 
 	lockdep_assert_irqs_disabled();
 
+	/* Through early_initcall(), need tick for softirq handlers. */
+	if (!this_cpu_ksoftirqd()) {
+		*nextevt = 1;
+		return 1;
+	}
+
 	/* If no non-offloaded callbacks, RCU doesn't need the CPU. */
 	if (rcu_segcblist_empty(&rdp->cblist) ||
 	    rcu_rdp_is_offloaded(rdp)) {
