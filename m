Return-Path: <SRS0=M2zx=DY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDC2C433E7
	for <rcu@archiver.kernel.org>; Sat, 17 Oct 2020 14:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D4E020758
	for <rcu@archiver.kernel.org>; Sat, 17 Oct 2020 14:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437490AbgJQObq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 17 Oct 2020 10:31:46 -0400
Received: from netrider.rowland.org ([192.131.102.5]:60855 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2411524AbgJQObp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 17 Oct 2020 10:31:45 -0400
Received: (qmail 836196 invoked by uid 1000); 17 Oct 2020 10:31:44 -0400
Date:   Sat, 17 Oct 2020 10:31:44 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     joel@joelfernandes.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki \(Sony\)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: Re: [PATCH v7 6/6] rcu/segcblist: Add additional comments to explain
 smp_mb()
Message-ID: <20201017143144.GA835860@rowland.harvard.edu>
References: <20201015002301.101830-1-joel@joelfernandes.org>
 <20201015002301.101830-7-joel@joelfernandes.org>
 <20201015133511.GB127222@lothringen>
 <20201017012753.GB4015033@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201017012753.GB4015033@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Oct 16, 2020 at 09:27:53PM -0400, joel@joelfernandes.org wrote:
> Adding Alan as well as its memory barrier discussion ;-)

I don't know the internals of how RCU works, so I'll just speak to the 
litmus test itself, ignoring issues of whether the litmus test is 
appropriate or expresses what you really want.

> The following litmus test would confirm it:
> 
> C rcubarrier+ctrldep
> 
> (*
>  * Result: Never
>  *
>  * This litmus test shows that rcu_barrier (P1) prematurely
>  * returning by reading len 0 can cause issues if P0 does
>  * NOT have a smb_mb() before WRITE_ONCE().
>  *
>  * mod_data == 2 means garbage which the callback should never see.
>  *)
> 
> { int len = 1; }
> 
> P0(int *len, int *mod_data)
> {
>         int r0;
> 
>         // accessed by say RCU callback in rcu_do_batch();
>         r0 = READ_ONCE(*mod_data);
>         smp_mb(); // Remove this and the "exists" will become true.
>         WRITE_ONCE(*len, 0);
> }
> 
> P1(int *len, int *mod_data)
> {
>         int r0;
> 
>         r0 = READ_ONCE(*len);
> 
>         // rcu_barrier will return early if len is 0
>         if (r0 == 0)
>                 WRITE_ONCE(*mod_data, 2);
> }
> 
> // Is it possible?
> exists (0:r0=2 /\ 1:r0=0)

This result is indeed not possible.  And yes, some sort of memory 
barrier is needed in P0.  But it doesn't have to be smp_mb(); you could 
use a weaker barrier instead.  For example, you could replace the 
READ_ONCE in P0 with smp_load_acquire(), or you could replace the 
WRITE_ONCE with smp_store_release().  Either of those changes would 
suffice to prevent this outcome.

Alan
