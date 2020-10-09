Return-Path: <SRS0=v0Re=DQ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5145C433DF
	for <rcu@archiver.kernel.org>; Fri,  9 Oct 2020 20:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91220221FD
	for <rcu@archiver.kernel.org>; Fri,  9 Oct 2020 20:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602274706;
	bh=L0qpncHGg/+Qtn1TS4oa9yI5owIYAKhg9hD49e2xzDE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ElrWFi5LCVoM/689Rr3qGPLUm2Gw+D5p9oR1jJEypUSOgydzNp6BUU+sNNVCARdZg
	 QhWQv+alHcCp/91Ghqm7WmuqZ2Jp0OOBuUL/zBXXmpoVxXMACNB2yOu7zbaGj1xNAj
	 S9RVNlD1+xISfCKgANtteq7YYZ9IwhMbASht8+Ok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387846AbgJIUS0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 9 Oct 2020 16:18:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732506AbgJIUS0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 9 Oct 2020 16:18:26 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A59D2222F;
        Fri,  9 Oct 2020 20:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602274705;
        bh=L0qpncHGg/+Qtn1TS4oa9yI5owIYAKhg9hD49e2xzDE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=n/kZTsz7OUCX9r0SBPNjt0gGxOc6JoczmJKmT7ge+BteHzykuOTG2w6bHQ+k8Idov
         Ru13C1wEUaLa8pFmpK4EsIJZyFItJHMzvV32MM8SCShoPCfxq8YoFUWCQFVaSb5xBH
         X3YDGRGkbN8K3jwAGI+vvhDg12rRGJBNoTKe6RQU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5E9C235227D5; Fri,  9 Oct 2020 13:18:25 -0700 (PDT)
Date:   Fri, 9 Oct 2020 13:18:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     trix@redhat.com
Cc:     dave@stgolabs.net, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, natechancellor@gmail.com,
        ndesaulniers@google.com, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] rcutorture: remove unneeded check
Message-ID: <20201009201825.GL29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201009194736.2364-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009194736.2364-1-trix@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Oct 09, 2020 at 12:47:36PM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> clang static analysis reports this problem:
> 
> rcutorture.c:1999:2: warning: Called function pointer
>   is null (null dereference)
>         cur_ops->sync(); /* Later readers see above write. */
>         ^~~~~~~~~~~~~~~
> 
> This is a false positive triggered by an earlier, later ignored
> NULL check of sync() op.  By inspection of the rcu_torture_ops,
> the sync() op is never uninitialized.  So this earlier check is
> not needed.

You lost me on this one.  This check is at the very beginning of
rcu_torture_fwd_prog_nr().  Or are you saying that clang is seeing an
earlier check in one of rcu_torture_fwd_prog_nr()'s callers?  If so,
where exactly is this check?

In any case, the check is needed because all three functions are invoked
if there is a self-propagating RCU callback that ensures that there is
always an RCU grace period outstanding.

Ah.  Is clang doing local analysis and assuming that because there was
a NULL check earlier, then the pointer might be NULL later?  That does
not seem to me to be a sound check.

So please let me know exactly what is causing clang to emit this
diagnostic.  It might or might not be worth fixing this, but either way
I need to understand the situation so as to be able to understand the
set of feasible fixes.

						Thanx, Paul

> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  kernel/rcu/rcutorture.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index beba9e7963c8..6efc03a1d623 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -1989,7 +1989,7 @@ static void rcu_torture_fwd_prog_nr(struct rcu_fwd *rfp,
>  	unsigned long stopat;
>  	static DEFINE_TORTURE_RANDOM(trs);
>  
> -	if  (cur_ops->call && cur_ops->sync && cur_ops->cb_barrier) {
> +	if  (cur_ops->call && cur_ops->cb_barrier) {
>  		init_rcu_head_on_stack(&fcs.rh);
>  		selfpropcb = true;
>  	}
> -- 
> 2.18.1
> 
