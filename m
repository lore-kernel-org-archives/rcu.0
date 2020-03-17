Return-Path: <SRS0=yil3=5C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B66C1975A
	for <rcu@archiver.kernel.org>; Tue, 17 Mar 2020 21:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6DC620738
	for <rcu@archiver.kernel.org>; Tue, 17 Mar 2020 21:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584481503;
	bh=20DxxSkzpEpNqK1k6Pr8hoOHtM6IxlT9Ib/xkG7YUKg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=I48KeuZar94EpwJTD+jNtvypM8b/vSEleEfmYXfo50EKPzFqygM5btRUAIqV+Jt4c
	 NgATc32n99Pe+alWHpIxOVP+sVptuAjdpTl9zyWRAdS+37YEV7t1ROFMppxVPIPgp5
	 o9ioNJioYqgplpIiBM6UsSbmig53T75hJ1KF4R9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgCQVpD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 17 Mar 2020 17:45:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbgCQVpD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 17 Mar 2020 17:45:03 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4FB720724;
        Tue, 17 Mar 2020 21:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584481502;
        bh=20DxxSkzpEpNqK1k6Pr8hoOHtM6IxlT9Ib/xkG7YUKg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=V0v/zLyOOxpwl03SxIcjTRapXjXI2bBP+4jK5GlyQ2UR/ZU2GvMmUxdks9/dMq+WB
         NZcgnrPLFqo9d2x76Xp0LNSHG9MQ2mmMuznpq1v08K9xbISRhNXWvh95QZWUg1/QO8
         Yt/wOHDNYIZmtdNg1UfeyiQjZssTJP8DGeJaIrd8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A44463523295; Tue, 17 Mar 2020 14:45:02 -0700 (PDT)
Date:   Tue, 17 Mar 2020 14:45:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        urezki@gmail.com
Subject: Re: [PATCH v2 rcu-dev 1/3] rcuperf: Add ability to increase object
 allocation size
Message-ID: <20200317214502.GA29184@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200316163228.62068-1-joel@joelfernandes.org>
 <20200317210822.GM3199@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200317210822.GM3199@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Mar 17, 2020 at 02:08:22PM -0700, Paul E. McKenney wrote:
> On Mon, Mar 16, 2020 at 12:32:26PM -0400, Joel Fernandes (Google) wrote:
> > This allows us to increase memory pressure dynamically using a new
> > rcuperf boot command line parameter called 'rcumult'.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Applied for testing and review, thank you!

But testing did not go far:

kernel/rcu/tree.c: In function ‘kfree_rcu_shrink_count’:
kernel/rcu/tree.c:3120:16: warning: unused variable ‘flags’ [-Wunused-variable]
  unsigned long flags, count = 0;
                ^~~~~

I will drop these and await a replacement.

							Thanx, Paul

> > ---
> > 
> > The Series v1->v2 only has added a new patch (3/3).
> > 
> > 
> >  kernel/rcu/rcuperf.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> > index a4a8d097d84d9..16dd1e6b7c09f 100644
> > --- a/kernel/rcu/rcuperf.c
> > +++ b/kernel/rcu/rcuperf.c
> > @@ -88,6 +88,7 @@ torture_param(bool, shutdown, RCUPERF_SHUTDOWN,
> >  torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
> >  torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable");
> >  torture_param(int, kfree_rcu_test, 0, "Do we run a kfree_rcu() perf test?");
> > +torture_param(int, kfree_mult, 1, "Multiple of kfree_obj size to allocate.");
> >  
> >  static char *perf_type = "rcu";
> >  module_param(perf_type, charp, 0444);
> > @@ -635,7 +636,7 @@ kfree_perf_thread(void *arg)
> >  		}
> >  
> >  		for (i = 0; i < kfree_alloc_num; i++) {
> > -			alloc_ptr = kmalloc(sizeof(struct kfree_obj), GFP_KERNEL);
> > +			alloc_ptr = kmalloc(kfree_mult * sizeof(struct kfree_obj), GFP_KERNEL);
> >  			if (!alloc_ptr)
> >  				return -ENOMEM;
> >  
> > @@ -722,6 +723,8 @@ kfree_perf_init(void)
> >  		schedule_timeout_uninterruptible(1);
> >  	}
> >  
> > +	pr_alert("kfree object size=%lu\n", kfree_mult * sizeof(struct kfree_obj));
> > +
> >  	kfree_reader_tasks = kcalloc(kfree_nrealthreads, sizeof(kfree_reader_tasks[0]),
> >  			       GFP_KERNEL);
> >  	if (kfree_reader_tasks == NULL) {
> > -- 
> > 2.25.1.481.gfbce0eb801-goog
