Return-Path: <SRS0=wSob=VD=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06ECFC5B578
	for <rcu@archiver.kernel.org>; Sat,  6 Jul 2019 23:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB09520836
	for <rcu@archiver.kernel.org>; Sat,  6 Jul 2019 23:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="DyLcv18Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfGFXDf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 6 Jul 2019 19:03:35 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:33392 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbfGFXDf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 6 Jul 2019 19:03:35 -0400
Received: by mail-pl1-f179.google.com with SMTP id c14so6276865plo.0
        for <rcu@vger.kernel.org>; Sat, 06 Jul 2019 16:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aFLAohZryOU02aVSxVVOUUGfl670WihcljJidp8W1sw=;
        b=DyLcv18ZNh7s8J8aOnDT2Ouy440HPgtntzpVxlMbcCdQ5h3PRQZNN8C352DvO9FF5Z
         KymaOvzwYWDtqIUHhz1u79BLK0ORy5Rd6JDneQXugTC+RuuRChjzrD72iDhdHBuMGN2r
         HTzW1mwyO9n1f3+2h7pnbaA1X0qbfV8xHzjCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aFLAohZryOU02aVSxVVOUUGfl670WihcljJidp8W1sw=;
        b=IOY2t7XsVbTB5BYm0bhpuifX+TG/x3CiXCWGqDT4bnEIq8QeT+Pm5QNJ5fyxnX2nKc
         O+iHSNRzaLIlpn+5NZULazeY5IwDq0gmT2jq9Kwu74A45L61tvn85Qg3WXu1H+hIfX4e
         p9eXsF7nunNHPSFtqh/RL0vHzAF6sEBdvIjadDkPFj0t65ZO5ve2030dupHIcVw95Ak+
         egxr85zdxO9bKmhmlXhXmagQiHZ8xx3IQd7irjEALYG9lCOUQmPfoLreKWC8dQyCFx/Y
         mxJkKZ9HApPR6GLOxNF/lkjLUrpDGPgmPb9/chYvpprG0CDgNMlDwbYL1NHffX4+qpNd
         5NUQ==
X-Gm-Message-State: APjAAAUWoGrhnMzXCqukWmLKffUmKnzXIeZNtmgaUF4MjDU7wtPp3ug6
        uwofKZtQgdwvMH6lpYjOviZX4Q==
X-Google-Smtp-Source: APXvYqzQ3g8gnTOPEB9x8frnHSAw+Qg5he4Ly7glfZGDCAW/JqI207CsdhfNUc2AUvLicZfphAtqjw==
X-Received: by 2002:a17:902:8d97:: with SMTP id v23mr13374482plo.157.1562454214075;
        Sat, 06 Jul 2019 16:03:34 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id o16sm30436067pgi.36.2019.07.06.16.03.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 06 Jul 2019 16:03:33 -0700 (PDT)
Date:   Sat, 6 Jul 2019 19:03:31 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>
Subject: Re: Normal RCU grace period can be stalled for long because
 need-resched flags not set?
Message-ID: <20190706230331.GA158271@google.com>
References: <20190703230103.GX26519@linux.ibm.com>
 <20190704002130.GA68801@google.com>
 <20190704003213.GA218086@google.com>
 <20190704005009.GZ26519@linux.ibm.com>
 <20190704032454.GA259593@google.com>
 <20190704171315.GG26519@linux.ibm.com>
 <20190704185055.GA12919@google.com>
 <20190704221702.GL26519@linux.ibm.com>
 <20190706120230.GA200542@google.com>
 <20190706182117.GY26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190706182117.GY26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Jul 06, 2019 at 11:21:17AM -0700, Paul E. McKenney wrote:
> On Sat, Jul 06, 2019 at 08:02:30AM -0400, Joel Fernandes wrote:
> > On Thu, Jul 04, 2019 at 03:17:02PM -0700, Paul E. McKenney wrote:
> > > On Thu, Jul 04, 2019 at 02:50:55PM -0400, Joel Fernandes wrote:
> > [snip] 
> > > > I did have a request, could you help me understand why is the grace period
> > > > duration double that of my busy wait time? You mentioned this has something
> > > > to do with the thread not waking up before another GP is started. But I did
> > > > not follow this. Thanks a lot!!
> > > 
> > > Let's look at a normal grace period, and assume the ->gp_seq grace-period
> > > sequence counter is initially 0x1, so that a grace period is already
> > > in progress (keep in mind that the low-order two bits of ->gp_seq are
> > > the phase within the grace period and the rest of the bits are the
> > > grace-period number, so we are in phase 1 of the grace period following
> > > grace period #0).  This grace period was started via synchronize_rcu()
> > > by Task A.
> > > 
> > > Then we have the following sequence of events:
> > > 
> > > o	Task B does call_rcu(), but is too late to use the already-started
> > > 	grace period, so it needs another one.	The ->gp_seq_needed
> > > 	counter thus becomes 0x8.
> > > 
> > > o	The current grace period completes, so that the ->gp_seq
> > > 	counter becomes 0x4.  Callback invocation commences.
> > > 
> > > o	The grace-period kthread notices that ->gp_seq_needed is greater
> > > 	than ->gp_seq, so it starts a new grace period.  The ->gp_seq
> > > 	counter therefore becomes 0x5.
> > > 
> > > o	The callback for Task A's synchronize_rcu() is invoked, awakening
> > > 	Task A.  This happens almost immediately after the new grace
> > > 	period starts, but does definitely happen -after- that grace
> > > 	period starts.
> > 
> > Yes, but at this point, we are still at the 1GP mark. But the distribution's
> > median below shows a strong correlation with 2 preempt-disable durations and
> > grace-period completion. For example, if the duration of the preempt
> > disable/enable loop is 50ms, it strongly shows the writer's median time
> > difference before and after the synchronize_rcu as 100ms, not really showing
> > it is 60 ms or 75 ms or anything.
> > 
> > > 
> > > o	Task A, being part of rcuperf, almost immediately does another
> > > 	synchronize_rcu().  So ->gp_seq_needed becomes 0xc.
> > 
> > Yes, but before that another synchronize_rcu, it also gets the timestamp and
> > does a diff between old/new timestamp and has captured the data, so at that
> > point the data captured should only be for around 1GPs worth give or take.
> 
> But in this case, the "give or take" is almost a full grace period, for
> a total of almost two grace periods.
> 
> > > If you play out the rest of this sequence, you should see how Task A
> > > waits for almost two full grace periods.
> > 
> > I tried to play this out, still didn't get it :-|. Not that it is an issue
> > per-se, but still would like to understand it better.
> 
> Let's try it a different way.  Let's skip the state portion of ->gp_seq
> and just focus on the number of elapsed grace periods.
> 
> o	Let's start with RCU idle, having completed grace-period number
> 	zero and not yet having started grace-period number 1.
> 	Let's also abbreviate: GP0 and GP1.
> 
> o	Task A wants a grace period.  Because RCU is idle, Task A's
> 	GP will complete at completion of GP1.
> 
> o	RCU starts GP1.
> 
> o	Almost immediately thereafter, Task B wants a grace period.
> 	But it cannot use GP1, because GP1 has already started, even
> 	if just barely, because some CPU or tasks might already have
> 	reported a quiescent state for GP1.
> 
> 	So Task B's GP will not complete until the end of GP2.	And that
> 	is almost two GPs worth of time from now.
> 
> And on a system where RCU is busy, Task B's experience is the common
> case if it is in a tight loop doing synchronize_rcu().  Because RCU is
> busy, by the end of each grace period, there will always be a request
> for another grace period.  And therefore RCU's grace-period kthread
> will immediately start a new grace period upon completion of each
> grace period.  So the sequence of events from Task B's viewpoint will
> be as follows:
> 
> o	Task B executes synchronize_rcu(), which requests a new grace
> 	period.
> 
> o	This requested grace period ends, and another immediately starts.
> 
> o	Task B's RCU callback is invoked, which does a wakeup.
> 
> o	Task B executes another synchronize_rcu(), but just after a new
> 	grace period has started.  Task B thus has to wait almost two
> 	full grace periods.
> 
> This could be perceived as a problem, but my question back to you would
> be "Why on earth are you invoking synchronize_rcu() in a tight loop???"
> "Oh, because you are running rcuperf?  Well, that is why rcuperf uses
> ftrace data!"
> 
> Which might be the point on which we are talking past each other.  You
> might have been thinking of the latency of RCU's grace-period computation.
> I was thinking of the length of time between the call to synchronize_rcu()
> and the corresponding return.

This registered perfectly with me now, I was having a hard time visualizing
but it makes sense to me now based on your description. Thanks a lot!

Ascii art:
(Basically the synch rcu is done just after a slight offset)

               synchronize_rcu Wait     synchronize_rcu Wait 
              |<-------------------->|  |--------------------|
              v                      v  v                    v
<----------> <----------> <----------> <---------> <--------->
     GP            GP          GP         GP          GP

GP = long preempt disable duration

thanks,

 - Joel

