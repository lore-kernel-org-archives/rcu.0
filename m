Return-Path: <SRS0=OxHY=4G=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4FAC34026
	for <rcu@archiver.kernel.org>; Tue, 18 Feb 2020 14:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCAD208C4
	for <rcu@archiver.kernel.org>; Tue, 18 Feb 2020 14:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgBROl2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 18 Feb 2020 09:41:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:60178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgBROl2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 18 Feb 2020 09:41:28 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C2F020801;
        Tue, 18 Feb 2020 14:41:26 +0000 (UTC)
Date:   Tue, 18 Feb 2020 09:41:24 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH V2 2/7] rcu: cleanup rcu_preempt_deferred_qs()
Message-ID: <20200218094124.339c0315@gandalf.local.home>
In-Reply-To: <20200217232307.GA17570@paulmck-ThinkPad-P72>
References: <20191102124559.1135-1-laijs@linux.alibaba.com>
        <20191102124559.1135-3-laijs@linux.alibaba.com>
        <20191103020150.GA23770@tardis>
        <7489f817-adaf-275b-b19d-18ad248b071f@linux.alibaba.com>
        <20191104145539.GY20975@paulmck-ThinkPad-P72>
        <e820852f-87ca-f974-2245-99833205e270@linux.alibaba.com>
        <20191105071911.GL20975@paulmck-ThinkPad-P72>
        <20191111143238.GA13306@paulmck-ThinkPad-P72>
        <cbded276-6770-25a0-2975-2c087872a38e@linux.alibaba.com>
        <20200217232307.GA17570@paulmck-ThinkPad-P72>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, 17 Feb 2020 15:23:07 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > I'm still asking for more comments.
> > 
> > By now, I have received some precious comments, mainly due to my
> > stupid naming mistakes and a misleading changelog. I should have

How about typos?

> > updated all these with a new series patches. But I hope I
> > can polish more in the new patchset with more suggestions from
> > valuable comments, especially in x86,scheduler,percpu and rcu
> > areas.
> > 
> > I'm very obliged to hear anything.  


> 
> commit 23a58acde0eea57ac77377e5d50d9562b2dbdfaa
> Author: Lai Jiangshan <laijs@linux.alibaba.com>
> Date:   Sat Feb 15 14:37:26 2020 -0800
> 
>     rcu: Don't set nesting depth negative in rcu_preempt_deferred_qs()
>     
>     Now that RCU flavors have been consolidated, an RCU-preempt
>     rcu_rea_unlock() in an interrupt or softirq handler cannot possibly

What's a "rea"? ;-)

-- Steve

>     end the RCU read-side critical section.  Consider the old vulnerability
>     involving rcu_preempt_deferred_qs() being invoked within such a handler
>     that interrupted an extended RCU read-side critical section, in which
>     a wakeup might be invoked with a scheduler lock held.  Because
>     rcu_read_unlock_special() no longer does wakeups in such situations,
>     it is no longer necessary for rcu_preempt_deferred_qs() to set the
>     nesting level negative.
>     
>     This commit therfore removes this recursion-protection code from
>     rcu_preempt_deferred_qs().
>     
>     Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
>
