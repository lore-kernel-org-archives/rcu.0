Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDC3EB64D7
	for <rcu@archiver.kernel.org>; Tue, 20 Jun 2023 22:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjFTWdf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 20 Jun 2023 18:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjFTWde (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 20 Jun 2023 18:33:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B341DD;
        Tue, 20 Jun 2023 15:33:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAF35611CE;
        Tue, 20 Jun 2023 22:33:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1D7C433C8;
        Tue, 20 Jun 2023 22:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687300413;
        bh=gnqt6oUEhTYDpiDsL1m8G0459lKOTwcjaU1jKkLKKaQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kD+4bMzdZJUD8k8DrJSI2rb9QzIPVQkWR3yF38p9X7h8ri8ugqKTHVs0nOiwTREmV
         wXQWtMT/UUPEJ1vMv5o4u0UnkEjvhVKpQMwGG1ExvlD3DfQhFinInDKTjA3eytVEIX
         /KT/D1hGMkfKvPXtUJ7IrkxeeZbMohPlzBrD7sFnL8n3z4xfEPySMCmLlq7ykKt+Y/
         To+gqvyJVN7zPgEFhNfSf6jjstSc+TNCj26y4Of+mOSRG3IUt7PCEG6tcNpvQY02o+
         8ZiT1paQTRTua5DtNSg5uNsfzqOK5rhvnts4Uy12zW/Uy1CUEu20+Pm2Nh+eA0Q2it
         xHKVk8berYIzg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D01A9CE1CC5; Tue, 20 Jun 2023 15:33:32 -0700 (PDT)
Date:   Tue, 20 Jun 2023 15:33:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Huang <mmpgouride@gmail.com>
Cc:     joel@joelfernandes.org, corbet@lwn.net, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] docs/RCU: Bring smp_wmb() back
Message-ID: <002d991c-4064-4219-a4a1-ef98bba88a65@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230617145346.29009-1-mmpgouride@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230617145346.29009-1-mmpgouride@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Jun 17, 2023 at 02:53:46PM +0000, Alan Huang wrote:
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
> index e06ed40bb6..77244adbdf 100644
> --- a/Documentation/RCU/rculist_nulls.rst
> +++ b/Documentation/RCU/rculist_nulls.rst
> @@ -98,7 +98,7 @@ Quoting Corey Minyard::
>  ----------------------
>  
>  We need to make sure a reader cannot read the new 'obj->obj_node.next' value
> -and previous value of 'obj->key'. Otherwise, an item could be deleted
> +and previous value of 'obj->key' at the same time. Otherwise, an item could be deleted
>  from a chain, and inserted into another chain. If new chain was empty
>  before the move, 'next' pointer is NULL, and lockless reader can not
>  detect the fact that it missed following items in original chain.
> @@ -112,7 +112,12 @@ detect the fact that it missed following items in original chain.
>    obj = kmem_cache_alloc(...);
>    lock_chain(); // typically a spin_lock()
>    obj->key = key;
> -  atomic_set_release(&obj->refcnt, 1); // key before refcnt
> +  /*
> +  * we need to make sure obj->key is updated before obj->obj_node.next
> +  * and obj->refcnt
> +  */
> +  smp_wmb();
> +  atomic_set(&obj->refcnt, 1);

You lost me on this one.

From what I can see, in the original the atomic_set_release() provided
ordering between the ->key assignment and the ->refcnt assignment,
and then the rcu_assign_pointer() within hlist_add_head_rcu() provided
ordering between both the ->key and the ->refcnt assignments on the one
hand and the list insertion on the other.

What am I missing here?

							Thanx, Paul

>    hlist_add_head_rcu(&obj->obj_node, list);
>    unlock_chain(); // typically a spin_unlock()
>  
> -- 
> 2.34.1
> 
