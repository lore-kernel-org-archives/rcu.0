Return-Path: <SRS0=VzST=RO=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8F2C43381
	for <rcu@archiver.kernel.org>; Mon, 11 Mar 2019 17:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC4C2063F
	for <rcu@archiver.kernel.org>; Mon, 11 Mar 2019 17:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="bQMLx8Nm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfCKRfn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:35:43 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39251 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfCKRfn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 11 Mar 2019 13:35:43 -0400
Received: by mail-qk1-f196.google.com with SMTP id c189so2260182qke.6
        for <rcu@vger.kernel.org>; Mon, 11 Mar 2019 10:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WeRCoZ82ABEShFaoXoB3EF6cyi367sJu/MuKtfUtAQM=;
        b=bQMLx8Nm/mCtAXD1xlYhP6dxbDcbOR/s8MhiaE6ZSfiOVeMvEs5k0fELQctIJ9ZVYV
         xcUF0rCCvTl194+L48U1qQ32EHR4kGBlJ8aaBkzc4p8tac9g7OC/K3I/xQsPLtiKxQ5t
         YIjfnphste2NBYue5y7c/K371Uc9tfgX4/WpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WeRCoZ82ABEShFaoXoB3EF6cyi367sJu/MuKtfUtAQM=;
        b=XakXWYqjD2MmfSEyCdMhzYXwJme8KvViYIXj+NAuD6S8B1diuee51RxUPpuvyUz6JM
         ZUUCwE7qII5I06YV2TboDJFN59+VNZQBUj08lUkZ8EU/VCTMlMITD0yUA7JGTyWCD6wk
         q+jULdlacRJQbWeltTodeKRqFq6pH/TV4FaSfHmZWfdxS7QHE/ta/aL89GlJmHORIn8f
         2TTN+WHWJuGs0rtdC1qWilZtHDwvguZJEerUCYPGCs6PcjVkQE+e8Eze2R465MK+jENL
         j37IRrzQ5gmL+gMXYCtiKSN3/92PDobKd5tPfbJoAHAKKMJTnKqLibu3tMd7M6qEkAMK
         2Rtw==
X-Gm-Message-State: APjAAAXMYI06vffxkNkdb65BJukzkJJjAZpeB3FqT9zmVcveMZC+Pb9Z
        vDkHjPZUVoiCqdZzGJImfoWDrA==
X-Google-Smtp-Source: APXvYqz3PTVc8Z8JHDa0TDD5x9VHZjbB/+DfYMPH8MA4BxIqnriFODHgOTRFNf2a1ekkxhJ081ihdA==
X-Received: by 2002:a05:620a:1013:: with SMTP id z19mr25117525qkj.342.1552325742235;
        Mon, 11 Mar 2019 10:35:42 -0700 (PDT)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id r64sm3755369qkb.60.2019.03.11.10.35.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 10:35:41 -0700 (PDT)
Date:   Mon, 11 Mar 2019 13:35:40 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Neeraj Upadhyay <neeraju@codeaurora.org>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu/tree: Default jiffies_to_sched_qs to
 jiffies_till_sched_qs
Message-ID: <20190311173540.GA80041@google.com>
References: <1552297571-5617-1-git-send-email-neeraju@codeaurora.org>
 <20190311151854.GG13351@linux.ibm.com>
 <20190311151947.GA8862@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311151947.GA8862@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Mar 11, 2019 at 08:19:47AM -0700, Paul E. McKenney wrote:
> This time keeping the CC list...
> 
> 							Thanx, Paul
> 
> On Mon, Mar 11, 2019 at 08:18:54AM -0700, Paul E. McKenney wrote:
> > On Mon, Mar 11, 2019 at 03:16:11PM +0530, Neeraj Upadhyay wrote:
> > > Current code does not call adjust_jiffies_till_sched_qs(),
> > > if jiffies_till_sched_qs is specified. For the case, where
> > > jiffies_till_first_fqs and jiffies_till_next_fqs are default,
> > > jiffies_to_sched_qs won't be a correct adjustment of
> > > jiffies_till_sched_qs.
> > > 
> > > Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> > 
> > Good catch!  Queued and pushed.  Please see below for updated
> > commit log.  On future patches, could you please first describe
> > the problem and consequences, then what the fix is?  This approach
> > makes it much easier for people later on who will be trying to
> > figure out what is going on, and who might or might not have much
> > understanding of RCU.  (For example, they might be doing a bisection
> > or some such.)
> > 
> > Not a big deal, as I can touch this up, but a good habit to get into.
> > 
> > And no, rcutorture currently does not specify non-default values
> > for jiffies_till_sched_qs.  Which should probably be fixed.  I could
> > make rcu_implicit_dynticks_qs() complain if jiffies_to_sched_qs is
> > zero, but that feels a bit hacky and specific.  :-/
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit ee474b85fa0815be940ed89a91e0d84a110a0a92
> > Author: Neeraj Upadhyay <neeraju@codeaurora.org>
> > Date:   Mon Mar 11 15:16:11 2019 +0530
> > 
> >     rcu: Default jiffies_to_sched_qs to jiffies_till_sched_qs
> >     
> >     The current code only calls adjust_jiffies_till_sched_qs() if
> >     jiffies_till_sched_qs is left at its default value, so when the
> >     jiffies_till_sched_qs kernel-boot parameter actually is specified,
> >     jiffies_to_sched_qs will be left with the value zero, which
> >     will result in useless slowdowns of cond_resched().  This commit
> >     therefore changes rcu_init_geometry() to unconditionally invoke
> >     adjust_jiffies_till_sched_qs(), which ensures that jiffies_to_sched_qs
> >     will be initialized in all cases, thus maintaining good cond_resched()
> >     performance.
> >     
> >     Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index ddd5c74e386b..10aeb89395ea 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3259,8 +3259,7 @@ static void __init rcu_init_geometry(void)
> >  		jiffies_till_first_fqs = d;
> >  	if (jiffies_till_next_fqs == ULONG_MAX)
> >  		jiffies_till_next_fqs = d;
> > -	if (jiffies_till_sched_qs == ULONG_MAX)
> > -		adjust_jiffies_till_sched_qs();
> > +	adjust_jiffies_till_sched_qs();
> >  
> >  	/* If the compile-time values are accurate, just leave. */
> >  	if (rcu_fanout_leaf == RCU_FANOUT_LEAF &&
> 

Makes sense to me.

Also the comment here needs an update too I think:

static ulong jiffies_to_sched_qs; /* Adjusted version of above if not default */

Seems to me, after your patch jiffies_to_sched_qs will always be an adjusted
value of some sort, unless jiffies_till_sched_qs is specified.

Comment should be some thing like this then?

/* Either the above, or an adjusted default version based on
 * jiffies_till_{first,next}_fqs if it is not specified */

thanks,

 - Joel


