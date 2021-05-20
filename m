Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A94FC433B4
	for <rcu@archiver.kernel.org>; Thu, 20 May 2021 04:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55619611AE
	for <rcu@archiver.kernel.org>; Thu, 20 May 2021 04:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbhETEz6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 20 May 2021 00:55:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhETEz5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 20 May 2021 00:55:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EAE36611AE;
        Thu, 20 May 2021 04:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621486477;
        bh=tICblB9mQvGI4hN9nbNzzLVdfmdbVNWvAYGuEq4XSTI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eL6jnNSZTzTv4LtahS/Q6sFQ8fupm904Xunci9IYUbHG4ek9FUNttoWMsNwuSPEvf
         XJGaCYk61cujtohJ982LVFd9vIZJATR0f3B0RoDd50TN71phVuOvRI6pElbq83eFd7
         isOim5xGmti1Hhg0Ys3OVZZnBq4nuwrbTcw8cUYmuHgIfc5IYZFXZ+BaGv0sj9pzRu
         0+OoYNsykrEW19yBPSz9FgqDtYolxeiSTof5bLRsFdxZbWXGJOm9FfvwBm9uk0sCPY
         LtRRZNbsDylCV2mEL7mDlbK1BrH+UoVVaRMKVhcvqSSN0bUuOG2pACAUoJAeTv/aKY
         sxySCvBvuaKQQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BE1695C0138; Wed, 19 May 2021 21:54:36 -0700 (PDT)
Date:   Wed, 19 May 2021 21:54:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 1/3] rcu/nocb: Start moving nocb code to its own plugin
 file
Message-ID: <20210520045436.GG4441@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210519000930.15702-1-frederic@kernel.org>
 <20210519000930.15702-2-frederic@kernel.org>
 <20210519155508.GX4441@paulmck-ThinkPad-P17-Gen-1>
 <20210520010254.GC22836@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520010254.GC22836@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, May 20, 2021 at 03:02:54AM +0200, Frederic Weisbecker wrote:
> On Wed, May 19, 2021 at 08:55:08AM -0700, Paul E. McKenney wrote:
> > On Wed, May 19, 2021 at 02:09:28AM +0200, Frederic Weisbecker wrote:
> > > tree_plugin.h is now gathering not only the (no)preempt-rcu specifics
> > > but also other features like NO_CB. As the latter has grown quite in
> > > complexity and volume, it's may be a good idea to start moving the
> > > related code to its own file so we don't need to browse thousand lines
> > > to find what we need.
> > > 
> > > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > 
> > Applied with the usual wordsmithing, thank you!
> > 
> > But for consistency with the other similar files included by
> > kernel/rcu/tree.c, should the name instead be kernel/rcu/tree_nocb.h?
> 
> Ah yes, I hesitated but tree_nocb.h is indeed more consistent. Can I let
> you do the rename?

Done!

> > Also, if Ingo and I are one the author list, shouldn't you be as well?  ;-)
> 
> Heh, alright feel free to add the following as a fixup :-)

And again, done.  Or will be at the next rebase, anyway.

							Thanx, Paul

> diff --git a/kernel/rcu/nocb.h b/kernel/rcu/nocb.h
> index a7783923833e..bf2690ca5d2b 100644
> --- a/kernel/rcu/nocb.h
> +++ b/kernel/rcu/nocb.h
> @@ -6,9 +6,11 @@
>   *
>   * Copyright Red Hat, 2009
>   * Copyright IBM Corporation, 2009
> + * Copyright SUSE, 2021
>   *
>   * Author: Ingo Molnar <mingo@elte.hu>
>   *	   Paul E. McKenney <paulmck@linux.ibm.com>
> + *	   Frederic Weisbecker <frederic@kernel.org>
>   */
>  
>  #ifdef CONFIG_RCU_NOCB_CPU
> 
> 
> Or perhaps you prefer a separate patch?
> 
> Thanks!
