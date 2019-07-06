Return-Path: <SRS0=wSob=VD=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F57CC0650E
	for <rcu@archiver.kernel.org>; Sat,  6 Jul 2019 12:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD7A2089C
	for <rcu@archiver.kernel.org>; Sat,  6 Jul 2019 12:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="NjRks0H6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfGFMCe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 6 Jul 2019 08:02:34 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:45502 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbfGFMCe (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 6 Jul 2019 08:02:34 -0400
Received: by mail-pg1-f175.google.com with SMTP id o13so5395114pgp.12
        for <rcu@vger.kernel.org>; Sat, 06 Jul 2019 05:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mg5vutmqqu5gKya/8Xbq+ZWJN6wtGQPXf+tJrCmqWv8=;
        b=NjRks0H6m/P5jG9BCQV3LSUdzwduDmeRqx3yJEMcOILJ2FhbHpO808+XUocrG6jjmH
         2D3TDvuyz6Bq5/VjbTnaLn9MMkdxtQhYMCLrdniYzHvOCWCaN6yPdBjbXufo709e1V+F
         0FLQDjLrbvcofxLvuah1zBO+v75zlDIIKsIWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mg5vutmqqu5gKya/8Xbq+ZWJN6wtGQPXf+tJrCmqWv8=;
        b=dP/kr3IahxjekQOfUZvO/sSWNFbolHOshWiEykYymUtPuVx7eeatrvTtY5VbguQCT6
         q77FQr+NCLkZ4svWOUyvUA7CZhQbc8IJEAFsEsGmCytwvSI9SVknFXt+SJMKBHHyztWa
         O5VmOB7Z9NXcXGUcqzIyh1BiS6iUccHtsTSnzMBnMaOkgISuKxOLu3MwcWZAmqb4rKjy
         JFGgm/rkLXTJQMGHGLzGlvzvtZVe/QGe4l7JAvXPbLPR4YXxhBtxxjxi4naX6RpaCwJu
         QywhzYKK+WEtPruqYiEWImHAioCbLLeQoKSLsfadl0TbxlCAu0vz0Y7TVWgsOZU6xcjY
         5tvQ==
X-Gm-Message-State: APjAAAVPezpQrqCPok+Y44KIgeoOPdJCh/08hWrPMXuCgE4vYcwD9P73
        eZ5nokFKYuvEbgsO198rNehqWgl7xAM=
X-Google-Smtp-Source: APXvYqymxJTsqJVM5tgEI+3JtJC5fe205aWiMkCRc6Fm0S9uB8A5U6iOc+EqDyjpRbFsh+TMMfgt7Q==
X-Received: by 2002:a63:6ec4:: with SMTP id j187mr10674575pgc.420.1562414553502;
        Sat, 06 Jul 2019 05:02:33 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id b15sm11212961pfi.141.2019.07.06.05.02.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 06 Jul 2019 05:02:32 -0700 (PDT)
Date:   Sat, 6 Jul 2019 08:02:30 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>
Subject: Re: Normal RCU grace period can be stalled for long because
 need-resched flags not set?
Message-ID: <20190706120230.GA200542@google.com>
References: <20190703215714.GW26519@linux.ibm.com>
 <20190703222406.GA203913@google.com>
 <20190703230103.GX26519@linux.ibm.com>
 <20190704002130.GA68801@google.com>
 <20190704003213.GA218086@google.com>
 <20190704005009.GZ26519@linux.ibm.com>
 <20190704032454.GA259593@google.com>
 <20190704171315.GG26519@linux.ibm.com>
 <20190704185055.GA12919@google.com>
 <20190704221702.GL26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704221702.GL26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 04, 2019 at 03:17:02PM -0700, Paul E. McKenney wrote:
> On Thu, Jul 04, 2019 at 02:50:55PM -0400, Joel Fernandes wrote:
[snip] 
> > I did have a request, could you help me understand why is the grace period
> > duration double that of my busy wait time? You mentioned this has something
> > to do with the thread not waking up before another GP is started. But I did
> > not follow this. Thanks a lot!!
> 
> Let's look at a normal grace period, and assume the ->gp_seq grace-period
> sequence counter is initially 0x1, so that a grace period is already
> in progress (keep in mind that the low-order two bits of ->gp_seq are
> the phase within the grace period and the rest of the bits are the
> grace-period number, so we are in phase 1 of the grace period following
> grace period #0).  This grace period was started via synchronize_rcu()
> by Task A.
> 
> Then we have the following sequence of events:
> 
> o	Task B does call_rcu(), but is too late to use the already-started
> 	grace period, so it needs another one.	The ->gp_seq_needed
> 	counter thus becomes 0x8.
> 
> o	The current grace period completes, so that the ->gp_seq
> 	counter becomes 0x4.  Callback invocation commences.
> 
> o	The grace-period kthread notices that ->gp_seq_needed is greater
> 	than ->gp_seq, so it starts a new grace period.  The ->gp_seq
> 	counter therefore becomes 0x5.
> 
> o	The callback for Task A's synchronize_rcu() is invoked, awakening
> 	Task A.  This happens almost immediately after the new grace
> 	period starts, but does definitely happen -after- that grace
> 	period starts.

Yes, but at this point, we are still at the 1GP mark. But the distribution's
median below shows a strong correlation with 2 preempt-disable durations and
grace-period completion. For example, if the duration of the preempt
disable/enable loop is 50ms, it strongly shows the writer's median time
difference before and after the synchronize_rcu as 100ms, not really showing
it is 60 ms or 75 ms or anything.

> 
> o	Task A, being part of rcuperf, almost immediately does another
> 	synchronize_rcu().  So ->gp_seq_needed becomes 0xc.

Yes, but before that another synchronize_rcu, it also gets the timestamp and
does a diff between old/new timestamp and has captured the data, so at that
point the data captured should only be for around 1GPs worth give or take.

> If you play out the rest of this sequence, you should see how Task A
> waits for almost two full grace periods.

I tried to play this out, still didn't get it :-|. Not that it is an issue
per-se, but still would like to understand it better.


> > Performance changes in consolidated vs regular
> > -------------------------------------------
> > I ran a thread on a reserved CPU doing preempt disable + busy wait + preempt enable
> > in a loop and measured the difference in rcuperf between conslidated and regular.
> > nreaders = nwriters = 10.
> > 
> > 		(preempt disable duration)
> > 		5ms	10ms	20ms	50ms
> > v4.19
> > median (usecs)	12000.3	12001	11000	12000
> > 
> > v5.1 (deferred)
> > median (usecs)	13000	19999   40000   100000
> > 
> > All of this is still within spec of RCU.

thanks!

 - Joel

