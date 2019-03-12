Return-Path: <SRS0=m9L7=RP=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6059FC43381
	for <rcu@archiver.kernel.org>; Tue, 12 Mar 2019 14:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248292087C
	for <rcu@archiver.kernel.org>; Tue, 12 Mar 2019 14:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="G26Ts6p8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfCLOHZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:07:25 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35440 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfCLOHY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 12 Mar 2019 10:07:24 -0400
Received: by mail-qt1-f194.google.com with SMTP id h39so2674986qte.2
        for <rcu@vger.kernel.org>; Tue, 12 Mar 2019 07:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2V9CE5cxV3NzTPceuTxnuo5i8AX3TaaGWH0V8Hyg7ho=;
        b=G26Ts6p8IUXAWNr1aY6I+cZ5RT74DgNu+fPv/sp6qFFqhNgI2HFtHCI/V1Xajhvk1M
         xwnDos01Vf8rBbRjoVAAyinvpJrGwZR6SnMEFcH72AHt26T32pQkw3jVTVyT6K9CBWVe
         reYS8eExNDLRDPOfiny7xN1hsIWCiHEqFt6VA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2V9CE5cxV3NzTPceuTxnuo5i8AX3TaaGWH0V8Hyg7ho=;
        b=ra0GxStTYJd2ooDY9FT8vNYWa/WBsrBQq0gKHK4awad/h0LHXC1rnH9ucdrarBGhoK
         in2lpi8+ZQiTcqu9ibfLkjDkrTQCx9ZujXvzP1OzN6A4w5HrH9mugu8dxBdQkvYlUvzO
         ImSyDkwNwDvSt8BpIfvO47HlLORqFKn9rNZMIN9J+OSuVgKPdEeJtTbQHA7H2mmE4y1n
         2UW8z2rhCb4djB0tw4lOuyIC4bCIMUbqELrCCPVLfk22kIkVUevh15pVlnovyN2X7Gwg
         M6qxfQzWJSKzlrmKgerOOZRcQoiayKH4pgPN1Nu8vSvQsvC8vVVa+JSZOtjFspNnOMY7
         DBOw==
X-Gm-Message-State: APjAAAVIbWPLboWn6OEOZiHukGlgQdnxrPn2qrEKpnLnU7Z5nFqiqLAn
        hpRA9XMbbXUNK8z9RDieBnZ4J7zrQsA=
X-Google-Smtp-Source: APXvYqxyIQYtSrZXmC7zvb+wNUTYOiM2NLoC+GFSYkqQpxxr8LmCB2k11k6OPQ7trLXpVJFsPCjM+Q==
X-Received: by 2002:a0c:f9cd:: with SMTP id j13mr9494168qvo.83.1552399643380;
        Tue, 12 Mar 2019 07:07:23 -0700 (PDT)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id 50sm5382795qtr.96.2019.03.12.07.07.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 07:07:21 -0700 (PDT)
Date:   Tue, 12 Mar 2019 10:07:20 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Neeraj Upadhyay <neeraju@codeaurora.org>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org
Subject: Re: [PATCH] rcu/tree: Default jiffies_to_sched_qs to
 jiffies_till_sched_qs
Message-ID: <20190312140720.GA249405@google.com>
References: <1552297571-5617-1-git-send-email-neeraju@codeaurora.org>
 <20190311151854.GG13351@linux.ibm.com>
 <20190311151947.GA8862@linux.ibm.com>
 <20190311173540.GA80041@google.com>
 <20190311224742.GS13351@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311224742.GS13351@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Mar 11, 2019 at 03:47:42PM -0700, Paul E. McKenney wrote:
> On Mon, Mar 11, 2019 at 01:35:40PM -0400, Joel Fernandes wrote:
> > On Mon, Mar 11, 2019 at 08:19:47AM -0700, Paul E. McKenney wrote:
> > > This time keeping the CC list...
> > > 
> > > 							Thanx, Paul
> > > 
> > > On Mon, Mar 11, 2019 at 08:18:54AM -0700, Paul E. McKenney wrote:
> > > > On Mon, Mar 11, 2019 at 03:16:11PM +0530, Neeraj Upadhyay wrote:
> > > > > Current code does not call adjust_jiffies_till_sched_qs(),
> > > > > if jiffies_till_sched_qs is specified. For the case, where
> > > > > jiffies_till_first_fqs and jiffies_till_next_fqs are default,
> > > > > jiffies_to_sched_qs won't be a correct adjustment of
> > > > > jiffies_till_sched_qs.
> > > > > 
> > > > > Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> > > > 
> > > > Good catch!  Queued and pushed.  Please see below for updated
> > > > commit log.  On future patches, could you please first describe
> > > > the problem and consequences, then what the fix is?  This approach
> > > > makes it much easier for people later on who will be trying to
> > > > figure out what is going on, and who might or might not have much
> > > > understanding of RCU.  (For example, they might be doing a bisection
> > > > or some such.)
> > > > 
> > > > Not a big deal, as I can touch this up, but a good habit to get into.
> > > > 
> > > > And no, rcutorture currently does not specify non-default values
> > > > for jiffies_till_sched_qs.  Which should probably be fixed.  I could
> > > > make rcu_implicit_dynticks_qs() complain if jiffies_to_sched_qs is
> > > > zero, but that feels a bit hacky and specific.  :-/
> > > > 
> > > > 							Thanx, Paul
> > > > 
> > > > ------------------------------------------------------------------------
> > > > 
> > > > commit ee474b85fa0815be940ed89a91e0d84a110a0a92
> > > > Author: Neeraj Upadhyay <neeraju@codeaurora.org>
> > > > Date:   Mon Mar 11 15:16:11 2019 +0530
> > > > 
> > > >     rcu: Default jiffies_to_sched_qs to jiffies_till_sched_qs
> > > >     
> > > >     The current code only calls adjust_jiffies_till_sched_qs() if
> > > >     jiffies_till_sched_qs is left at its default value, so when the
> > > >     jiffies_till_sched_qs kernel-boot parameter actually is specified,
> > > >     jiffies_to_sched_qs will be left with the value zero, which
> > > >     will result in useless slowdowns of cond_resched().  This commit
> > > >     therefore changes rcu_init_geometry() to unconditionally invoke
> > > >     adjust_jiffies_till_sched_qs(), which ensures that jiffies_to_sched_qs
> > > >     will be initialized in all cases, thus maintaining good cond_resched()
> > > >     performance.
> > > >     
> > > >     Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> > > >     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> > > > 
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index ddd5c74e386b..10aeb89395ea 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -3259,8 +3259,7 @@ static void __init rcu_init_geometry(void)
> > > >  		jiffies_till_first_fqs = d;
> > > >  	if (jiffies_till_next_fqs == ULONG_MAX)
> > > >  		jiffies_till_next_fqs = d;
> > > > -	if (jiffies_till_sched_qs == ULONG_MAX)
> > > > -		adjust_jiffies_till_sched_qs();
> > > > +	adjust_jiffies_till_sched_qs();
> > > >  
> > > >  	/* If the compile-time values are accurate, just leave. */
> > > >  	if (rcu_fanout_leaf == RCU_FANOUT_LEAF &&
> > > 
> > 
> > Makes sense to me.
> > 
> > Also the comment here needs an update too I think:
> > 
> > static ulong jiffies_to_sched_qs; /* Adjusted version of above if not default */
> > 
> > Seems to me, after your patch jiffies_to_sched_qs will always be an adjusted
> > value of some sort, unless jiffies_till_sched_qs is specified.
> > 
> > Comment should be some thing like this then?
> > 
> > /* Either the above, or an adjusted default version based on
> >  * jiffies_till_{first,next}_fqs if it is not specified */
> 
> Good point, but how about the patch below?

Yes, your comment is better :-) thanks,

 - Joel


> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit b1d5aaf8eff7872a63531f35aa0490f2fc8118d6
> Author: Paul E. McKenney <paulmck@linux.ibm.com>
> Date:   Mon Mar 11 15:45:13 2019 -0700
> 
>     rcu: Update jiffies_to_sched_qs and adjust_jiffies_till_sched_qs() comments
>     
>     This commit better documents the jiffies_to_sched_qs default-value
>     strategy used by adjust_jiffies_till_sched_qs()
>     
>     Reported-by: Joel Fernandes <joel@joelfernandes.org>
>     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 10aeb89395ea..355775a82581 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -400,7 +400,7 @@ static bool rcu_kick_kthreads;
>   */
>  static ulong jiffies_till_sched_qs = ULONG_MAX;
>  module_param(jiffies_till_sched_qs, ulong, 0444);
> -static ulong jiffies_to_sched_qs; /* Adjusted version of above if not default */
> +static ulong jiffies_to_sched_qs; /* See adjust_jiffies_till_sched_qs(). */
>  module_param(jiffies_to_sched_qs, ulong, 0444); /* Display only! */
>  
>  /*
> @@ -418,6 +418,7 @@ static void adjust_jiffies_till_sched_qs(void)
>  		WRITE_ONCE(jiffies_to_sched_qs, jiffies_till_sched_qs);
>  		return;
>  	}
> +	/* Otherwise, set to third fqs scan, but bound below on large system. */
>  	j = READ_ONCE(jiffies_till_first_fqs) +
>  		      2 * READ_ONCE(jiffies_till_next_fqs);
>  	if (j < HZ / 10 + nr_cpu_ids / RCU_JIFFIES_FQS_DIV)
> 
