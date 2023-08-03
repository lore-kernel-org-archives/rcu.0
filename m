Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8514C001DF
	for <rcu@archiver.kernel.org>; Thu,  3 Aug 2023 13:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbjHCNyx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 3 Aug 2023 09:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjHCNyv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 3 Aug 2023 09:54:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650BFE73;
        Thu,  3 Aug 2023 06:54:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E06B861D74;
        Thu,  3 Aug 2023 13:54:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4595FC433C9;
        Thu,  3 Aug 2023 13:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691070886;
        bh=Tqf3lFT3UVSfX3EDyAdupn7PP/qVBi+UR0wEQfkfI/4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tYSWnRd5uTtdojNITNZ+dBAwT6b3eHChV9rUADHUVAIUHVBfYZXphay/D+a9GWN2j
         XuZQ6+xerqBAvUECDrRrcGLzhUwyluYx5S7Z7yvOUo77aEwXizE7vcdeDknlLLIqEP
         E0yUV0NugAco4NtmJFG/4X4pArO7cxHtpzgb3IoEA5Vk60j8/A9bYYu1qDgJHwtjno
         o8OabP2thKF+4LXGlO0hC/Hk1RNiNlpXuGzdpys3GOFIaJkqrZD6ZsvkMdNqkaWmRW
         XQxX3cX99iKQ3EMaTljDo6zgWAtFBNWe2ZiP5jZqpDmIu6SVy6Y5xs73CPBHNjcmBG
         TL08j3s1Q05SA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E253DCE089E; Thu,  3 Aug 2023 06:54:45 -0700 (PDT)
Date:   Thu, 3 Aug 2023 06:54:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Huang <mmpgouride@gmail.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>, corbet@lwn.net,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] docs/RCU: Bring back smp_wmb()
Message-ID: <a6fe2a7d-863e-4dd9-a7f7-b8375a688415@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <02a84e4b-a322-4c43-ad9d-1832ce277c2f@paulmck-laptop>
 <636D1ED4-C90D-47CA-A46A-28E40E777966@gmail.com>
 <9b1967c5-6b8d-4d66-879c-42818d6e3170@paulmck-laptop>
 <30E3504D-4E64-4C61-9503-690C1657C6F3@gmail.com>
 <8d54c0a5-11ab-48e2-b187-25b229406b2a@paulmck-laptop>
 <99F1D0AB-5085-42CA-BFF0-6D5AC488F960@gmail.com>
 <2c7ebfde-40e7-442c-9483-4a3ca3b72f2d@paulmck-laptop>
 <BB359D4F-67B1-459F-A3E5-18BCD39D022B@gmail.com>
 <901e9495-74f3-4837-94ad-396f5b6899fc@paulmck-laptop>
 <62EB7DEA-EA2E-4F42-9766-BB3E0BA145EE@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62EB7DEA-EA2E-4F42-9766-BB3E0BA145EE@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Aug 03, 2023 at 09:50:35PM +0800, Alan Huang wrote:
> 
> > 2023年8月1日 上午4:06，Paul E. McKenney <paulmck@kernel.org> 写道：
> > 
> > On Sat, Jul 29, 2023 at 11:17:31PM +0800, Alan Huang wrote:
> >> 
> >>> 2023年7月25日 00:09，Paul E. McKenney <paulmck@kernel.org> 写道：
> >>> 
> >>> On Sat, Jul 22, 2023 at 09:02:46AM +0800, Alan Huang wrote:
> >>>> 
> >>>>> 2023年7月22日 上午6:49，Paul E. McKenney <paulmck@kernel.org> 写道：
> >>>>> 
> >>>>> On Wed, Jul 19, 2023 at 12:08:33AM +0800, Alan Huang wrote:
> >>>>>> 
> >>>>>>> 2023年7月18日 03:06，Paul E. McKenney <paulmck@kernel.org> 写道：
> >>>>>>> 
> >>>>>>> On Tue, Jul 18, 2023 at 01:53:10AM +0800, Alan Huang wrote:
> >>>>>>>>> 2023年7月18日 00:02，Paul E. McKenney <paulmck@kernel.org> 写道：
> >>>>>>>>> On Sun, Jul 16, 2023 at 07:21:28PM +0800, Alan Huang wrote:
> >>>>>>>>>>> 2023年7月16日 01:19，Paul E. McKenney <paulmck@kernel.org> 写道：
> >>>>>>>>>>> On Sat, Jul 15, 2023 at 08:50:23AM +0800, Alan Huang wrote:
> >>>>>>>>>>>>> 2023年7月15日 07:23，Paul E. McKenney <paulmck@kernel.org> 写道：
> >>>>>>>>>>>>> On Tue, Jul 11, 2023 at 03:09:06PM +0000, Alan Huang wrote:
> >>>>>>>>>>>>>> The objects are allocated with SLAB_TYPESAFE_BY_RCU, and there is
> >>>>>>>>>>>>>> n->next = first within hlist_add_head_rcu() before rcu_assign_pointer(),
> >>>>>>>>>>>>>> which modifies obj->obj_node.next. There may be readers holding the
> >>>>>>>>>>>>>> reference of obj in lockless_lookup, and when updater modifies ->next,
> >>>>>>>>>>>>>> readers can see the change immediately because ofSLAB_TYPESAFE_BY_RCU.
> >>>>>>>>>>>>>> 
> >>>>>>>>>>>>>> There are two memory ordering required in the insertion algorithm,
> >>>>>>>>>>>>>> we need to make sure obj->key is updated before obj->obj_node.next
> >>>>>>>>>>>>>> and obj->refcnt, atomic_set_release is not enough to provide the
> >>>>>>>>>>>>>> required memory barrier.
> >>>>>>>>>>>>>> 
> >>>>>>>>>>>>>> Signed-off-by: Alan Huang <mmpgouride@gmail.com>
> >>>>>>>>>>>>> 
> >>>>>>>>>>>>> This is an interesting one!!!
> >>>>>>>>>>>>> 
> >>>>>>>>>>>>> Now I am having a hard time believing that the smp_rmb() suffices.
> >>>>>>>>>>>>> 
> >>>>>>>>>>>>>> ---
> >>>>>>>>>>>>>> Changelog:
> >>>>>>>>>>>>>> v1 -> v2: Use _ONCE to protect obj->key.
> >>>>>>>>>>>>>> 
> >>>>>>>>>>>>>> Documentation/RCU/rculist_nulls.rst | 21 +++++++++++++--------
> >>>>>>>>>>>>>> 1 file changed, 13 insertions(+), 8 deletions(-)
> >>>>>>>>>>>>>> 
> >>>>>>>>>>>>>> diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
> >>>>>>>>>>>>>> index 21e40fcc08de..2a9f5a63d334 100644
> >>>>>>>>>>>>>> --- a/Documentation/RCU/rculist_nulls.rst
> >>>>>>>>>>>>>> +++ b/Documentation/RCU/rculist_nulls.rst
> >>>>>>>>>>>>>> @@ -47,7 +47,7 @@ objects, which is having below type.
> >>>>>>>>>>>>>> * reuse these object before the RCU grace period, we
> >>>>>>>>>>>>>> * must check key after getting the reference on object
> >>>>>>>>>>>>>> */
> >>>>>>>>>>>>>> -    if (obj->key != key) { // not the object we expected
> >>>>>>>>>>>>>> +    if (READ_ONCE(obj->key) != key) { // not the object we expected
> >>>>>>>>>>>>>> put_ref(obj);
> >>>>>>>>>>>>>> rcu_read_unlock();
> >>>>>>>>>>>>>> goto begin;
> >>>>>>>>>>>>>> @@ -64,10 +64,10 @@ but a version with an additional memory barrier (smp_rmb())
> >>>>>>>>>>>>>> {
> >>>>>>>>>>>>>> struct hlist_node *node, *next;
> >>>>>>>>>>>>>> for (pos = rcu_dereference((head)->first);
> >>>>>>>>>>>>>> -         pos && ({ next = pos->next; smp_rmb(); prefetch(next); 1; }) &&
> >>>>>>>>>>>>>> +         pos && ({ next = READ_ONCE(pos->next); smp_rmb(); prefetch(next); 1; }) &&
> >>>>>>>>>>>>> 
> >>>>>>>>>>>>> Suppose that lockless_lookup() is delayed just before fetching pos->next,
> >>>>>>>>>>>>> and that there were 17 more node to search in the list.
> >>>>>>>>>>>>> 
> >>>>>>>>>>>>> Then consider the following sequence of events:
> >>>>>>>>>>>>> 
> >>>>>>>>>>>>> o The updater deletes this same node and kmem_cache_free()s it.
> >>>>>>>>>>>>> 
> >>>>>>>>>>>>> o Another updater kmem_cache_alloc()s that same memory and
> >>>>>>>>>>>>> inserts it into an empty hash chain with a different key.
> >>>>>>>>>>>>> 
> >>>>>>>>>>>>> o Then lockless_lookup() fetches pos->next and sees a NULL pointer,
> >>>>>>>>>>>>> thus failing to search the remaining 17 nodes in the list,
> >>>>>>>>>>>>> one of which had the desired key value.
> >>>>>>>>>>>>> 
> >>>>>>>>>>>>> o The lookup algorithm resumes and sees the NULL return from
> >>>>>>>>>>>>> lockless_lookup(), and ends up with a NULL obj.
> >>>>>>>>>>>>> 
> >>>>>>>>>>>>> And this happens even with the strongest possible ordering
> >>>>>>>>>>>>> everywhere.
> >>>>>>>>>>>>> 
> >>>>>>>>>>>>> OK, yes, it is late on Friday.  So what am I missing here?
> >>>>>>>>>>>> 
> >>>>>>>>>>>> You missed nothing!
> >>>>>>>>>>>> 
> >>>>>>>>>>>> The lockless_lockup should not be a function, but a macro like hlist_for_each_entry_rcu.
> >>>>>>>>>>> 
> >>>>>>>>>>> How would you fix this using a macro?
> >>>>>>>>>> 
> >>>>>>>>>> With additional detection code. A moved object (in another chain) will have a different slot.
> >>>>>>>>>> (I have sent patch v3. )
> >>>>>>>>>> 
> >>>>>>>>>>> 
> >>>>>>>>>>>>> Independent of that, does hlist_add_head_rcu() need to replace its
> >>>>>>>>>>>>> "n->next = first" with "WRITE_ONCE(n->next, first)"?
> >>>>>>>>>>>> 
> >>>>>>>>>>>> I think users who want to use hlist with SLAB_TYPESAFE_BY_RCU should use rculist_nulls?
> >>>>>>>>>>> 
> >>>>>>>>>>> I believe that you are correct.  Would you like to propose a patch, or
> >>>>>>>>>>> would you rather I put something together?  My current thought is to
> >>>>>>>>>> 
> >>>>>>>>>> Feel free to add. 
> >>>>>>>>>> 
> >>>>>>>>>> One thing I think would be useful is to tell readers where the ‘next' is. 
> >>>>>>>>>> The document mentions ’next’ many times, but it’s hard for me, as a reader, to realize that
> >>>>>>>>>> the ‘next' is within hlist_add_head_rcu(). (I have no idea where to put the hint.)
> >>>>>>>>>> 
> >>>>>>>>>> 
> >>>>>>>>>>> keep the examples, but to show why the one with smp_rmb() is broken.
> >>>>>>>>>> 
> >>>>>>>>>> I think the example needs to be fixed. :)
> >>>>>>>>> 
> >>>>>>>>> Even better!  I will take a look, but in the meantime, would you be
> >>>>>>>>> interested in updating the wording to explain how the back-pointer works?
> >>>>>>>> 
> >>>>>>>> Which document needs to be updated? 
> >>>>>>>> And is there anything that I can refer to? It’s the first time I have ever heard about it.
> >>>>>>> 
> >>>>>>> Documentation/RCU/rculist_nulls.rst, the one that you are updating.
> >>>>>>> 
> >>>>>>> There admittedly isn't a whole lot of commentary.
> >>>>>>> 
> >>>>>>>>> (Looks similar to the is_a_nulls() pointer, but in each element instead of
> >>>>>>>>> just at the end.  One advantage is the ability to detect a move mid-list,
> >>>>>>>>> though that is not a big deal in well-tuned hash tables, which tend to
> >>>>>>>>> have short hash chains.  The need to move elements to the front of the
> >>>>>>>>> destination list remains, though in both cases only if it has been less
> >>>>>>>>> than a grace period since the last move.)
> >>>>>>>> 
> >>>>>>>> Looks like that I need to learn it first. :)
> >>>>>>> 
> >>>>>>> Well, you wrote the code, so...  ;-)
> >>>>>> 
> >>>>>> If I understand correctly, it works only for 64-bit machines?
> >>>>>> 
> >>>>>> And the number of slots of the hash table will be limited?
> >>>>> 
> >>>>> You are asking about the is_a_nulls() value?  If so, it works on both
> >>>>> 32-bit and 64-bit machines.  They each have enough bits for the nulls
> >>>>> value to cover all possible two-byte objects in the full address space.
> >>>>> 
> >>>>> If that wasn't what you were asking, please help me with your question.
> >>>> 
> >>>> I’m asking the ‘back-pointer’, which
> >>>> 
> >>>> "Looks similar to the is_a_nulls() pointer, but in each element instead of
> >>>> just at the end”
> >>>> 
> >>>> If I understand correctly, we need to store the nulls in the upper unused bits.
> >>>> 
> >>>> And we only have several bits unused. One advantage I can think of is that it 
> >>>> will improve the performance once we have something like the Intel Upper Address Ignore (UAI),
> >>>> which also works only for 64-bit machine.
> >>> 
> >>> Ah, I was using the word "similar" very loosely.  Not "implemented in
> >>> a manner similar to is_a_nulls(), but rather "serves roughly the same
> >>> function as is_a_nulls()".
> >> 
> >> I got it.
> >> 
> >>> 
> >>> You should be able to just have the pointer to the bucket in each
> >>> element, and just compare for each element.  No need for extra bits,
> >> 
> >> It might have the same functionality if we put the nulls value in each element.
> > 
> > There are some strange things that are easier to do with a nulls value
> > than with an explicit pointer, but yes.
> > 
> > (For example, if for some odd reason you wanted to group the hash buckets
> > into classes within which moving a reader to another bucket was OK.
> > Why would you want to do this?  I have no idea!)
> 
> Interesting example.
> 
> I’ll try to update the wording to explain how the back-pointer works.
> 
> By the way, would you like a separate patch or a patch V4 containing the content of
> V3 of "docs/RCU: Bring back smp_wmb()” and the back-pointer?

A V4 containing the V3, please.

							Thanx, Paul

> >>> though UAI, like its pre-existing ARM counterpart, might also help catch
> >>> use-after-free bugs when resizing the hash table.
> >>> 
> >>> Thanx, Paul
> >>> 
> >>>>>>>>>>>> I didn’t find a case using hlist with SLAB_TYPESAFE_BY_RCU, but I did find a case using list
> >>>>>>>>>>>> with SLAB_TYPESAFE_BY_RCU in drivers/gpu/drm/i915, the driver also doesn’t use _ONCE
> >>>>>>>>>>>> on the fields of the objects allocated with SLAB_TYPESAFE_BY_RCU.
> >>>>>>>>>>> 
> >>>>>>>>>>> Feel free to send them a patch, though I cannot speak for their
> >>>>>>>>>>> reception of it.
> >>>>>>>>>>> 
> >>>>>>>>>>> Thanx, Paul
> >>>>>>>>>>> 
> >>>>>>>>>>>>> Thanx, Paul
> >>>>>>>>>>>>> 
> >>>>>>>>>>>>>>    ({ obj = hlist_entry(pos, typeof(*obj), obj_node); 1; });
> >>>>>>>>>>>>>>    pos = rcu_dereference(next))
> >>>>>>>>>>>>>> -      if (obj->key == key)
> >>>>>>>>>>>>>> +      if (READ_ONCE(obj->key) == key)
> >>>>>>>>>>>>>>   return obj;
> >>>>>>>>>>>>>> return NULL;
> >>>>>>>>>>>>>> }
> >>>>>>>>>>>>>> @@ -111,8 +111,13 @@ detect the fact that it missed following items in original chain.
> >>>>>>>>>>>>>> */
> >>>>>>>>>>>>>> obj = kmem_cache_alloc(...);
> >>>>>>>>>>>>>> lock_chain(); // typically a spin_lock()
> >>>>>>>>>>>>>> -  obj->key = key;
> >>>>>>>>>>>>>> -  atomic_set_release(&obj->refcnt, 1); // key before refcnt
> >>>>>>>>>>>>>> +  WRITE_ONCE(obj->key, key);
> >>>>>>>>>>>>>> +  /*
> >>>>>>>>>>>>>> +   * We need to make sure obj->key is updated before obj->obj_node.next
> >>>>>>>>>>>>>> +   * and obj->refcnt.
> >>>>>>>>>>>>>> +   */
> >>>>>>>>>>>>>> +  smp_wmb();
> >>>>>>>>>>>>>> +  atomic_set(&obj->refcnt, 1);
> >>>>>>>>>>>>>> hlist_add_head_rcu(&obj->obj_node, list);
> >>>>>>>>>>>>>> unlock_chain(); // typically a spin_unlock()
> >>>>>>>>>>>>>> 
> >>>>>>>>>>>>>> @@ -165,12 +170,12 @@ Note that using hlist_nulls means the type of 'obj_node' field of
> >>>>>>>>>>>>>> begin:
> >>>>>>>>>>>>>> rcu_read_lock();
> >>>>>>>>>>>>>> hlist_nulls_for_each_entry_rcu(obj, node, head, obj_node) {
> >>>>>>>>>>>>>> -    if (obj->key == key) {
> >>>>>>>>>>>>>> +    if (READ_ONCE(obj->key) == key) {
> >>>>>>>>>>>>>> if (!try_get_ref(obj)) { // might fail for free objects
> >>>>>>>>>>>>>> rcu_read_unlock();
> >>>>>>>>>>>>>>   goto begin;
> >>>>>>>>>>>>>> }
> >>>>>>>>>>>>>> -      if (obj->key != key) { // not the object we expected
> >>>>>>>>>>>>>> +      if (READ_ONCE(obj->key) != key) { // not the object we expected
> >>>>>>>>>>>>>>   put_ref(obj);
> >>>>>>>>>>>>>> rcu_read_unlock();
> >>>>>>>>>>>>>>   goto begin;
> >>>>>>>>>>>>>> @@ -206,7 +211,7 @@ hlist_add_head_rcu().
> >>>>>>>>>>>>>> */
> >>>>>>>>>>>>>> obj = kmem_cache_alloc(cachep);
> >>>>>>>>>>>>>> lock_chain(); // typically a spin_lock()
> >>>>>>>>>>>>>> -  obj->key = key;
> >>>>>>>>>>>>>> +  WRITE_ONCE(obj->key, key);
> >>>>>>>>>>>>>> atomic_set_release(&obj->refcnt, 1); // key before refcnt
> >>>>>>>>>>>>>> /*
> >>>>>>>>>>>>>> * insert obj in RCU way (readers might be traversing chain)
> >>>>>>>>>>>>>> -- 
> >>>>>>>>>>>>>> 2.34.1
> 
