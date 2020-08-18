Return-Path: <SRS0=c1tG=B4=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8776C433E1
	for <rcu@archiver.kernel.org>; Tue, 18 Aug 2020 17:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1EC720786
	for <rcu@archiver.kernel.org>; Tue, 18 Aug 2020 17:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597771091;
	bh=BHcNycc4dZBlyvyM2oisP4r82JOuw/+7vT2Hq+RP4rg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=tkESJqls3bQKUtBRDu3ZFH3rpm/A9h48OeNOtxQLMc7rqhljGgGkajUmI8pm7WW5+
	 oMTq5EfbuvWczdi0oB7Pqvd3HIENKJUtrfEMJqMbdwD3E+WcpTSxaGJxnpzHf3N/72
	 lrKmUwTS41zgJsH927hWPqONo9QiR4uSV46XQFUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgHRRSJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 18 Aug 2020 13:18:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbgHRRSI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 18 Aug 2020 13:18:08 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE5DF20658;
        Tue, 18 Aug 2020 17:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597771087;
        bh=BHcNycc4dZBlyvyM2oisP4r82JOuw/+7vT2Hq+RP4rg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=G2uzu5rVo9qgnohWdcmBBqslx+OIONWh7jmdSNIxCGhJ4Bay3lsoZcbgQM3OkW4ML
         6h6GUghZyHln6EgzKX7X5E3ir5FjBl5F3n78TtDeoWhnxJ5gG5PDMwtCo5y2h5AkcF
         j5PexCbKO//1QMrK6T71jGVEyED9bPjpCY4aK0ZA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8E6B735228F5; Tue, 18 Aug 2020 10:18:07 -0700 (PDT)
Date:   Tue, 18 Aug 2020 10:18:07 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, qiang.zhang@windriver.com,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu: shrink each possible cpu krcp
Message-ID: <20200818171807.GI27891@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200814064557.17365-1-qiang.zhang@windriver.com>
 <20200814185124.GA2113@pc636>
 <CAEXW_YSJXHQq=z+fhHH+ZAVBDRnOYAzo6wHTFaqd9AQYHhQ6yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YSJXHQq=z+fhHH+ZAVBDRnOYAzo6wHTFaqd9AQYHhQ6yg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Aug 17, 2020 at 06:03:54PM -0400, Joel Fernandes wrote:
> On Fri, Aug 14, 2020 at 2:51 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> >
> > > From: Zqiang <qiang.zhang@windriver.com>
> > >
> > > Due to cpu hotplug. some cpu may be offline after call "kfree_call_rcu"
> > > func, if the shrinker is triggered at this time, we should drain each
> > > possible cpu "krcp".
> > >
> > > Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> > > ---
> > >  kernel/rcu/tree.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 8ce77d9ac716..619ccbb3fe4b 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -3443,7 +3443,7 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
> > >       unsigned long count = 0;
> > >
> > >       /* Snapshot count of all CPUs */
> > > -     for_each_online_cpu(cpu) {
> > > +     for_each_possible_cpu(cpu) {
> > >               struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> > >
> > >               count += READ_ONCE(krcp->count);
> > > @@ -3458,7 +3458,7 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
> > >       int cpu, freed = 0;
> > >       unsigned long flags;
> > >
> > > -     for_each_online_cpu(cpu) {
> > > +     for_each_possible_cpu(cpu) {
> > >               int count;
> > >               struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> > >
> > > @@ -3491,7 +3491,7 @@ void __init kfree_rcu_scheduler_running(void)
> > >       int cpu;
> > >       unsigned long flags;
> > >
> > > -     for_each_online_cpu(cpu) {
> > > +     for_each_possible_cpu(cpu) {
> > >               struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> > >
> > >               raw_spin_lock_irqsave(&krcp->lock, flags);
> > >
> > I agree that it can happen.
> >
> > Joel, what is your view?
> 
> Yes I also think it is possible. The patch LGTM. Another fix could be
> to drain the caches in the CPU offline path and save the memory. But
> then it will take hit during __get_free_page(). If CPU
> offlining/online is not frequent, then it will save the lost memory.
> 
> I wonder how other per-cpu caches in the kernel work in such scenarios.
> 
> Thoughts?

Do I count this as an ack or a review?  If not, what precisely would
you like the submitter to do differently?

							Thanx, Paul
