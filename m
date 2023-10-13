Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC30DCDB47E
	for <rcu@archiver.kernel.org>; Fri, 13 Oct 2023 14:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjJMOLi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 Oct 2023 10:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjJMOLh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 Oct 2023 10:11:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC68B95;
        Fri, 13 Oct 2023 07:11:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5DAC433C7;
        Fri, 13 Oct 2023 14:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697206295;
        bh=+PECLI9eBN9g/xFj5AEB+74Ye35V4f2WaKGkW1ZEKKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BnsSZunhbumt27t6QNpFdC+OC2qbIq/aHnuBErdQSipTrEhM3wnp5vEEH8dW4vjhy
         Mf/rU6G+T9Pxcq65tlehM4fmxOjG5p2QiDsiXecCwrjSCpEgZwYglQcZSWcKOXT+NP
         vimcoNn8kNsT+3FeIcBpN7xtFOotJ8QKOuKFxLf//xeG/y4WaiB5gSHuL1bn2uuUac
         JjQAkE5vX5FTTtyFGZf1XqKayxWYbrDyG/iYD9xGJ9GyORi3IIuJQKff8zDj1uhv86
         zcsmrRjH+8W7NFWJTX2NI5u+ZV7ddg2A5VSN/wfwjlrV/OsvnfFdvnAO2fyooD23f/
         VMqnihC89mqFQ==
Date:   Fri, 13 Oct 2023 16:11:32 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Denis Arefev <arefev@swemel.ru>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 09/18] srcu: Fix srcu_struct node grpmask overflow on
 64-bit systems
Message-ID: <ZSlQFGIyQGoYETzV@lothringen>
References: <20231013115902.1059735-1-frederic@kernel.org>
 <20231013115902.1059735-10-frederic@kernel.org>
 <f6cc79b13ccf471aa275bee88559b6bd@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6cc79b13ccf471aa275bee88559b6bd@AcuMS.aculab.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Oct 13, 2023 at 12:54:32PM +0000, David Laight wrote:
> From: Frederic Weisbecker
> > Sent: 13 October 2023 12:59
> > 
> > The value of a bitwise expression 1 << (cpu - sdp->mynode->grplo)
> > is subject to overflow due to a failure to cast operands to a larger
> > data type before performing the bitwise operation.
> > 
> > The maximum result of this subtraction is defined by the RCU_FANOUT_LEAF
> > Kconfig option, which on 64-bit systems defaults to 16 (resulting in a
> > maximum shift of 15), but which can be set up as high as 64 (resulting
> > in a maximum shift of 63).  A value of 31 can result in sign extension,
> > resulting in 0xffffffff80000000 instead of the desired 0x80000000.
> > A value of 32 or greater triggers undefined behavior per the C standard.
> > 
> > This bug has not been known to cause issues because almost all kernels
> > take the default CONFIG_RCU_FANOUT_LEAF=16.  Furthermore, as long as a
> > given compiler gives a deterministic non-zero result for 1<<N for N>=32,
> > the code correctly invokes all SRCU callbacks, albeit wasting CPU time
> > along the way.
> > 
> > This commit therefore substitutes the correct 1UL for the buggy 1.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > 
> > Signed-off-by: Denis Arefev <arefev@swemel.ru>
> > Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Cc: David Laight <David.Laight@aculab.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >  kernel/rcu/srcutree.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 833a8f848a90..5602042856b1 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -223,7 +223,7 @@ static bool init_srcu_struct_nodes(struct srcu_struct *ssp, gfp_t gfp_flags)
> >  				snp->grplo = cpu;
> >  			snp->grphi = cpu;
> >  		}
> > -		sdp->grpmask = 1 << (cpu - sdp->mynode->grplo);
> > +		sdp->grpmask = 1UL << (cpu - sdp->mynode->grplo);
> >  	}
> >  	smp_store_release(&ssp->srcu_sup->srcu_size_state, SRCU_SIZE_WAIT_BARRIER);
> >  	return true;
> > @@ -835,7 +835,7 @@ static void srcu_schedule_cbs_snp(struct srcu_struct *ssp, struct srcu_node *snp
> >  	int cpu;
> > 
> >  	for (cpu = snp->grplo; cpu <= snp->grphi; cpu++) {
> > -		if (!(mask & (1 << (cpu - snp->grplo))))
> > +		if (!(mask & (1UL << (cpu - snp->grplo))))
> >  			continue;
> >  		srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, cpu), delay);
> >  	}
> 
> That loop is entirely horrid.
> The compiler almost certainly has to reload snp->grphi every iteration.
> Also it looks as though the bottom bit of mask is checked first.
> So how about:
> 	grphi = snp->grphi;
> 	for (cpu = snp->grplo; cpu <= grphi; cpu++, mask >>= 1) {
> 		if (!(mask & 1))
> 			continue;
> 		srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, cpu), delay);
> 	}

Well, it's cache-hot and RCU update side is not really a fast-path.
Not sure it's worth optimizing...

Thanks.

> 
> 	David		
> 
> > --
> > 2.34.1
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
