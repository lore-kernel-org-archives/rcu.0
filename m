Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C41C001DE
	for <rcu@archiver.kernel.org>; Fri, 14 Jul 2023 23:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjGNXXJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Jul 2023 19:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjGNXXI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Jul 2023 19:23:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D05198A;
        Fri, 14 Jul 2023 16:23:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93FD161E19;
        Fri, 14 Jul 2023 23:23:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83AFC433C9;
        Fri, 14 Jul 2023 23:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689376987;
        bh=Bq8mT5NowggKChVIveBcI4YHxzhRtHrerMWKoRsw5Pw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CusJZKSPNDZYaHuGoZLW0RNiN1XPXxFZWs4sjPPZrFunnq+0g3supEXXDQLCnojTU
         5ZwSZq3nvymu/yqtJC9IPL/TGL8rkEf1CLVeMy9ll8xZUxb9GBV2lOrbZw4Ngk2GNj
         LY6W/izS72cG8VBIdAmfihLm/g96aTiZf3fpc9pAUmigZD15uIanejpunbxAO/OWE7
         eTQ5xQfYyejaKcR/FV+pyckTsDlxDwHug/RYbBtRjCcV7OK0s5SQojpm2Zs8aBX3FB
         BqlbSWlXo223i97Z3BOLA4MxyodvwN/jEvXHy7wrzhxherAskioT8vVptpKLcbz0zX
         YZ65S1yJ2eKww==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7E86ECE0123; Fri, 14 Jul 2023 16:23:06 -0700 (PDT)
Date:   Fri, 14 Jul 2023 16:23:06 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Huang <mmpgouride@gmail.com>
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        boqun.feng@gmail.com, corbet@lwn.net, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] docs/RCU: Bring back smp_wmb()
Message-ID: <9eaf506f-cc14-4da6-9efc-057c0c3e56b0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230711150906.466434-1-mmpgouride@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711150906.466434-1-mmpgouride@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jul 11, 2023 at 03:09:06PM +0000, Alan Huang wrote:
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

This is an interesting one!!!

Now I am having a hard time believing that the smp_rmb() suffices.

> ---
> Changelog:
>   v1 -> v2: Use _ONCE to protect obj->key.
> 
>  Documentation/RCU/rculist_nulls.rst | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
> index 21e40fcc08de..2a9f5a63d334 100644
> --- a/Documentation/RCU/rculist_nulls.rst
> +++ b/Documentation/RCU/rculist_nulls.rst
> @@ -47,7 +47,7 @@ objects, which is having below type.
>      * reuse these object before the RCU grace period, we
>      * must check key after getting the reference on object
>      */
> -    if (obj->key != key) { // not the object we expected
> +    if (READ_ONCE(obj->key) != key) { // not the object we expected
>        put_ref(obj);
>        rcu_read_unlock();
>        goto begin;
> @@ -64,10 +64,10 @@ but a version with an additional memory barrier (smp_rmb())
>    {
>      struct hlist_node *node, *next;
>      for (pos = rcu_dereference((head)->first);
> -         pos && ({ next = pos->next; smp_rmb(); prefetch(next); 1; }) &&
> +         pos && ({ next = READ_ONCE(pos->next); smp_rmb(); prefetch(next); 1; }) &&

Suppose that lockless_lookup() is delayed just before fetching pos->next,
and that there were 17 more node to search in the list.

Then consider the following sequence of events:

o	The updater deletes this same node and kmem_cache_free()s it.

o	Another updater kmem_cache_alloc()s that same memory and
	inserts it into an empty hash chain with a different key.

o	Then lockless_lookup() fetches pos->next and sees a NULL pointer,
	thus failing to search the remaining 17 nodes in the list,
	one of which had the desired key value.

o	The lookup algorithm resumes and sees the NULL return from
	lockless_lookup(), and ends up with a NULL obj.

	And this happens even with the strongest possible ordering
	everywhere.

OK, yes, it is late on Friday.  So what am I missing here?

Independent of that, does hlist_add_head_rcu() need to replace its
"n->next = first" with "WRITE_ONCE(n->next, first)"?

						Thanx, Paul

>           ({ obj = hlist_entry(pos, typeof(*obj), obj_node); 1; });
>           pos = rcu_dereference(next))
> -      if (obj->key == key)
> +      if (READ_ONCE(obj->key) == key)
>          return obj;
>      return NULL;
>    }
> @@ -111,8 +111,13 @@ detect the fact that it missed following items in original chain.
>     */
>    obj = kmem_cache_alloc(...);
>    lock_chain(); // typically a spin_lock()
> -  obj->key = key;
> -  atomic_set_release(&obj->refcnt, 1); // key before refcnt
> +  WRITE_ONCE(obj->key, key);
> +  /*
> +   * We need to make sure obj->key is updated before obj->obj_node.next
> +   * and obj->refcnt.
> +   */
> +  smp_wmb();
> +  atomic_set(&obj->refcnt, 1);
>    hlist_add_head_rcu(&obj->obj_node, list);
>    unlock_chain(); // typically a spin_unlock()
>  
> @@ -165,12 +170,12 @@ Note that using hlist_nulls means the type of 'obj_node' field of
>    begin:
>    rcu_read_lock();
>    hlist_nulls_for_each_entry_rcu(obj, node, head, obj_node) {
> -    if (obj->key == key) {
> +    if (READ_ONCE(obj->key) == key) {
>        if (!try_get_ref(obj)) { // might fail for free objects
>  	rcu_read_unlock();
>          goto begin;
>        }
> -      if (obj->key != key) { // not the object we expected
> +      if (READ_ONCE(obj->key) != key) { // not the object we expected
>          put_ref(obj);
>  	rcu_read_unlock();
>          goto begin;
> @@ -206,7 +211,7 @@ hlist_add_head_rcu().
>     */
>    obj = kmem_cache_alloc(cachep);
>    lock_chain(); // typically a spin_lock()
> -  obj->key = key;
> +  WRITE_ONCE(obj->key, key);
>    atomic_set_release(&obj->refcnt, 1); // key before refcnt
>    /*
>     * insert obj in RCU way (readers might be traversing chain)
> -- 
> 2.34.1
> 
