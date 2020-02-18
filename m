Return-Path: <SRS0=OxHY=4G=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE15AC34031
	for <rcu@archiver.kernel.org>; Tue, 18 Feb 2020 22:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B2122B48
	for <rcu@archiver.kernel.org>; Tue, 18 Feb 2020 22:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgBRWpH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 18 Feb 2020 17:45:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:60396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbgBRWpH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 18 Feb 2020 17:45:07 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BB682173E;
        Tue, 18 Feb 2020 22:45:05 +0000 (UTC)
Date:   Tue, 18 Feb 2020 17:45:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 1/3] rcu-tasks: *_ONCE() for
 rcu_tasks_cbs_head
Message-ID: <20200218174503.3d4e4750@gandalf.local.home>
In-Reply-To: <20200218202226.GJ2935@paulmck-ThinkPad-P72>
References: <20200215002446.GA15663@paulmck-ThinkPad-P72>
        <20200215002520.15746-1-paulmck@kernel.org>
        <20200217123851.GR14914@hirez.programming.kicks-ass.net>
        <20200217181615.GP2935@paulmck-ThinkPad-P72>
        <20200218075648.GW14914@hirez.programming.kicks-ass.net>
        <20200218162719.GE2935@paulmck-ThinkPad-P72>
        <20200218201142.GF11457@worktop.programming.kicks-ass.net>
        <20200218202226.GJ2935@paulmck-ThinkPad-P72>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, 18 Feb 2020 12:22:26 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Tue, Feb 18, 2020 at 09:11:42PM +0100, Peter Zijlstra wrote:
> > On Tue, Feb 18, 2020 at 08:27:19AM -0800, Paul E. McKenney wrote:  
> > > On Tue, Feb 18, 2020 at 08:56:48AM +0100, Peter Zijlstra wrote:  
> >   
> > > > I just took offence at the Changelog wording. It seems to suggest there
> > > > actually is a problem, there is not.  
> > > 
> > > Quoting the changelog: "Not appropriate for backporting due to failure
> > > being unlikely."  
> > 
> > That implies there is failure, however unlikely.
> > 
> > In this particular case there is absolutely no failure, except perhaps
> > in KCSAN. This patch is a pure annotation such that KCSAN can understand
> > the code.
> > 
> > Like said, I don't object to the actual patch, but I do think it is
> > important to call out false negatives or to describe the actual problem
> > found.  
> 
> I don't feel at all comfortable declaring that there is absolutely
> no possibility of failure.

Perhaps wording it like so:

"There's know known issue with the current code, but the *_ONCE()
annotations here makes KCSAN happy, allowing us to focus on KCSAN
warnings that can help bring about known issues in other code that we
can fix, without being distracted by KCSAN warnings that we do not see
a problem with."

?

-- Steve
