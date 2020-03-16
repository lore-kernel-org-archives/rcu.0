Return-Path: <SRS0=IXig=5B=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A191FC2BB1D
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 21:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78DB120719
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 21:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732697AbgCPVcX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Mar 2020 17:32:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:42440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732672AbgCPVcX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Mar 2020 17:32:23 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E820020679;
        Mon, 16 Mar 2020 21:32:20 +0000 (UTC)
Date:   Mon, 16 Mar 2020 17:32:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>, rcu <rcu@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "kernel-team@fb.com," <kernel-team@fb.com>,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        dipankar <dipankar@in.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH RFC tip/core/rcu 09/16] rcu-tasks: Add an RCU-tasks rude
 variant
Message-ID: <20200316173219.1f8b7443@gandalf.local.home>
In-Reply-To: <20200316203241.GB3199@paulmck-ThinkPad-P72>
References: <20200312181618.GA21271@paulmck-ThinkPad-P72>
        <20200312181702.8443-9-paulmck@kernel.org>
        <20200316194754.GA172196@google.com>
        <CAEXW_YREzQ8hMP_vGiQFiNAtwxPn_C0TG6mH68QaS8cES-Jr3Q@mail.gmail.com>
        <20200316203241.GB3199@paulmck-ThinkPad-P72>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, 16 Mar 2020 13:32:41 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > Just curious, why is the "rude" version better than SRCU? Seems the
> > schedule_on_each_cpu() would be much slower than SRCU especially if
> > there are 1000s of CPUs involved. Is there any reason that is a better
> > alternative?  
> 
> The rude version has much faster readers, and the story I hear is that
> there are not expected to be all that many concurrent updaters.
> 
> But to get more detail, why not ask Steven why he chose not to use SRCU?
> (I know the story for the BPF guys, and it is because of SRCU's read-side
> overhead.)

Same for the function side (if not even more so). This would require adding
a srcu_read_lock() to all functions that can be traced! That would be a huge
kill in performance. Probably to the point no one would bother even using
function tracer.

-- Steve
