Return-Path: <SRS0=//1+=4O=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A40C4BA12
	for <rcu@archiver.kernel.org>; Wed, 26 Feb 2020 14:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F2824685
	for <rcu@archiver.kernel.org>; Wed, 26 Feb 2020 14:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbgBZO6N (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 26 Feb 2020 09:58:13 -0500
Received: from netrider.rowland.org ([192.131.102.5]:58939 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727247AbgBZO6N (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 26 Feb 2020 09:58:13 -0500
Received: (qmail 5669 invoked by uid 500); 26 Feb 2020 09:58:12 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Feb 2020 09:58:12 -0500
Date:   Wed, 26 Feb 2020 09:58:12 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Boqun Feng <boqun.feng@gmail.com>
cc:     linux-kernel@vger.kernel.org, <rcu@vger.kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] tools/memory-model: Remove lock-final checking in lock.cat
In-Reply-To: <20200226032142.89424-1-boqun.feng@gmail.com>
Message-ID: <Pine.LNX.4.44L0.2002260953110.3674-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, 26 Feb 2020, Boqun Feng wrote:

> In commit 30b795df11a1 ("tools/memory-model: Improve mixed-access
> checking in lock.cat"), we have added the checking to disallow any
> normal memory access to lock variables, and this checking is stronger
> than lock-final. So remove the lock-final checking as it's unnecessary
> now.

I don't understand this description.  Why do you say that the
normal-access checking is stronger than the lock-final check?

> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  tools/memory-model/lock.cat | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/tools/memory-model/lock.cat b/tools/memory-model/lock.cat
> index 6b52f365d73a..827a3646607c 100644
> --- a/tools/memory-model/lock.cat
> +++ b/tools/memory-model/lock.cat
> @@ -54,9 +54,6 @@ flag ~empty LKR \ domain(lk-rmw) as unpaired-LKR
>   *)
>  empty ([LKW] ; po-loc ; [LKR]) \ (po-loc ; [UL] ; po-loc) as lock-nest
>  
> -(* The final value of a spinlock should not be tested *)
> -flag ~empty [FW] ; loc ; [ALL-LOCKS] as lock-final
> -
>  (*
>   * Put lock operations in their appropriate classes, but leave UL out of W
>   * until after the co relation has been generated.

With this check removed, what will prevent people from writing litmus 
tests like this?

C test

{
	spinlock_t s;
}

...

exists (s=0)

Alan

