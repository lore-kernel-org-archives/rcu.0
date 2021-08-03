Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FF7C4320A
	for <rcu@archiver.kernel.org>; Tue,  3 Aug 2021 17:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3114061078
	for <rcu@archiver.kernel.org>; Tue,  3 Aug 2021 17:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237732AbhHCRKu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 3 Aug 2021 13:10:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237778AbhHCRKq (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 3 Aug 2021 13:10:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B084060FA0;
        Tue,  3 Aug 2021 17:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628010635;
        bh=65H+ei0xpb7hD93+xQLQh+UXg0XMzVOm0QSLXIuPCOQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=l+/rSNSwMY9Uy/snzLVdv4wXRBdoP9L1d9JVnCFqda1sSJ3vQWqPyyDKoZ6ftmcir
         S+3jGYRb34qgQvd7Mngo2YwsOH6e/scU7bu0+z/gumfXu9d7D/M2XwM+tT+Fgf42KO
         +Qs2EquDdPWrgMMVm61StasHCsi127X/IJ70w/p+LMdfos2pdbRugPS4jA9RB5JOjT
         n/MeJP9IE0kjMoVw+GUv95kbaBu0RB9+Z1Bt35PDKYQwiyoh3A1c//Gt0MIwgwyB7+
         HlPXsJb0Jr5hEB1Q1FV1ScTD5+CbYWgta+cC1v+2WYr8s7wk6bNl7MaN9AUda6uGwZ
         WgJTIv9YfKlkw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7B82E5C04D4; Tue,  3 Aug 2021 10:10:35 -0700 (PDT)
Date:   Tue, 3 Aug 2021 10:10:35 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Liu Song <liu.song11@zte.com.cn>
Subject: Re: [PATCH rcu 15/18] rcu: Remove useless "ret" update in
 rcu_gp_fqs_loop()
Message-ID: <20210803171035.GU4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
 <20210721202127.2129660-15-paulmck@kernel.org>
 <5a494dd8d0e04030204f61067cb1010ef0c78f27.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a494dd8d0e04030204f61067cb1010ef0c78f27.camel@perches.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 03, 2021 at 09:48:23AM -0700, Joe Perches wrote:
> On Wed, 2021-07-21 at 13:21 -0700, Paul E. McKenney wrote:
> > From: Liu Song <liu.song11@zte.com.cn>
> > 
> > Within rcu_gp_fqs_loop(), the "ret" local variable is set to the
> > return value from swait_event_idle_timeout_exclusive(), but "ret" is
> > unconditionally overwritten later in the code.  This commit therefore
> > removes this useless assignment.
> []
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> []
> > @@ -1960,8 +1960,8 @@ static noinline_for_stack void rcu_gp_fqs_loop(void)
> >  		trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
> >  				       TPS("fqswait"));
> >  		WRITE_ONCE(rcu_state.gp_state, RCU_GP_WAIT_FQS);
> > -		ret = swait_event_idle_timeout_exclusive(
> > -				rcu_state.gp_wq, rcu_gp_fqs_check_wake(&gf), j);
> > +		(void)swait_event_idle_timeout_exclusive(rcu_state.gp_wq,
> > +				 rcu_gp_fqs_check_wake(&gf), j);
> 
> It doesn't seem this is a __must_check routine so why
> bother to cast to void ?

As a hint to the reader that discarding the return value is intentional
rather than an oversight.

							Thanx, Paul

> >  		rcu_gp_torture_wait();
> >  		WRITE_ONCE(rcu_state.gp_state, RCU_GP_DOING_FQS);
> >  		/* Locking provides needed memory barriers. */
> 
> 
