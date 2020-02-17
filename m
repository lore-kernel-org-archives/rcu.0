Return-Path: <SRS0=T7aT=4F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66F0C34022
	for <rcu@archiver.kernel.org>; Mon, 17 Feb 2020 18:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F1A20725
	for <rcu@archiver.kernel.org>; Mon, 17 Feb 2020 18:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581962890;
	bh=eJZ8DT4ReB2j3gXDW52rcZiaKWlX7eBGNI/gI1+FkEw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=x+Hjzsic5fizzx5neioRYLBqiaOdAfM6KqtkFeHx/qKtqHXDSM7U1XfR9AJtYzrvt
	 1RZRTjBlO96f7aK/FTeKalizHMB/szW9B/rdD/+71Z46xIggkHp8Ry3iA6CvtxDHbG
	 M97UYH8rFUSNwnG6+A2VXX7H1aLLR8X7vmIb12Lc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbgBQSIK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 17 Feb 2020 13:08:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:35676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbgBQSIK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 17 Feb 2020 13:08:10 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44D6B2070B;
        Mon, 17 Feb 2020 18:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581962889;
        bh=eJZ8DT4ReB2j3gXDW52rcZiaKWlX7eBGNI/gI1+FkEw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pMg2Ax8i/SXBAocIAn2rTrkbCEZJ9twN8uoojQWM4IjNClmN3U1wfSkhuyRgkKSYf
         A8dNM0oLWS5TQD5Y1lJ/HVUJ8Y9xZUKwhi2kmJRHpdqSPvoM+QcstVqLH7+aepRtkJ
         5VImKj9JDXYfrKsxtHqHFBBIlIj2dX3IhXumGpT4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1F1BB352273C; Mon, 17 Feb 2020 10:08:09 -0800 (PST)
Date:   Mon, 17 Feb 2020 10:08:09 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        ebiederm@xmission.com
Subject: Re: [PATCH] ipc: use a work queue to free_ipc
Message-ID: <20200217180809.GO2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200211162408.2194037-1-gscrivan@redhat.com>
 <20200216141151.GJ2935@paulmck-ThinkPad-P72>
 <875zg5r2ih.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zg5r2ih.fsf@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Feb 17, 2020 at 10:23:18AM +0100, Giuseppe Scrivano wrote:
> Hi Paul,
> 
> "Paul E. McKenney" <paulmck@kernel.org> writes:
> 
> > Nice speedup!
> >
> > However, I am not convinced that the code shown below is safe.
> >
> > I believe that you need either a synchronize_rcu() in your free_ipc()
> > function or that you need to pass free_ipc() to queue_rcu_work() instead
> > of directly schedule_work().  As things are, I would expect you to see
> > free_ipc_ns() being invoke too soon on heavily loaded CONFIG_PREEMPT=y
> > kernels.  Which can be quite a pain to debug!
> >
> > Or am I missing something?
> 
> thanks for the review!
> 
> Would being called too soon be a problem?  The current version calls
> free_ipc_ns() as part of the put_ipc_ns cleanup.
> 
> free_ipc() calls immediately synchronize_rcu() through free_ipc_ns():
> 
> free_ipc_ns() -> mq_put_mnt() -> kern_unmount() -> synchronize_rcu()

Ah, I did not look deeply enough.

> Do you think we should make it more explicit and add a synchronize_rcu()
> as part of the free_ipc_ns() function itself?

Maybe just a comment on the free_ipc_ns() saying that it waits for
a grace period.

							Thanx, Paul

> Regards,
> Giuseppe
> 
> 
> >
> > 							Thanx, Paul
> >
> >> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> >> ---
> >>  include/linux/ipc_namespace.h |  2 ++
> >>  ipc/namespace.c               | 17 +++++++++++++++--
> >>  2 files changed, 17 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
> >> index c309f43bde45..a06a78c67f19 100644
> >> --- a/include/linux/ipc_namespace.h
> >> +++ b/include/linux/ipc_namespace.h
> >> @@ -68,6 +68,8 @@ struct ipc_namespace {
> >>  	struct user_namespace *user_ns;
> >>  	struct ucounts *ucounts;
> >>  
> >> +	struct llist_node mnt_llist;
> >> +
> >>  	struct ns_common ns;
> >>  } __randomize_layout;
> >>  
> >> diff --git a/ipc/namespace.c b/ipc/namespace.c
> >> index b3ca1476ca51..37d27e1b807a 100644
> >> --- a/ipc/namespace.c
> >> +++ b/ipc/namespace.c
> >> @@ -117,6 +117,7 @@ void free_ipcs(struct ipc_namespace *ns, struct ipc_ids *ids,
> >>  
> >>  static void free_ipc_ns(struct ipc_namespace *ns)
> >>  {
> >> +	mq_put_mnt(ns);
> >>  	sem_exit_ns(ns);
> >>  	msg_exit_ns(ns);
> >>  	shm_exit_ns(ns);
> >> @@ -127,6 +128,17 @@ static void free_ipc_ns(struct ipc_namespace *ns)
> >>  	kfree(ns);
> >>  }
> >>  
> >> +static LLIST_HEAD(free_ipc_list);
> >> +static void free_ipc(struct work_struct *unused)
> >> +{
> >> +	struct llist_node *node = llist_del_all(&free_ipc_list);
> >> +	struct ipc_namespace *n, *t;
> >> +
> >> +	llist_for_each_entry_safe(n, t, node, mnt_llist)
> >> +		free_ipc_ns(n);
> >> +}
> >> +static DECLARE_WORK(free_ipc_work, free_ipc);
> >> +
> >>  /*
> >>   * put_ipc_ns - drop a reference to an ipc namespace.
> >>   * @ns: the namespace to put
> >> @@ -148,8 +160,9 @@ void put_ipc_ns(struct ipc_namespace *ns)
> >>  	if (refcount_dec_and_lock(&ns->count, &mq_lock)) {
> >>  		mq_clear_sbinfo(ns);
> >>  		spin_unlock(&mq_lock);
> >> -		mq_put_mnt(ns);
> >> -		free_ipc_ns(ns);
> >> +
> >> +		if (llist_add(&ns->mnt_llist, &free_ipc_list))
> >> +			schedule_work(&free_ipc_work);
> >>  	}
> >>  }
> >>  
> >> -- 
> >> 2.24.1
> >> 
> 
