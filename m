Return-Path: <SRS0=xc3B=77=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E14C433E0
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 22:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C360206FA
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 22:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592518281;
	bh=Uzh3yY2YeniyETVFPI0fgkL5ivLFjwCm1C6v1H53ZII=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ucxLIsuZGryhAWaK2x4eY533izrHinnCojlZ+sauWWCrE/K85MUaDj1Gmb2mAtKgd
	 StP/L1wAygV7NcQN4oWaBXiahQqkGdQwZkI9B0xS5vGgN6xvO+/8pLUDDMxK2PvlHH
	 4euG/57AZm7Ri1yyrjQSHegBIMLfqrHEp2QXUlgA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgFRWLV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Jun 2020 18:11:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728450AbgFRWLU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Jun 2020 18:11:20 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1DC620656;
        Thu, 18 Jun 2020 22:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592518279;
        bh=Uzh3yY2YeniyETVFPI0fgkL5ivLFjwCm1C6v1H53ZII=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AWkcMHqCOBCFskfwY2eU/YcQM5YlEoppWycqDAHRjo99Lmx53RZlckGODm6ku6E51
         xzFJ23g21NiKgB2Q55aOrxHXmlN8MFXHnxO/vmZ1pWhXIEOI/unmrebF7nWgAsYubf
         ALss+mUpoGRChqy1aETcbJ3k/EfTHeznigEQTzfU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id BB0A6352264E; Thu, 18 Jun 2020 15:11:19 -0700 (PDT)
Date:   Thu, 18 Jun 2020 15:11:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, urezki@gmail.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/7] rcu/segcblist: Prevent useless GP start if no CBs to
 accelerate
Message-ID: <20200618221119.GX2723@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200618202955.4024-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618202955.4024-1-joel@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 18, 2020 at 04:29:49PM -0400, Joel Fernandes (Google) wrote:

First, this looks like a very nice optimization, thank you!

> rcu_segcblist_accelerate() returns true if a GP is to be
> started/requested and false if not. During tracing, I found that it is
> asking that GPs be requested

s/GPs/unnecessary GPs/?  Plus "." at end of the sentence.

> The exact flow seems to be something like:
> 1. Callbacks are queued on CPU A - into the NEXT list.
> 2. softirq runs on CPU A, accelerate all CBs from NEXT->WAIT and request a GP X.
> 3. GP thread wakes up on another CPU, starts the GP X and requests QS from CPU A.
> 4. CPU A's softirq runs again presumably because of #3.

Yes, that is one reason RCU softirq might run again.

> 5. CPU A's softirq now does acceleration again, this time no CBs are
>    accelerated since last attempt, but it still requests GP X+1 which
>    could be useless.

I can't think of a case where this request helps.  How about: "but
it still unnecessarily requests GP X+1"?

> The fix is, prevent the useless GP start if we detect no CBs are there
> to accelerate.
> 
> With this, we have the following improvement in short runs of
> rcutorture (5 seconds each):
> +----+-------------------+-------------------+
> | #  | Number of GPs     | Number of Wakeups |
> +====+=========+=========+=========+=========+
> | 1  | With    | Without | With    | Without |
> +----+---------+---------+---------+---------+
> | 2  |      75 |      89 |     113 |     119 |
> +----+---------+---------+---------+---------+
> | 3  |      62 |      91 |     105 |     123 |
> +----+---------+---------+---------+---------+
> | 4  |      60 |      79 |      98 |     110 |
> +----+---------+---------+---------+---------+
> | 5  |      63 |      79 |      99 |     112 |
> +----+---------+---------+---------+---------+
> | 6  |      57 |      89 |      96 |     123 |
> +----+---------+---------+---------+---------+
> | 7  |      64 |      85 |      97 |     118 |
> +----+---------+---------+---------+---------+
> | 8  |      58 |      83 |      98 |     113 |
> +----+---------+---------+---------+---------+
> | 9  |      57 |      77 |      89 |     104 |
> +----+---------+---------+---------+---------+
> | 10 |      66 |      82 |      98 |     119 |
> +----+---------+---------+---------+---------+
> | 11 |      52 |      82 |      83 |     117 |
> +----+---------+---------+---------+---------+

So the reductions in wakeups ranges from 5% to 40%, with almost a 20%
overall reduction in wakeups across all the runs.  That should be of
some use to someone.  ;-)

I do run rcutorture quite a bit, but is there a more real-world
benchmark that could be tried?

> Cc: urezki@gmail.com
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/rcu_segcblist.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> index 9a0f66133b4b3..4782cf17bf4f9 100644
> --- a/kernel/rcu/rcu_segcblist.c
> +++ b/kernel/rcu/rcu_segcblist.c
> @@ -475,8 +475,15 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
>  	 * Also advance to the oldest segment of callbacks whose
>  	 * ->gp_seq[] completion is at or after that passed in via "seq",
>  	 * skipping any empty segments.
> +	 *
> +	 * Note that "i" is the youngest segment of the list after which
> +	 * any older segments than "i" would not be mutated or assigned
> +	 * GPs. For example, if i == WAIT_TAIL, then neither WAIT_TAIL,
> +	 * nor DONE_TAIL will be touched. Only CBs in NEXT_TAIL will be
> +	 * merged with NEXT_READY_TAIL and the GP numbers of both of
> +	 * them would be updated.

In this case, only the GP number of NEXT_READY_TAIL would be updated,
correct?  Or am I missing something subtle in the loop just past the
end of this patch?

							Thanx, Paul

>  	 */
> -	if (++i >= RCU_NEXT_TAIL)
> +	if (rcu_segcblist_restempty(rsclp, i) || ++i >= RCU_NEXT_TAIL)
>  		return false;
>  
>  	/*
> -- 
> 2.27.0.111.gc72c7da667-goog
> 
