Return-Path: <SRS0=GKHO=C2=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38028C43463
	for <rcu@archiver.kernel.org>; Thu, 17 Sep 2020 20:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFA58208B8
	for <rcu@archiver.kernel.org>; Thu, 17 Sep 2020 20:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600376328;
	bh=2PvhM/F1OEUd99gfkwpe+Tfj6xhGmnRpVcP1W3ityHo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=dhxAPvmFrXQyLeQeLn7Sbvo5ddEBsm8wQLEUhYj+S/99bCiODVCGnjukcb32yRy7D
	 2fgVtn7UMwJ1a7j4DH/G98U1X3tRTbFyXiJhdg8yYY2bxVgwgKpTvmvf4LQKJQCC/C
	 3yUObLEnmowfzMUtUaUmqoqBXa3FXYLPBGP/uuBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgIQU6q (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 17 Sep 2020 16:58:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:43780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbgIQU6p (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 17 Sep 2020 16:58:45 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D34D62087D;
        Thu, 17 Sep 2020 20:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600376324;
        bh=2PvhM/F1OEUd99gfkwpe+Tfj6xhGmnRpVcP1W3ityHo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=iTpZ5NG9C4uO/amiNGJ0ti7FHtByUvTqnZr2/4P1ojzW0DzQU9BuW5RX6na4EbViK
         CqxGRMf1PYNmxm9aGkfo3qvxDN2AnJRN3+jjXayWTj1P7hHxOWDeyqId5OmCwcjYCE
         k2AYUJYv8AeppkD0w6Zi9Y1EWhXhzcJgMa4vaDt4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 97FA13522887; Thu, 17 Sep 2020 13:58:44 -0700 (PDT)
Date:   Thu, 17 Sep 2020 13:58:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        jiangshanlai@gmail.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        rcu@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: GPF from __srcu_read_lock() via drm_minor_acquire()
Message-ID: <20200917205844.GA1978@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAKwvOdm4AQhobdkKT08bjPGb15N58QN79XWxEaQt-P5Dk4+avQ@mail.gmail.com>
 <20200916213730.GE29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916213730.GE29330@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Sep 16, 2020 at 02:37:30PM -0700, Paul E. McKenney wrote:
> On Wed, Sep 16, 2020 at 01:48:22PM -0700, Nick Desaulniers wrote:
> > Hey Paul and RCU folks,
> > I noticed we have a bug report from 2 users that seem to have similar
> > stack traces in SRCU code;
> > https://github.com/ClangBuiltLinux/linux/issues/1081
> > 
> > Is there a way we should go about starting to debug this?
> 
> Hello, Nick,
> 
> Huh.  It looks like the per-CPU memory referenced by the srcu_struct
> structure's ->sda field is unmapped.  That would certainly leave
> the next __srcu_read_lock() dazed and confused!
> 
> The trapping instruction is the increment instruction that I would
> expect to be there.  The source code is as follows:
> 
> 	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
> 	this_cpu_inc(ssp->sda->srcu_lock_count[idx]);
> 	smp_mb();
> 
> Looking at the assembly:
> 
> 	  1e:	55                   	push   %ebp
> 	  1f:	89 e5                	mov    %esp,%ebp
> 
> The above is function preamble.
> 
> 	  21:	8b 48 68             	mov    0x68(%eax),%ecx
> 
> The above instruction does READ_ONCE(ssp->srcu_idx).
> 
> 	  24:	8b 40 7c             	mov    0x7c(%eax),%eax
> 
> The above instruction fetches ssp->sda into %eax.  I therefore find it
> quite surprising that the dump contains "EAX: 00000000".  Or is this
> register value inaccurate?
> 
> 	  27:	83 e1 01             	and    $0x1,%ecx
> 
> The above instruction does the "& 0x1".  Therefore, at this point,
> %eax contains the address of the per-CPU srcu_data structure, but
> without the per-CPU offset having been applied.  Also, %ecx contains
> the array index, either 0 or 1.  Here we have zero, which is perfectly
> legitimate.
> 
> 	  2a:*	64 ff 04 88          	incl   %fs:(%eax,%ecx,4)
> 
> The above instruction does the this_cpu_inc().  Here %fs is presumably
> this CPU's offset from the base address of the per-CPU ->sda pointer.
> 
> 	  2e:	f0 83 44 24 fc 00    	lock addl $0x0,-0x4(%esp)
> 
> The above instruction is the smp_mb().
> 
> So here are a few questions that I would ask:

Oh, and this one:

0.	Did someone call srcu_read_lock() before init_srcu_struct()
	had been called on this srcu_struct structure?

							Thanx, Paul

> 1.	Did the init_srcu_struct() for this srcu_struct report an error?
> 	(Though with current mainline, that memory-allocation failure
> 	would more likely have page-faulted in init_srcu_struct().)
> 
> 2.	Has the srcu_struct in question already been passed to
> 	cleanup_srcu_struct()?
> 
> 3.	Has the value of %fs been clobbered?  Though that seems
> 	unlikely given that it also happens on aarch64.  Plus, the
> 	smoking gun seems to me to be the zero value of %eax.
> 
> 4.	If the above three questions fail to provide enlightenment,
> 	I suggest recording the ->sda value and adding debug checks
> 	to anything that can unmap memory...  And recording the value
> 	of ->sda somewhere to check to see if it is being changed (it
> 	should remain constant from init_srcu_struct()'s return through
> 	the corresponding call to cleanup_srcu_struct()).
> 
> Please let me know how it goes!
> 
> 							Thanx, Paul
