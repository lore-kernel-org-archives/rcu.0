Return-Path: <SRS0=LYSJ=3T=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0196C2D0DB
	for <rcu@archiver.kernel.org>; Thu, 30 Jan 2020 15:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA74D206D5
	for <rcu@archiver.kernel.org>; Thu, 30 Jan 2020 15:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgA3PUv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 30 Jan 2020 10:20:51 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33392 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbgA3PUv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 30 Jan 2020 10:20:51 -0500
Received: from [109.134.33.162] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1ixBca-0004pl-BA; Thu, 30 Jan 2020 15:20:44 +0000
Date:   Thu, 30 Jan 2020 16:20:43 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     madhuparnabhowmik10@gmail.com, peterz@infradead.org,
        mingo@kernel.org, paulmck@kernel.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org,
        linux-kernel-mentees@lists.linuxfoundation.org, rcu@vger.kernel.org
Subject: Re: [PATCH] exit.c: Fix Sparse errors and warnings
Message-ID: <20200130152043.kgcf5s6h6qaalpbl@wittgenstein>
References: <20200130062028.4870-1-madhuparnabhowmik10@gmail.com>
 <20200130103158.azxldyfnugwvv6vy@wittgenstein>
 <20200130113339.GA25426@redhat.com>
 <32DE6B3E-ADC3-49EB-888C-CABCF82330FE@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <32DE6B3E-ADC3-49EB-888C-CABCF82330FE@ubuntu.com>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jan 30, 2020 at 12:45:26PM +0100, Christian Brauner wrote:
> On January 30, 2020 12:33:41 PM GMT+01:00, Oleg Nesterov <oleg@redhat.com> wrote:
> >On 01/30, Christian Brauner wrote:
> >>
> >> On Thu, Jan 30, 2020 at 11:50:28AM +0530,
> >madhuparnabhowmik10@gmail.com wrote:
> >> > From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> >> >
> >> > This patch fixes the following sparse error:
> >> > kernel/exit.c:627:25: error: incompatible types in comparison
> >expression
> >> >
> >> > And the following warning:
> >> > kernel/exit.c:626:40: warning: incorrect type in assignment
> >> >
> >> > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> >>
> >> I think the previous version was already fine but hopefully
> >> RCU_INIT_POINTER() really saves some overhead. In any case:
> >
> >It is not about overhead, RCU_INIT_POINTER() documents the fact that we
> >didn't make any changes to the new parent, we only need to change the
> >pointer.
> 
> Right, I wasn't complaining.  RCU_INIT_POINTER() claims that it has less overhead than rcu_assign_pointer().
> So that is an additional argument for it.
> 
> >
> >And btw, I don't really understand the __rcu annotations. Say,
> >according
> >to sparse this code is wrong:
> >
> >	int __rcu *P;
> >
> >	void func(int *p)
> >	{
> >		P = p;
> >	}
> >
> >OK, although quite possibly it is fine.
> >
> >However, this code
> >
> >	int __rcu *P;
> >
> >	void func(int __rcu *p)
> >	{
> >		*p = 10;
> >	       	P = p;
> >	}
> >
> >is almost certainly wrong but sparse is happy, asn is the same.
> 
> That's more an argument to fix sparse I guess?
> The annotations themselves are rather useful I think.
> They at least help me when reading the code.
> It's not that rcu lifetimes are trivial and anything that helps remind me that an object wants rcu semantics I'm happy to take it. :)
> 
> >
> >
> >> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> >
> >Acked-by: Oleg Nesterov <oleg@redhat.com>

Thanks, applied for post -rc1.
Christian
