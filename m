Return-Path: <SRS0=u9Eq=6Y=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08CFC54E4B
	for <rcu@archiver.kernel.org>; Sun, 10 May 2020 15:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E4B220736
	for <rcu@archiver.kernel.org>; Sun, 10 May 2020 15:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589125186;
	bh=8h9ahc3Yu0709/yHwkE2qnpvfiOpmtIhCGjy6Ha1M9o=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=B3Q3e2z6YSyNyfNaWF7MzbwGmhWdS+aTTiVIghkqXu+/bTG1Nw+FkBZfBfmT5HOJM
	 IgvnrgY9vyo0f48Pr3UsRvaIdGy9euaLDNYfs990uJ+Tk54Ep3FBOEh/wo87CooauG
	 2Nxmqv17VHWoilDVbpysEJYb5cW7YAvLQ77ESQko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbgEJPjq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 10 May 2020 11:39:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgEJPjq (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 10 May 2020 11:39:46 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AC1620735;
        Sun, 10 May 2020 15:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589125185;
        bh=8h9ahc3Yu0709/yHwkE2qnpvfiOpmtIhCGjy6Ha1M9o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Z/QDZ92zpK6sKhzEYZlwOp/G+FioCsnhyCIalaRJRgdje5ZgE25HoOJFdUxNUld2D
         KP3VckYHwmif+67A24ts5hdCAIRUig7BPsHjZvhiOEvLomLF+bMFB+csYTNEnaWwrr
         wDCqc6B8ouMc8E0TqDOlYr7iuiDczLLrY1f4uMlA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1677535227BD; Sun, 10 May 2020 08:39:45 -0700 (PDT)
Date:   Sun, 10 May 2020 08:39:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     rcu@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@kernel.org>,
        dipankar@in.ibm.com, Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v4 tip/core/rcu 05/38] rcu-tasks: Move Tasks RCU to its
 own file
Message-ID: <20200510153945.GQ2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200415181856.GA11037@paulmck-ThinkPad-P72>
 <20200415181941.11653-5-paulmck@kernel.org>
 <CAJhGHyArjzU9QeDkSH-L31ytzkWC9TT4uZ-gmA+gdmgvweagCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyArjzU9QeDkSH-L31ytzkWC9TT4uZ-gmA+gdmgvweagCQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, May 10, 2020 at 03:42:52PM +0800, Lai Jiangshan wrote:
> On Thu, Apr 16, 2020 at 2:19 AM <paulmck@kernel.org> wrote:
> >
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> >
> > This code-movement-only commit is in preparation for adding an additional
> > flavor of Tasks RCU, which relies on workqueues to detect grace periods.
> >
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  kernel/rcu/tasks.h  | 370 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  kernel/rcu/update.c | 366 +--------------------------------------------------
> 
> Hello Paul
> 
> Makes it kernel/rcu/tasks.c?
> 
> One of my old patch split it into a c-file, and it did work.
> Is there anything new or planed that prevents it to be a c-file?

It quite likely could be a c-file, but let's see things play out with
your suggestion of replacing Tasks RCU with a check in the scheduler
before making such a change.

							Thanx, Paul

> thanks
> Lai
> 
> >
> > +#include "tasks.h"
> > +
> >  #ifndef CONFIG_TINY_RCU
> >
> >  /*
> > --
> > 2.9.5
> >
