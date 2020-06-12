Return-Path: <SRS0=lJWX=7Z=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05A0C433E0
	for <rcu@archiver.kernel.org>; Fri, 12 Jun 2020 14:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5C542081A
	for <rcu@archiver.kernel.org>; Fri, 12 Jun 2020 14:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591971169;
	bh=K9mmWg+RlhSzEFgOR5fzEuEol7HVAlTxtf93HYgh604=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=lRi+aeWtHq7y39qfOmaFOxmZkBcUc87NVm9FPlgdBcg/XUxUWrxwQJvvZyYEhX8se
	 3RkLXkdKRt2aatxRbpqlHKUbOUwgTqIh6Vbu2NHzrGxHbUSfpZ33qGPGNcD2c2rzU/
	 6WWyZzLcDDQdQEoHuN1L1l/dMojg3CqL8jEyf3aI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgFLOMt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 12 Jun 2020 10:12:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgFLOMt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 12 Jun 2020 10:12:49 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F0E12074B;
        Fri, 12 Jun 2020 14:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591971168;
        bh=K9mmWg+RlhSzEFgOR5fzEuEol7HVAlTxtf93HYgh604=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AVWvWB9g9k+/rFhJefunRgtgjW5ow5mKi1qTflEXkM9vhNW9klyoEvr6KjXYTOZe3
         s2Qr8urrS0qqfqGfcKm7J6vhCeg+pEmCpuMAki0ij1PVOrEKlnAGrkT53J63HiAUlV
         kcPHQ+oAu/60bsUsv7Cef7icshuHllFhyTBH91qc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7FC353521A8D; Fri, 12 Jun 2020 07:12:48 -0700 (PDT)
Date:   Fri, 12 Jun 2020 07:12:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, trivial@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] rcu: use gp_seq instead of rcu_gp_seq for consistency
Message-ID: <20200612141248.GK4455@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200612020755.50526-1-richard.weiyang@linux.alibaba.com>
 <20200612020755.50526-5-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612020755.50526-5-richard.weiyang@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jun 12, 2020 at 10:07:55AM +0800, Wei Yang wrote:
> Commit de30ad512a66 ("rcu: Introduce grace-period sequence numbers")
> introduce gp_seq in rcu_state/rcu_node/rcu_data. And this field in last
> two structure track the one in first.
> 
> While the comment use rcu_gp_seq which is a little misleading for
> audience. Let's use the exact name gp_seq for consistency.
> 
> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>

I applied and pushed the others -- good eyes, and thank you!

This one does not apply.  Could you please forward-port it to
the "dev" branch of -rcu?

git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git

							Thanx, Paul

> ---
>  kernel/rcu/tree.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 512829eed545..3356842bc185 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -41,7 +41,7 @@ struct rcu_node {
>  	raw_spinlock_t __private lock;	/* Root rcu_node's lock protects */
>  					/*  some rcu_state fields as well as */
>  					/*  following. */
> -	unsigned long gp_seq;	/* Track rsp->rcu_gp_seq. */
> +	unsigned long gp_seq;	/* Track rsp->gp_seq. */
>  	unsigned long gp_seq_needed; /* Track furthest future GP request. */
>  	unsigned long completedqs; /* All QSes done for this node. */
>  	unsigned long qsmask;	/* CPUs or groups that need to switch in */
> @@ -149,7 +149,7 @@ union rcu_noqs {
>  /* Per-CPU data for read-copy update. */
>  struct rcu_data {
>  	/* 1) quiescent-state and grace-period handling : */
> -	unsigned long	gp_seq;		/* Track rsp->rcu_gp_seq counter. */
> +	unsigned long	gp_seq;		/* Track rsp->gp_seq. */
>  	unsigned long	gp_seq_needed;	/* Track furthest future GP request. */
>  	union rcu_noqs	cpu_no_qs;	/* No QSes yet for this CPU. */
>  	bool		core_needs_qs;	/* Core waits for quiesc state. */
> -- 
> 2.20.1 (Apple Git-117)
> 
