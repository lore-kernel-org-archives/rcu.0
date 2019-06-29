Return-Path: <SRS0=e08d=U4=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC0BC5B57A
	for <rcu@archiver.kernel.org>; Sat, 29 Jun 2019 18:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4293B217D7
	for <rcu@archiver.kernel.org>; Sat, 29 Jun 2019 18:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="AaM7OPbH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfF2SJU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 29 Jun 2019 14:09:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38582 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfF2SJT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 29 Jun 2019 14:09:19 -0400
Received: by mail-wr1-f68.google.com with SMTP id d18so9497023wrs.5
        for <rcu@vger.kernel.org>; Sat, 29 Jun 2019 11:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dGCfSveaXSMPHPyr6HiFB8gP3B6VLV12a1GRwVtVOXo=;
        b=AaM7OPbHyse5dmbOzzv/Mp3l+I/lWFNogFGJwZ+7B4x2hc8yUlXwQnV3MMevW6AUhj
         Q/IEj2ChQqFyrltZPhfXpEWJe+ws9kEYakg1wwz71l2vNPSbZ5cLfNJJXmOQn/hhQfze
         GuebjNALbpBZIvAHS5SA5TAkGwG9ZvFFJE6HU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dGCfSveaXSMPHPyr6HiFB8gP3B6VLV12a1GRwVtVOXo=;
        b=VfH1xHAzbjXjkcDHrJ9ZO3W+LRheQnBOmchV2aSMXZuLAgYk4d5XoOnn//0AOfH/c4
         NpLPIg2PSty7xZIuELT2zqC9jzjcVr6kVqWbNpBSIuoHNgK85AfNwr8MpTkpgHtuRg6K
         fOd+wu+O/zP+pnDmvVbC0yYUAQWcjZjAva4LL5h7AK4W4Rorg77dUkZdThNhoGlPk8/Y
         ea/7zljNOvGukUwIJpNVJPysx69wDDgoZe/ofZkYGTAMjFNN9bnoCxNETPx+q8lIZj81
         yqto+xXNO8FU1qiVW8j+sEUksUBZWnE0hXhie2aEqyPi5pJDV8oFSwOFMtq/Rwa6e0cc
         wVgw==
X-Gm-Message-State: APjAAAWJXasJ+tmnoEeTSvqmuV+xu57IDdNFvLtwJMtXXwscrkvwW8aE
        Rp+GcYyzfTU/dwUTUwQQGxgTaA==
X-Google-Smtp-Source: APXvYqxZXLH8eadFkupwd+aF37vCC2y3zYotJYmG2s02U8TEKeCcPfR6snKx9B+dO3t6ybneEZv7nA==
X-Received: by 2002:adf:dcc2:: with SMTP id x2mr12350005wrm.55.1561831757558;
        Sat, 29 Jun 2019 11:09:17 -0700 (PDT)
Received: from andrea ([93.90.167.233])
        by smtp.gmail.com with ESMTPSA id o6sm13163379wra.27.2019.06.29.11.09.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 11:09:16 -0700 (PDT)
Date:   Sat, 29 Jun 2019 20:09:10 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        Scott Wood <swood@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Message-ID: <20190629180910.GA3399@andrea>
References: <20190627173831.GW26519@linux.ibm.com>
 <20190627181638.GA209455@google.com>
 <20190627184107.GA26519@linux.ibm.com>
 <13761fee4b71cc004ad0d6709875ce917ff28fce.camel@redhat.com>
 <20190627203612.GD26519@linux.ibm.com>
 <20190628073138.GB13650@X58A-UD3R>
 <20190628104045.GA8394@X58A-UD3R>
 <20190628114411.5d9ab351@gandalf.local.home>
 <20190629151236.GA7862@andrea>
 <20190629165533.GA3112@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190629165533.GA3112@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Jun 29, 2019 at 09:55:33AM -0700, Paul E. McKenney wrote:
> On Sat, Jun 29, 2019 at 05:12:36PM +0200, Andrea Parri wrote:
> > Hi Steve,
> > 
> > > As Paul stated, interrupts are synchronization points. Archs can only
> > > play games with ordering when dealing with entities outside the CPU
> > > (devices and other CPUs). But if you have assembly that has two stores,
> > > and an interrupt comes in, the arch must guarantee that the stores are
> > > done in that order as the interrupt sees it.
> > 
> > Hopefully I'm not derailing the conversation too much with my questions
> > ... but I was wondering if we had any documentation (or inline comments)
> > elaborating on this "interrupts are synchronization points"?
> 
> I don't know of any, but I would suggest instead looking at something
> like the Hennessey and Patterson computer-architecture textbook.
> 
> Please keep in mind that the rather detailed documentation on RCU is a
> bit of an outlier due to the fact that there are not so many textbooks
> that cover RCU.  If we tried to replicate all of the relevant textbooks
> in the Documentation directory, it would be quite a large mess.  ;-)

You know some developers considered it worth to develop formal specs in
order to better understand concepts such as "synchronization" and "IRQs
(processing)"! ...  ;-)  I still think that adding a few paragraphs (if
only in informal prose) to explain that "interrupts are synchronization
points" wouln't hurt.  And you're right, I guess we may well start from
a reference to H&P...

Remark: we do have code which (while acknowledging that "interrupts are
synchronization points") doesn't quite seem to "believe it", c.f., e.g.,
kernel/sched/membarrier.c:ipi_mb().  So, I guess the follow-up question
would be "Would we better be (more) paranoid? ..."

Thanks,
  Andrea
