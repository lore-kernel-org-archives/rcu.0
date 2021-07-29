Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A67C4338F
	for <rcu@archiver.kernel.org>; Thu, 29 Jul 2021 01:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B94C60F91
	for <rcu@archiver.kernel.org>; Thu, 29 Jul 2021 01:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbhG2BHp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 28 Jul 2021 21:07:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232837AbhG2BHo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 28 Jul 2021 21:07:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6694D6101C;
        Thu, 29 Jul 2021 01:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627520862;
        bh=Hv6M1j26+F17k/ROjaVlxH5eyQbp1ZGSZNs0YZEsPXc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=B8UpkPYvIfAa1n5O/m0WQe4tkpJf5aEZ0qzBgvvRAUuNMDLbihnOt+SGKY+aeD/CD
         c/CrUABS+WjMAynDzeUu6EaYQIl649hO1dZeofQY8Nx3jOsmpqzeA5yrYikBtypS94
         f72YGJ/Hb9r0v7adg9IcIYVjpmAwI2MNHugngfCHrSaAI9HxmbkYqZTmKfbyexZwuQ
         Lwv5kJ+idvyuvP/8M/2rMiMsPt0VYo3jo7Rt8D3js0wu57z/b+HjytOEG+LCDMbFY0
         m6a2myGyxw7EsNtXXZDwsyv27z1aZuH482ylX/vCMMHvmRINK6BPPr5q7RE1fSI3BP
         torVkqJqrapdg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 370655C048D; Wed, 28 Jul 2021 18:07:42 -0700 (PDT)
Date:   Wed, 28 Jul 2021 18:07:42 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, tglx@linutronix.de,
        peterz@infradead.org, rostedt@goodmis.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 rcu 04/18] rcu: Weaken ->dynticks accesses and updates
Message-ID: <20210729010742.GP4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
 <20210721202127.2129660-4-paulmck@kernel.org>
 <20210728173715.GA9416@paulmck-ThinkPad-P17-Gen-1>
 <YQG//899pPl2JIWw@localhost>
 <20210728204720.GN4397@paulmck-ThinkPad-P17-Gen-1>
 <20210728222333.GE293265@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728222333.GE293265@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 29, 2021 at 12:23:33AM +0200, Frederic Weisbecker wrote:
> On Wed, Jul 28, 2021 at 01:47:20PM -0700, Paul E. McKenney wrote:
> > On Wed, Jul 28, 2021 at 01:37:19PM -0700, Josh Triplett wrote:
> > > On Wed, Jul 28, 2021 at 10:37:15AM -0700, Paul E. McKenney wrote:
> > > > This change makes the memory ordering requirements
> > > > more evident, and it might well also speed up the to-idle and from-idle
> > > > fastpaths on some architectures.
> > > 
> > > Cleaning up the memory ordering requirements certainly seems worthwhile.
> > > But is there any straightforward benchmark that might quantify the
> > > "might well also speed up" here? How much does weakening the memory
> > > ordering buy us, in practice?
> > 
> > None that I know of!
> 
> I know two:
> 
> 1) The whole debate makes us review again (and again) the memory ordering
>    requirements in RCU VS dynticks-idle, which can only be good to enforce
>    correctness.
> 
> 2) The more we weaken the ordering, the better we grasp and understand the
>    underlying ordering requirements. Unnecessary full memory barriers tend to
>    obfuscate our ordering expectations, making the code less self-explanatory.
> 
> 3) I have terrible ideas to remove a full barrier in the dynticks idle path
>    that should work in practice but not in theory and therefore I'm never going
>    to talk about it unless everyone in the room is drunk.

Cute!

On #3/2, I don't drink, so I guess you have to leave me out.  ;-)

The other side of this coin is that weakening ordering often decreases
robustness and increases complexity.  In unquantifiable ways, of course,
which can make discussion of the tradeoffs problematic.

							Thanx, Paul
