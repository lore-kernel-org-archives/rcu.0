Return-Path: <SRS0=Bh/h=EM=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071EFC2D0A3
	for <rcu@archiver.kernel.org>; Fri,  6 Nov 2020 19:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A823B20B80
	for <rcu@archiver.kernel.org>; Fri,  6 Nov 2020 19:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604689992;
	bh=GlE34wY4SMh9cHwy9fY5b6a+GW8qy3H3b92CYNVkOlY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Ssn76d1xXmtnwGtWefsE4WEMGPdvSY0M6DaEU3JHFE0dHCrB0JloEwXVUqQGB7PyN
	 qvQsupwOQFvJXEotdXeug82t0KKDbGiT/ymj1+ttJct+fx/F8NduN4dks/rw4+sa+r
	 +AEHw1GoLcM3EYw2wVEZ7GaZig1tPALFQLXcPBng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgKFTNM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 6 Nov 2020 14:13:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:57916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728122AbgKFTNM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 6 Nov 2020 14:13:12 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4376120882;
        Fri,  6 Nov 2020 19:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604689991;
        bh=GlE34wY4SMh9cHwy9fY5b6a+GW8qy3H3b92CYNVkOlY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HsNRShLLsMj3MumqMT21spb7ze6Rkyd1cY9WfrQYFRmWpVJXVU4LVOyO5p2MliUSg
         AhjY++FpjhcWNOaAefQhI3o271/+oUMsG5+HP8sWZ/61GuZh4iYYinCA/lt9i7sTmA
         dOV9YcIfvvzVcYRkbEglEJQvAt9GjExC6MFHdHaU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id EDBCC352097B; Fri,  6 Nov 2020 11:13:10 -0800 (PST)
Date:   Fri, 6 Nov 2020 11:13:10 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 03/28] locktorture: Track time of last
 ->writeunlock()
Message-ID: <20201106191310.GZ3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201105234658.GA23142@paulmck-ThinkPad-P72>
 <20201105234719.23307-3-paulmck@kernel.org>
 <20201106065642.ti7mgrll7mbrndja@linux-p48b.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106065642.ti7mgrll7mbrndja@linux-p48b.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Nov 05, 2020 at 10:56:42PM -0800, Davidlohr Bueso wrote:
> On Thu, 05 Nov 2020, paulmck@kernel.org wrote:
> 
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > This commit adds a last_lock_release variable that tracks the time of
> > the last ->writeunlock() call, which allows easier diagnosing of lock
> > hangs when using a kernel debugger.
> 
> This makes sense to have.
> 
> Acked-by: Davidlohr Bueso <dbueso@suse.de>

Will apply, thank you!

							Thanx, Paul

> > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> > kernel/locking/locktorture.c | 2 ++
> > 1 file changed, 2 insertions(+)
> > 
> > diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> > index 62d215b..316531d 100644
> > --- a/kernel/locking/locktorture.c
> > +++ b/kernel/locking/locktorture.c
> > @@ -60,6 +60,7 @@ static struct task_struct **reader_tasks;
> > 
> > static bool lock_is_write_held;
> > static bool lock_is_read_held;
> > +static unsigned long last_lock_release;
> > 
> > struct lock_stress_stats {
> > 	long n_lock_fail;
> > @@ -632,6 +633,7 @@ static int lock_torture_writer(void *arg)
> > 		lwsp->n_lock_acquired++;
> > 		cxt.cur_ops->write_delay(&rand);
> > 		lock_is_write_held = false;
> > +		WRITE_ONCE(last_lock_release, jiffies);
> > 		cxt.cur_ops->writeunlock();
> > 
> > 		stutter_wait("lock_torture_writer");
> > -- 
> > 2.9.5
> > 
