Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAAFEB64DC
	for <rcu@archiver.kernel.org>; Mon, 10 Jul 2023 19:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjGJTMA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 10 Jul 2023 15:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjGJTL5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 10 Jul 2023 15:11:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96414E41;
        Mon, 10 Jul 2023 12:11:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9C05611B0;
        Mon, 10 Jul 2023 19:11:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5212EC433C7;
        Mon, 10 Jul 2023 19:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689016282;
        bh=IaTAT5yNUGeR3W4S6RtOVAB+wC9xrXDx396UDoHofIU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=l9O2PAEGjyZqmGjOUr/bY+0mQWUy1R5aPiTqR4w+NW1YWgSw6s5ic4h/kgGA66cci
         wIVTrRB7VYOdwtfFvmgkKmAnlNKs7CqcQ+6r1KhZKpfS86F/NAa/7eewlTp4iduOnI
         gS3gx8OFROE+M41r3sJXRCjNKPmn/0YAh7P1ywBgybvzHWcxCO3nqoe0HE2LQqWvGj
         OQ1lLOFev0N45bCj0FEOAoUO5bkNAasWY4zdx67oydrO10HEQaKG2F/LPhR7Y2DaK8
         2yC4pLcDFzEKM9d13/b17NI1S03Md7/hGmEiwEropmpw3lVm1D0xjV0LBSNpsAgOi1
         S/hNlBdFxEbTg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EA96FCE00C6; Mon, 10 Jul 2023 12:11:21 -0700 (PDT)
Date:   Mon, 10 Jul 2023 12:11:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Huang <mmpgouride@gmail.com>
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        boqun.feng@gmail.com, corbet@lwn.net, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] docs/RCU: Bring back smp_wmb()
Message-ID: <41aa064b-7d30-40a7-b454-0da2028f5669@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230706102849.437687-1-mmpgouride@gmail.com>
 <20230706102849.437687-3-mmpgouride@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706102849.437687-3-mmpgouride@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 06, 2023 at 10:28:49AM +0000, Alan Huang wrote:
> The objects are allocated with SLAB_TYPESAFE_BY_RCU, and there is
> n->next = first within hlist_add_head_rcu() before rcu_assign_pointer(),
> which modifies obj->obj_node.next. There may be readers holding the
> reference of obj in lockless_lookup, and when updater modifies ->next,
> readers can see the change immediately because of SLAB_TYPESAFE_BY_RCU.
> 
> There are two memory ordering required in the insertion algorithm,
> we need to make sure obj->key is updated before obj->obj_node.next
> and obj->refcnt, atomic_set_release is not enough to provide the
> required memory barrier.
> 
> Signed-off-by: Alan Huang <mmpgouride@gmail.com>
> ---
>  Documentation/RCU/rculist_nulls.rst | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
> index 21e40fcc08de..fa3729dc7e74 100644
> --- a/Documentation/RCU/rculist_nulls.rst
> +++ b/Documentation/RCU/rculist_nulls.rst
> @@ -64,7 +64,7 @@ but a version with an additional memory barrier (smp_rmb())
>    {
>      struct hlist_node *node, *next;
>      for (pos = rcu_dereference((head)->first);
> -         pos && ({ next = pos->next; smp_rmb(); prefetch(next); 1; }) &&
> +         pos && ({ next = READ_ONCE(pos->next); smp_rmb(); prefetch(next); 1; }) &&

This one looks good, though the READ_ONCE() becoming rcu_dereference()
would allow the smp_rmb() to be dropped, correct?

>           ({ obj = hlist_entry(pos, typeof(*obj), obj_node); 1; });
>           pos = rcu_dereference(next))
>        if (obj->key == key)
> @@ -112,7 +112,12 @@ detect the fact that it missed following items in original chain.
>    obj = kmem_cache_alloc(...);
>    lock_chain(); // typically a spin_lock()
>    obj->key = key;
> -  atomic_set_release(&obj->refcnt, 1); // key before refcnt
> +  /*
> +   * We need to make sure obj->key is updated before obj->obj_node.next
> +   * and obj->refcnt.
> +   */
> +  smp_wmb();
> +  atomic_set(&obj->refcnt, 1);

...but what is smp_wmb() doing that the combination of atomic_set_release()
and hlist_add_head_rcu() was not already doing?  What am I missing?

							Thanx, Paul

>    hlist_add_head_rcu(&obj->obj_node, list);
>    unlock_chain(); // typically a spin_unlock()
>  
> -- 
> 2.34.1
> 
