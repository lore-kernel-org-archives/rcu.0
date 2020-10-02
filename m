Return-Path: <SRS0=VPhX=DJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D27DC4363D
	for <rcu@archiver.kernel.org>; Fri,  2 Oct 2020 14:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EA05206DD
	for <rcu@archiver.kernel.org>; Fri,  2 Oct 2020 14:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601647971;
	bh=lqNTdTkNdsQHcWQ/ycuvV9kZSZGTlIJnGnt90RDqrbc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=2NfL0nxyJChTFqQfFbLteRsGoYthp4PDE6wZP2b6t4YSx8/gG/dCwFpvqN/qTwAW7
	 4Ri8VLgyNdygYJ7JEyLa665r75V6CFzaEd5cm6dzRTqvJ3fvu+W+60NCFd00wGBXbE
	 Qs5g2V4wE9NZPh2tWdvcZbvlwppCzjvy8dG/SfdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgJBOMv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 2 Oct 2020 10:12:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:51002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgJBOMu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 2 Oct 2020 10:12:50 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4411C206DB;
        Fri,  2 Oct 2020 14:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601647970;
        bh=lqNTdTkNdsQHcWQ/ycuvV9kZSZGTlIJnGnt90RDqrbc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=usUyOsupMwL4xMxZfBJFg8t60KKwuUfnFAwSuT6FAfPylsUSQLmCNYfbQawOzfIFQ
         SsGAbLj/NyS1ZVD1+OwPxiqVE95X+ragy7GFkzcnhLrVJ7MYOhEvItErsv94nNC3Ez
         Ryw0XZvryq1L6yJDMEf9xMB8XHSbYFpI7SyxphQU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 097BD3522838; Fri,  2 Oct 2020 07:12:50 -0700 (PDT)
Date:   Fri, 2 Oct 2020 07:12:50 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        mgorman@techsingularity.net, torvalds@linux-foundation.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH tip/core/rcu 14/15] rcu/tree: Allocate a page when caller
 is preemptible
Message-ID: <20201002141250.GH29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200928233041.GA23230@paulmck-ThinkPad-P72>
 <20200928233102.24265-14-paulmck@kernel.org>
 <20200929120756.GC2277@dhcp22.suse.cz>
 <20200930015327.GX29330@paulmck-ThinkPad-P72>
 <20200930084139.GN2277@dhcp22.suse.cz>
 <20200930232154.GA29330@paulmck-ThinkPad-P72>
 <20201001090220.GA22560@dhcp22.suse.cz>
 <20201001162709.GD29330@paulmck-ThinkPad-P72>
 <20201002065746.GA20872@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002065746.GA20872@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Oct 02, 2020 at 08:57:46AM +0200, Michal Hocko wrote:
> On Thu 01-10-20 09:27:09, Paul E. McKenney wrote:
> [...]
> > commit ea5c19d21233b5e8d3d06c0d4ecd6be9f2829dc3
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Thu Oct 1 09:24:40 2020 -0700
> > 
> >     kvfree_rcu: Use __GFP_NOMEMALLOC for single-argument kvfree_rcu()
> >     
> >     This commit applies the __GFP_NOMEMALLOC gfp flag to memory allocations
> >     carried out by the single-argument variant of kvfree_rcu(), thus avoiding
> >     this can-sleep code path from dipping into the emergency reserves.
> >     
> >     Suggested-by: Michal Hocko <mhocko@suse.com>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> LGTM. At least for this one I feel competent to give you
> Acked-by: Michal Hocko <mhocko@suse.com>

Thank you very much!  I will apply this on the next rebase later today,
Pacific Time.

						Thanx, Paul

> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 242f0f0..6132452 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3364,7 +3364,8 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
> >  {
> >  	struct kvfree_rcu_bulk_data *bnode;
> >  	bool can_alloc_page = preemptible();
> > -	gfp_t gfp = (can_sleep ? GFP_KERNEL | __GFP_RETRY_MAYFAIL : GFP_ATOMIC) | __GFP_NOWARN;
> > +	gfp_t gfp = (can_sleep ? GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOMEMALLOC
> > +			       : GFP_ATOMIC) | __GFP_NOWARN;
> >  	int idx;
> >  
> >  	*krcp = krc_this_cpu_lock(flags);
> 
> -- 
> Michal Hocko
> SUSE Labs
