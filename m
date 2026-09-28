Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE95B4DAF8A;
	Mon, 28 Sep 2026 14:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790607409; cv=none; b=bhXKA/I7BVykiTGNBXfYYxCJc2qOcKSoOjMZ3kBxDcyAzfSaBpGcby31agtvgN77zuVP3+V97AhlKZdC5LvwzmDLohTWiIXrAesToF9kHzfNmmG2fcr0GiZ2NZhiLlcbZSEKe24Xz1NAuztCz/R7A1elTQ7kNOsNmUs4CT7AwF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790607409; c=relaxed/simple;
	bh=fUeatMRMiIOHg5krjb9OIAPsw1RQHZXlxfjBh3wQQ04=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=NnacHAn8+go/nyiv4LSS/EKLQe7U7zntp/Y+6QcXEWN4jiTO88iz8+iR8uR0sqt7YR+8i44PNkwYzDmNGkZ4ECMlh8YTknEJSGz7nJZgHT33Iq1N633A91hGx1Pa/v8s8u3DLVzcExXI5yCT6Bwq6m5o8C1Lz/lyzr0GTzODrzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=deNQUxFb; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=RGOhEb3q; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="deNQUxFb";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="RGOhEb3q"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790607377; bh=EJjNlAPWHW78XMfRn5dDceQ
	7HSZ/FsFaRy7xG40Oko4=; b=deNQUxFbg53bjjB2ieNUbDRqZlvvtbBhxP9+DHRh75nOHi+lRl
	swqs7wG/PVlk5DkX5GXQ956TeVRogmSZz+m0iQizIxTH2i1RyR0V8ET1gJGN7QwasbdnNY6RDv1
	eq2fFdMa8hkDNsNQcDR0zzNubm5bMQffVeu/O2NbOv2jKYvxu7qwISbgDGTMfjENZeOFswUuFao
	9w7Qc+KWh0fiLXNByH5z+8OFe55PLXEFzvwSiFBvpOg0MQgc6jk9SQk65n4LEF9U7jHuEZVj5eP
	YGtKRsp6/PUxc3Yup9RArzU1uysBJn1QldIScnsiyP2UhX4IV0SEECaupUidRktgB3A==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790607377; bh=EJjNlAPWHW78XMfRn5dDceQ
	7HSZ/FsFaRy7xG40Oko4=; b=RGOhEb3qwHdMvPsmIWS6M6JPrwesGTYbhtVxKr0yZC3XQqtYNM
	yLoK7vrTRqw4dimY/gFxqDuuen+HoHlJnOBw==;
Date: Mon, 28 Sep 2026 15:56:18 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Gary Guo <gary@garyguo.net>, Boqun Feng <boqun@kernel.org>
CC: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E . McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
 rcu@vger.kernel.org, lkmm@lists.linux.dev
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_hazptr_4/4=5D_hazptr=3A_Introduce_=22try?=
 =?US-ASCII?Q?_acquire=22_fast_path=2C_fallback_to_overflow_list?=
In-Reply-To: <DLQX09XGAHDL.1LSFQH13SU7XR@garyguo.net>
References: <20260927155134.4740-1-mathieu.desnoyers@efficios.com> <20260927155134.4740-5-mathieu.desnoyers@efficios.com> <arlHFVT5EzcX4d1-@MacBook-0RXW5> <5c78c338-1be6-456b-b963-bcfc62748aab@efficios.com> <DLQGJZK4LIAO.3TAY3HZ6PR76Z@garyguo.net> <arovltfvFzv2FFjO@MacBook-0RXW5> <DLQX09XGAHDL.1LSFQH13SU7XR@garyguo.net>
Message-ID: <0F2DDE5F-DFA6-41FD-98A2-3B64DC2961CB@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 28 September 2026 12:32:34 BST, Gary Guo <gary@garyguo.net> wrote:
>On Mon Sep 28, 2026 at 10:12 AM BST, Boqun Feng wrote:
>> On Sun, Sep 27, 2026 at 11:39:00PM +0100, Gary Guo wrote:
>>> On Sun Sep 27, 2026 at 6:15 PM BST, Mathieu Desnoyers wrote:
>>> > On 2026-09-27 12:40, Boqun Feng wrote:
>>> >
>>> >> I want to point out this is not true for the lockdep use case,
>because
>>> >> the we need to protect a hash list deletion there, and we use the
>>> >> address of the hash bucket there. It's proven fine in practice
>because
>>> >> the readers are rare (we only call the reader is_dynamic_key() in
>>> >> register_lock_class(), that is every time you have a new lock class
>to
>>> >> register).
>>> >> 
>>> >> Maybe what we want to say here is that "if the users guarantee no
>steady
>>> >> flow of the same hazard pointer value, we guarantee forward
>progress".
>>> >> Thoughts?
>>> >
>>> > AFAIU, your approach to protect lockdep linked lists is to use the
>>> > address of the hash bucket to protect the traversal. As this address
>is 
>>> > invariant (global array item address), that address should be fine
>>> > to fulfill hazptr requirements, but it has downsides: rather than
>>> > protecting the specific nodes being retired, the whole hash chain is
>>> > protected. This means that, as you point out, many readers retiring
>>> > nodes from a given bucket (except the first node) could end up
>holding a
>>> > continuous stream of hazptr for a given hazptr value, preventing
>>> > progress of hazptr synchronize.
>>> >
>>> > It's also coarser: per-bucket rather than per-node.
>>> >
>>> > Am I missing something here ?
>>> >
>>> > One honest question: is this pattern something we expect to
>>> > see often ? If so, then we may want to introduce a notion of
>>> > hazptr protection "period" flip (similar to some RCU
>implementations),
>>> > where we tag the low bit of the slot pointer (0 vs 1), and alternate
>>> > between the two periods in synchronize. This would prevent a
>steady-flow
>>> > of same-value readers from preventing synchronize forward progress.
>>> 
>>> Slightly off topic, but I have a use-case in mind (in case you're not
>already
>>> aware) where the address is fixed like the lockdep class, but it does
>not suffer
>>> the forward progress guarantee.
>>> 
>>> I have been wanting to use hazptr for revocable for quite a while (I
>think I
>>> chatted with Boqun about this last LPC). For the revocable use case,
>the
>>> protected pointer is fixed, however there is an additional boolean flag
>to
>>> determine if the resource been revoked or not.
>>> 
>>> Something like this:
>>> 
>>>     void *revocable_try_access(struct revocable *rev) {
>>>         struct hazptr_ctx ctx = {};
>>>         if (READ_ONCE(rev->revoked))
>>>             return NULL;
>>>         // note the & cancels out with the * in acquire, so the address
>is fixed.
>>>         hazptr_acquire(&ctx, &rev);
>>>         if (READ_ONCE(rev->revoked))
>>>             return NULL;
>>>         return rev->res;
>>>     }
>>> 
>>>     void revocable_revoke(struct revocable *rev) {
>>>         WRITE_ONCE(rev->revoked, true);
>>>         hazptr_synchronize(&rev);
>>>     }
>>> 
>>> So while the address is fixed, we have a different field to do the
>unpublishing
>>> part.
>>> 
>>> For some context, the current Rust revocable implementation uses RCU,
>but this
>>> is limiting the case where it can be used. The current C revocable
>series in
>>> https://lore.kernel.org/all/20260912123529.7951-1-tzungbi@kernel.org/
>uses SRCU.
>>> 
>>> I think this use case is a good one for hazptr, in fact, I have
>encouraged Alvin
>>> Sun to try it out and you can see an implementation (Rust) in here:
>>>
>https://lore.kernel.org/rust-for-linux/20260326-b4-tyr-debugfs-v1-6-074badd18716@linux.dev/
>>> Although, over the course of the year, we have been reducing the amount
>of
>>> revocable usage and shifting to represent things with lifetime..
>>> 
>>
>> Paul asked me for the Rust usage a few days ago, and since we moved to
>> a lifetime based approach [1], which is better IMO, I don't think
>> switching to hazptr will should observable difference here, especially
>> for a real workload improvement. It's still worth trying to see how
>> hazptr in Rust would work for this, but it's less a sufficient condition
>> to merge hazptr from my understanding. Of course I could be wrong.
>>
>> [1]:
>https://lore.kernel.org/rust-for-linux/20260517000149.3226762-1-dakr@kernel.org/
>
>What we get rid of is to use `Revocable` (or `DevRes`) to protect
>resources
>where we _know_ that the resource is alive (for example, in device private
>data,
>because it's teared down by driver-core on unbind).
>
>However, there are cases where we can still have the `Revocable` pattern,
>for
>example when a class device is exposed to userspace and the bus device is
>unbinding. This is a pretty recurring pattern too, and cannot be handled
>via
>lifetime alone. This is what motivates the C revocable series.
>
>Best,
>Gary
>
Would you like me to try and draft a hazptr rust file? I mean, I'm not a
expert at it, but I'll throw my hat into the ring 
--- Thanks!
"I'm not a very positive person" - Linus torvalds
