Return-Path: <SRS0=c1tG=B4=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17D7C433DF
	for <rcu@archiver.kernel.org>; Tue, 18 Aug 2020 21:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89C2C20709
	for <rcu@archiver.kernel.org>; Tue, 18 Aug 2020 21:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597784637;
	bh=HPr9VORaCJTq4ADIyzNh0P8W6nvrS9HdzdYwLMApPxQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=KF4rQ46J1uDq3iAMAXSToE4EUzlAWPfOr/ph0eYTHCN4f6btf/uRMamzT093a8IGI
	 c4VnoyIEhmTIvzA6+oF3seMPdA1ODnUi7+MGeQtyXZLQUgpC2yncJhnovfn0vHjvin
	 bZsByO0Z5QO6BGOsTyXMH5bnql05MCWTkc90dLL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgHRVD5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 18 Aug 2020 17:03:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgHRVD4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 18 Aug 2020 17:03:56 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40935205CB;
        Tue, 18 Aug 2020 21:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597784635;
        bh=HPr9VORaCJTq4ADIyzNh0P8W6nvrS9HdzdYwLMApPxQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KY9Y7Q//gHTdu/nCTRm12otNIzpXnWe7WOs5r0rBgXhzavzNXdoW1SAxyM2WXltQ6
         2bL2HZajS0Nos2oTvrg0Ht58bBTdcA6IctVu1XLfH5cYve6pYfNYl/uZTUpitnIIyB
         RqjuJnhRUP9hyJ3p6JIL7QlFzOwE2O3Lt9ZczcB4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1CCA535228F5; Tue, 18 Aug 2020 14:03:55 -0700 (PDT)
Date:   Tue, 18 Aug 2020 14:03:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, qiang.zhang@windriver.com,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu: shrink each possible cpu krcp
Message-ID: <20200818210355.GM27891@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200814064557.17365-1-qiang.zhang@windriver.com>
 <20200814185124.GA2113@pc636>
 <CAEXW_YSJXHQq=z+fhHH+ZAVBDRnOYAzo6wHTFaqd9AQYHhQ6yg@mail.gmail.com>
 <20200818171807.GI27891@paulmck-ThinkPad-P72>
 <CAEXW_YQu9MAV-3ym0EFB0NmomWkLsBtZCT9sShnzo+vv=8sLgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YQu9MAV-3ym0EFB0NmomWkLsBtZCT9sShnzo+vv=8sLgg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 18, 2020 at 03:00:35PM -0400, Joel Fernandes wrote:
> On Tue, Aug 18, 2020 at 1:18 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Mon, Aug 17, 2020 at 06:03:54PM -0400, Joel Fernandes wrote:
> > > On Fri, Aug 14, 2020 at 2:51 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> > > >
> > > > > From: Zqiang <qiang.zhang@windriver.com>
> > > > >
> > > > > Due to cpu hotplug. some cpu may be offline after call "kfree_call_rcu"
> > > > > func, if the shrinker is triggered at this time, we should drain each
> > > > > possible cpu "krcp".
> > > > >
> > > > > Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> > > > > ---
> > > > >  kernel/rcu/tree.c | 6 +++---
> > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > index 8ce77d9ac716..619ccbb3fe4b 100644
> > > > > --- a/kernel/rcu/tree.c
> > > > > +++ b/kernel/rcu/tree.c
> > > > > @@ -3443,7 +3443,7 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
> > > > >       unsigned long count = 0;
> > > > >
> > > > >       /* Snapshot count of all CPUs */
> > > > > -     for_each_online_cpu(cpu) {
> > > > > +     for_each_possible_cpu(cpu) {
> > > > >               struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> > > > >
> > > > >               count += READ_ONCE(krcp->count);
> > > > > @@ -3458,7 +3458,7 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
> > > > >       int cpu, freed = 0;
> > > > >       unsigned long flags;
> > > > >
> > > > > -     for_each_online_cpu(cpu) {
> > > > > +     for_each_possible_cpu(cpu) {
> > > > >               int count;
> > > > >               struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> > > > >
> > > > > @@ -3491,7 +3491,7 @@ void __init kfree_rcu_scheduler_running(void)
> > > > >       int cpu;
> > > > >       unsigned long flags;
> > > > >
> > > > > -     for_each_online_cpu(cpu) {
> > > > > +     for_each_possible_cpu(cpu) {
> > > > >               struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> > > > >
> > > > >               raw_spin_lock_irqsave(&krcp->lock, flags);
> > > > >
> > > > I agree that it can happen.
> > > >
> > > > Joel, what is your view?
> > >
> > > Yes I also think it is possible. The patch LGTM. Another fix could be
> > > to drain the caches in the CPU offline path and save the memory. But
> > > then it will take hit during __get_free_page(). If CPU
> > > offlining/online is not frequent, then it will save the lost memory.
> > >
> > > I wonder how other per-cpu caches in the kernel work in such scenarios.
> > >
> > > Thoughts?
> >
> > Do I count this as an ack or a review?  If not, what precisely would
> > you like the submitter to do differently?
> 
> Hi Paul,
> The patch is correct and is definitely an improvement. I was thinking
> about whether we should always do what the patch is doing when
> offlining CPUs to save memory but now I feel that may not be that much
> of a win to justify more complexity.
> 
> You can take it with my ack:
> 
> Acked-by: Joel Fernandes <joel@joelfernandes.org>

Thank you all!  I wordsmithed a bit as shown below, so please let
me know if I messed anything up.

							Thanx, Paul

------------------------------------------------------------------------

commit fe5d89cc025b3efe682cac122bc4d39f4722821e
Author: Zqiang <qiang.zhang@windriver.com>
Date:   Fri Aug 14 14:45:57 2020 +0800

    rcu: Shrink each possible cpu krcp
    
    CPUs can go offline shortly after kfree_call_rcu() has been invoked,
    which can leave memory stranded until those CPUs come back online.
    This commit therefore drains the kcrp of each CPU, not just the
    ones that happen to be online.
    
    Acked-by: Joel Fernandes <joel@joelfernandes.org>
    Signed-off-by: Zqiang <qiang.zhang@windriver.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 02ca8e5..d9f90f6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3500,7 +3500,7 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 	unsigned long count = 0;
 
 	/* Snapshot count of all CPUs */
-	for_each_online_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		count += READ_ONCE(krcp->count);
@@ -3515,7 +3515,7 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 	int cpu, freed = 0;
 	unsigned long flags;
 
-	for_each_online_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		int count;
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
@@ -3548,7 +3548,7 @@ void __init kfree_rcu_scheduler_running(void)
 	int cpu;
 	unsigned long flags;
 
-	for_each_online_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		raw_spin_lock_irqsave(&krcp->lock, flags);
