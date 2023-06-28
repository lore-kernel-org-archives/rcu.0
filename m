Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879BFEB64D7
	for <rcu@archiver.kernel.org>; Wed, 28 Jun 2023 17:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjF1Rim (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 28 Jun 2023 13:38:42 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:51728 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjF1Ril (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 28 Jun 2023 13:38:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C738561408
        for <rcu@vger.kernel.org>; Wed, 28 Jun 2023 17:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA0FC433C8;
        Wed, 28 Jun 2023 17:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687973920;
        bh=Q6yM//pVwi9E0luzrkgH54PhcqKCZoxQtodXfYVlXQw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UNbDwr2qZYaJbiI+vtdigJ499Li+Rk+sKee2XuYGllb6MDtI1KbHGLa+hWDLQwylX
         gKgQ9sqKh/50KKRRlRX++D6xWbXPfWp6ZaBckjYvQo2R0ksGqVqLC/+M+Z9O36Qcon
         mo98SILsX+GmyemzIAdTlQCoJ6WzAIztbsjrOKb5nXBCFhJ2QqxzwLkY2LRj+Encm0
         9LZSP7kj0JpFKqztahMluX49zh+wGHSaXwHFhCF+FUZ6DqGQaVOFX8ajyeZpn2VGN2
         kJI2KM9wa10Fl1D0B4sUaFhpf2zneVool9A/XIJK/gj514MPA+a2cdzrNhVl9nhRIc
         2+Fv1eOTqz4bA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id ADDCDCE39D5; Wed, 28 Jun 2023 10:38:39 -0700 (PDT)
Date:   Wed, 28 Jun 2023 10:38:39 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     Alexei Starovoitov <ast@meta.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>,
        rcu@vger.kernel.org, Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 09/13] bpf: Allow reuse from
 waiting_for_gp_ttrace list.
Message-ID: <9d88270e-01e7-4022-8332-940e13a5177a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
 <20230624031333.96597-10-alexei.starovoitov@gmail.com>
 <9cc35513-5522-9229-469b-7d691c9790e1@huaweicloud.com>
 <CAADnVQJViJh47Cze186XCS0_jeQMb1wu6BfVZiQL6982a_hhfg@mail.gmail.com>
 <417e4d9c-7b69-0b9a-07e3-9af4b3b3299f@huaweicloud.com>
 <2bf11b56-7494-c0a9-09d4-c9e41aaba850@meta.com>
 <957dd5cd-0855-1197-7045-4cb1590bd753@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <957dd5cd-0855-1197-7045-4cb1590bd753@huaweicloud.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jun 28, 2023 at 04:09:14PM +0800, Hou Tao wrote:
> Hi,
> 
> On 6/28/2023 8:59 AM, Alexei Starovoitov wrote:
> > On 6/26/23 12:16 AM, Hou Tao wrote:
> >> Hi,
> >>
> >> On 6/26/2023 12:42 PM, Alexei Starovoitov wrote:
> >>> On Sun, Jun 25, 2023 at 8:30 PM Hou Tao <houtao@huaweicloud.com> wrote:
> >>>> Hi,
> >>>>
> >>>> On 6/24/2023 11:13 AM, Alexei Starovoitov wrote:
> >>>>> From: Alexei Starovoitov <ast@kernel.org>
> >>>>>
> >>>>> alloc_bulk() can reuse elements from free_by_rcu_ttrace.
> >>>>> Let it reuse from waiting_for_gp_ttrace as well to avoid
> >>>>> unnecessary kmalloc().
> >>>>>
> >>>>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> >>>>> ---
> >>>>>   kernel/bpf/memalloc.c | 9 +++++++++
> >>>>>   1 file changed, 9 insertions(+)
> >>>>>
> SNIP
> >>        // free A (from c1), ..., last free X (allocated from c0)
> >>      P3: unit_free(c1)
> >>          // the last freed element X is from c0
> >>          c1->tgt = c0
> >>          c1->free_llist->first -> X -> Y -> ... -> A
> >>      P3: free_bulk(c1)
> >>          enque_to_free(c0)
> >>              c0->free_by_rcu_ttrace->first -> A -> ... -> Y -> X
> >>          __llist_add_batch(c0->waiting_for_gp_ttrace)
> >>              c0->waiting_for_gp_ttrace = A -> ... -> Y -> X
> >
> > In theory that's possible, but for this to happen one cpu needs
> > to be thousand times slower than all others and since there is no
> > preemption in llist_del_first I don't think we need to worry about it.
> 
> Not sure whether or not such case will be possible in a VM, after all,
> the CPU X is just a thread in host and it may be preempted in any time
> and with any duration.

vCPU preemption can happen even with guest-OS interrupts disabled, and
such preemption can persist for hundreds of milliseconds, or even for
several seconds.  So admittedly quite rare, but also quite possible.

							Thanx, Paul

> > Also with removal of _tail optimization the above
> > llist_add_batch(waiting_for_gp_ttrace)
> > will become a loop, so reused element will be at the very end
> > instead of top, so one cpu to million times slower which is not
> > realistic.
> 
> It is still possible A will be added back as
> waiting_for_gp_ttrace->first after switching to llist_add() as shown
> below. My questions is how much is the benefit for reusing from
> waiting_for_gp_ttrace ?
> 
>     // free A (from c1), ..., last free X (allocated from c0) 
>     P3: unit_free(c1)
>         // the last freed element X is allocated from c0
>         c1->tgt = c0
>         c1->free_llist->first -> A -> ... -> Y
>         c1->free_llist_extra -> X
> 
>     P3: free_bulk(c1)
>         enque_to_free(c0) 
>             c0->free_by_rcu_ttrace->first -> Y -> ... A
>             c0->free_by_rcu_ttrace->first -> X -> Y -> ... A
> 
>         llist_add(c0->waiting_for_gp_ttrace)
>             c0->waiting_for_gp_ttrace = A -> .. -> Y -> X
> 
> >
> >> P1:
> >>      // A is added back as first again
> >>      // but llist_del_first() didn't know
> >>      try_cmpxhg(&c0->waiting_for_gp_ttrace->first, A, B)
> >>      // c0->waiting_for_gp_trrace is corrupted
> >>      c0->waiting_for_gp_ttrace->first = B
> >>
> 
