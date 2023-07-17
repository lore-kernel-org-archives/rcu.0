Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6561EB64DC
	for <rcu@archiver.kernel.org>; Mon, 17 Jul 2023 16:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjGQQDO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 17 Jul 2023 12:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjGQQDC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 17 Jul 2023 12:03:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D339210E3;
        Mon, 17 Jul 2023 09:02:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44DC761130;
        Mon, 17 Jul 2023 16:02:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8FE6C433C7;
        Mon, 17 Jul 2023 16:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689609772;
        bh=kz67pJdDeLVMvg6C2eYTh5ExtzFt/9Kv7xrRNsw+4ps=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Mqpg1cisr2hxaGKjgMQFJNpjg3WRX4XmvptNnOIwuhoBg1Bt2x0yr/ON8zFuiYrQQ
         cP/GYawte7Eo0FsDTAkcflkI7UulANKELsuZn+8z53OfQwmEK1xCXLfw/zH8DsfntK
         E1kkp88QSCWN5+XijrdNNAfDkTNu7SKEVQ9+wX7LbzVtob7bo3fi5wyJuB1UcTPNkQ
         lAndy5kxNCkYjphhf/k0LFrICuDc06RSjRNccO5nl3ks+1QZJ1o3DdjG8Ft7i3csnC
         35eqyvxFMfcAuA061iB8x4K+qHonsPAsTaf2tk75nOTGaW5+LsCDIGFJltJqvYaYcN
         9DVrs5JwIpUWQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3C53DCE03F1; Mon, 17 Jul 2023 09:02:52 -0700 (PDT)
Date:   Mon, 17 Jul 2023 09:02:52 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Huang <mmpgouride@gmail.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>, corbet@lwn.net,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] docs/RCU: Bring back smp_wmb()
Message-ID: <02a84e4b-a322-4c43-ad9d-1832ce277c2f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230711150906.466434-1-mmpgouride@gmail.com>
 <9eaf506f-cc14-4da6-9efc-057c0c3e56b0@paulmck-laptop>
 <9D42CEB7-FE22-4BC6-9E5C-8131579C129D@gmail.com>
 <eabec10a-9283-42eb-85c7-e447e2368c91@paulmck-laptop>
 <6E813D30-2791-4DE8-A70C-E1F91011631D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6E813D30-2791-4DE8-A70C-E1F91011631D@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Jul 16, 2023 at 07:21:28PM +0800, Alan Huang wrote:
> > 2023年7月16日 01:19，Paul E. McKenney <paulmck@kernel.org> 写道：
> > On Sat, Jul 15, 2023 at 08:50:23AM +0800, Alan Huang wrote:
> >>> 2023年7月15日 07:23，Paul E. McKenney <paulmck@kernel.org> 写道：
> >>> On Tue, Jul 11, 2023 at 03:09:06PM +0000, Alan Huang wrote:
> >>>> The objects are allocated with SLAB_TYPESAFE_BY_RCU, and there is
> >>>> n->next = first within hlist_add_head_rcu() before rcu_assign_pointer(),
> >>>> which modifies obj->obj_node.next. There may be readers holding the
> >>>> reference of obj in lockless_lookup, and when updater modifies ->next,
> >>>> readers can see the change immediately because ofSLAB_TYPESAFE_BY_RCU.
> >>>> 
> >>>> There are two memory ordering required in the insertion algorithm,
> >>>> we need to make sure obj->key is updated before obj->obj_node.next
> >>>> and obj->refcnt, atomic_set_release is not enough to provide the
> >>>> required memory barrier.
> >>>> 
> >>>> Signed-off-by: Alan Huang <mmpgouride@gmail.com>
> >>> 
> >>> This is an interesting one!!!
> >>> 
> >>> Now I am having a hard time believing that the smp_rmb() suffices.
> >>> 
> >>>> ---
> >>>> Changelog:
> >>>> v1 -> v2: Use _ONCE to protect obj->key.
> >>>> 
> >>>> Documentation/RCU/rculist_nulls.rst | 21 +++++++++++++--------
> >>>> 1 file changed, 13 insertions(+), 8 deletions(-)
> >>>> 
> >>>> diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
> >>>> index 21e40fcc08de..2a9f5a63d334 100644
> >>>> --- a/Documentation/RCU/rculist_nulls.rst
> >>>> +++ b/Documentation/RCU/rculist_nulls.rst
> >>>> @@ -47,7 +47,7 @@ objects, which is having below type.
> >>>>    * reuse these object before the RCU grace period, we
> >>>>    * must check key after getting the reference on object
> >>>>    */
> >>>> -    if (obj->key != key) { // not the object we expected
> >>>> +    if (READ_ONCE(obj->key) != key) { // not the object we expected
> >>>>      put_ref(obj);
> >>>>      rcu_read_unlock();
> >>>>      goto begin;
> >>>> @@ -64,10 +64,10 @@ but a version with an additional memory barrier (smp_rmb())
> >>>>  {
> >>>>    struct hlist_node *node, *next;
> >>>>    for (pos = rcu_dereference((head)->first);
> >>>> -         pos && ({ next = pos->next; smp_rmb(); prefetch(next); 1; }) &&
> >>>> +         pos && ({ next = READ_ONCE(pos->next); smp_rmb(); prefetch(next); 1; }) &&
> >>> 
> >>> Suppose that lockless_lookup() is delayed just before fetching pos->next,
> >>> and that there were 17 more node to search in the list.
> >>> 
> >>> Then consider the following sequence of events:
> >>> 
> >>> o The updater deletes this same node and kmem_cache_free()s it.
> >>> 
> >>> o Another updater kmem_cache_alloc()s that same memory and
> >>> inserts it into an empty hash chain with a different key.
> >>> 
> >>> o Then lockless_lookup() fetches pos->next and sees a NULL pointer,
> >>> thus failing to search the remaining 17 nodes in the list,
> >>> one of which had the desired key value.
> >>> 
> >>> o The lookup algorithm resumes and sees the NULL return from
> >>> lockless_lookup(), and ends up with a NULL obj.
> >>> 
> >>> And this happens even with the strongest possible ordering
> >>> everywhere.
> >>> 
> >>> OK, yes, it is late on Friday.  So what am I missing here?
> >> 
> >> You missed nothing!
> >> 
> >> The lockless_lockup should not be a function, but a macro like hlist_for_each_entry_rcu.
> > 
> > How would you fix this using a macro?
> 
> With additional detection code. A moved object (in another chain) will have a different slot.
> (I have sent patch v3. )
> 
> > 
> >>> Independent of that, does hlist_add_head_rcu() need to replace its
> >>> "n->next = first" with "WRITE_ONCE(n->next, first)"?
> >> 
> >> I think users who want to use hlist with SLAB_TYPESAFE_BY_RCU should use rculist_nulls?
> > 
> > I believe that you are correct.  Would you like to propose a patch, or
> > would you rather I put something together?  My current thought is to
> 
> Feel free to add. 
> 
> One thing I think would be useful is to tell readers where the ‘next' is. 
> The document mentions ’next’ many times, but it’s hard for me, as a reader, to realize that
> the ‘next' is within hlist_add_head_rcu(). (I have no idea where to put the hint.)
> 
> 
> > keep the examples, but to show why the one with smp_rmb() is broken.
> 
> I think the example needs to be fixed. :)

Even better!  I will take a look, but in the meantime, would you be
interested in updating the wording to explain how the back-pointer works?

(Looks similar to the is_a_nulls() pointer, but in each element instead of
just at the end.  One advantage is the ability to detect a move mid-list,
though that is not a big deal in well-tuned hash tables, which tend to
have short hash chains.  The need to move elements to the front of the
destination list remains, though in both cases only if it has been less
than a grace period since the last move.)

							Thanx, Paul

> >> I didn’t find a case using hlist with SLAB_TYPESAFE_BY_RCU, but I did find a case using list
> >> with SLAB_TYPESAFE_BY_RCU in drivers/gpu/drm/i915, the driver also doesn’t use _ONCE
> >> on the fields of the objects allocated with SLAB_TYPESAFE_BY_RCU.
> > 
> > Feel free to send them a patch, though I cannot speak for their
> > reception of it.
> > 
> > Thanx, Paul
> > 
> >>> Thanx, Paul
> >>> 
> >>>>         ({ obj = hlist_entry(pos, typeof(*obj), obj_node); 1; });
> >>>>         pos = rcu_dereference(next))
> >>>> -      if (obj->key == key)
> >>>> +      if (READ_ONCE(obj->key) == key)
> >>>>        return obj;
> >>>>    return NULL;
> >>>>  }
> >>>> @@ -111,8 +111,13 @@ detect the fact that it missed following items in original chain.
> >>>>   */
> >>>>  obj = kmem_cache_alloc(...);
> >>>>  lock_chain(); // typically a spin_lock()
> >>>> -  obj->key = key;
> >>>> -  atomic_set_release(&obj->refcnt, 1); // key before refcnt
> >>>> +  WRITE_ONCE(obj->key, key);
> >>>> +  /*
> >>>> +   * We need to make sure obj->key is updated before obj->obj_node.next
> >>>> +   * and obj->refcnt.
> >>>> +   */
> >>>> +  smp_wmb();
> >>>> +  atomic_set(&obj->refcnt, 1);
> >>>>  hlist_add_head_rcu(&obj->obj_node, list);
> >>>>  unlock_chain(); // typically a spin_unlock()
> >>>> 
> >>>> @@ -165,12 +170,12 @@ Note that using hlist_nulls means the type of 'obj_node' field of
> >>>>  begin:
> >>>>  rcu_read_lock();
> >>>>  hlist_nulls_for_each_entry_rcu(obj, node, head, obj_node) {
> >>>> -    if (obj->key == key) {
> >>>> +    if (READ_ONCE(obj->key) == key) {
> >>>>      if (!try_get_ref(obj)) { // might fail for free objects
> >>>> rcu_read_unlock();
> >>>>        goto begin;
> >>>>      }
> >>>> -      if (obj->key != key) { // not the object we expected
> >>>> +      if (READ_ONCE(obj->key) != key) { // not the object we expected
> >>>>        put_ref(obj);
> >>>> rcu_read_unlock();
> >>>>        goto begin;
> >>>> @@ -206,7 +211,7 @@ hlist_add_head_rcu().
> >>>>   */
> >>>>  obj = kmem_cache_alloc(cachep);
> >>>>  lock_chain(); // typically a spin_lock()
> >>>> -  obj->key = key;
> >>>> +  WRITE_ONCE(obj->key, key);
> >>>>  atomic_set_release(&obj->refcnt, 1); // key before refcnt
> >>>>  /*
> >>>>   * insert obj in RCU way (readers might be traversing chain)
> >>>> -- 
> >>>> 2.34.1
> 
> 
