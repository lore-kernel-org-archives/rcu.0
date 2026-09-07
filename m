Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7471A47FAF5;
	Mon,  7 Sep 2026 18:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788804716; cv=none; b=fst5RmK+VJl23kOq5JFDhON1HXw9Ao3D7dDYRWOZCPBd+OT7xrHMJ8nkwtX1d1e0IZf9yRnhiczabxQR/K4qVT2IRmh9sncqdzJUoll+XMYkIs3ReWf5Ahdpjs47Kauc0WhjWtzhzeFpv+cpaTf7zS5cWtSfD2UPe871tgQDQU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788804716; c=relaxed/simple;
	bh=jMkXqKNEEOAp1CNSKlUK5449g/mIOSN9spie3OfM//s=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=BzjnOZrIggYGYdNFp39CYrO57CJECveiw1Ay34IyoO/YoaPgGJzoSiK0cshKu2zGKNSHILX4IZMnVhlCwjyiDTIEEsb72YXw+35Q7MCXKAOgO8NpzrRT5MkromwHbmctx9XNG2aJgZ//Lije5dSEmMyM/EPgjZ5h+rNuB7lr8gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=ozLD/Q4t; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=/FjWDJtF; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="ozLD/Q4t";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="/FjWDJtF"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788804711; bh=a07r1jSrafx0bUyi2Qv1NdH
	6F/JFdjb7D36gJWvOs5E=; b=ozLD/Q4tS39tnTsA+gLikivMl/QRoEi9eU0O1Zo5T46wgAfV/t
	JVAZsfLZkDJZk6IZouqgfS70IUwAlMlYLeBXMWfZMwia7MAzVQ85okgMjCK3n72z+Zs8KTUpO9j
	AXUgR1KIcnN0/+guomco3nYO9w7Vc2S6oPCSXyV70zweAs0cx/QhPe/lgg+SyrYeyDeZoyBOsNy
	s1Tz2qJakmvJNsCuREuyQ3qeKYwqqSn5eciU690Z+BfVG8tNnyhx3Xj5pFWOjqYTDRSzNDu0ozw
	X26sZG67+v8TZ75VNq9GE9G8I193MFasg3ce6L436WiS4f+9FZu8zRcg8ZgIkA9L2Qw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788804711; bh=a07r1jSrafx0bUyi2Qv1NdH
	6F/JFdjb7D36gJWvOs5E=; b=/FjWDJtFNN22qF6RDxiEuCMj+V3OoNqHuR9lE3qABFSEfzOpGi
	dVfegQlusV3XJ4dxJzIwRt92KtpXFVj4oLBQ==;
Date: Mon, 07 Sep 2026 19:11:53 +0100
From: Bradley Morgan <brads@mainlining.org>
To: paulmck@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>
CC: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, boqun@kernel.org,
 frederic@kernel.org, include@grrlz.net, jiangshanlai@gmail.com,
 joelagnelf@nvidia.com, josh@joshtriplett.org, linux-kernel@vger.kernel.org,
 neeraj.upadhyay@kernel.org, qiang.zhang@linux.dev, rcu@vger.kernel.org,
 rostedt@goodmis.org, urezki@gmail.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_hazptrtorture=3A_Fix_inverte?=
 =?US-ASCII?Q?d_sleep_condition_in_do=5Fpending_kthread?=
In-Reply-To: <bbab8067-9bb4-46d0-bbbd-da7b836b04f5@paulmck-laptop>
References: <ed125668-a77a-41b6-9d56-46ac93a5d69c@paulmck-laptop> <9D2DEA27-B3D1-4A8B-BA57-2F5EAC920C1D@mainlining.org> <b1abee12-5a3a-4750-be37-a3157c7e2217@paulmck-laptop> <28838ba4-8618-45d0-9994-3efee251bce2@efficios.com> <748b12b2-f1a3-4ed8-8c9b-86fa8d9a5926@paulmck-laptop> <179E0ECA-C65D-4480-9E4E-CFA960D55665@mainlining.org> <bbab8067-9bb4-46d0-bbbd-da7b836b04f5@paulmck-laptop>
Message-ID: <D45E54F1-E015-46B1-9213-0801CF32A4F2@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 7 September 2026 00:16:55 BST, "Paul E. McKenney" <paulmck@kernel.org>
wrote:
>On Sun, Sep 06, 2026 at 07:56:29PM +0100, Bradley Morgan wrote:
>> On 6 September 2026 19:46:50 BST, "Paul E. McKenney"
><paulmck@kernel.org>
>> wrote:
>> >On Sun, Sep 06, 2026 at 09:09:53AM -0400, Mathieu Desnoyers wrote:
>> >> On 2026-09-05 16:40, Paul E. McKenney wrote:
>> >> > On Fri, Sep 04, 2026 at 06:28:45PM +0100, Bradley Morgan wrote:
>> >> [...]
>> >> > I would not say "no" to a fix for this issue:
>> >> > 
>> >> >
>>
>>https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
>> >> 
>> >> I'm not sure this URL actually points to a relevant issue ?
>> >
>> >Indeed, it does not, apologies!  Here you go:
>> >
>> >https://lore.kernel.org/all/202608130915.62b53936-lkp@intel.com/
>> >
>> >> > Once that is in place, I would be happy to put this back into
>-next.
>> >> > 
>> >> > At some point, we will need to get rid of the concept of wildcard
>> >hazard
>> >> > pointers, as those end up instead emulating RCU, but I don't see
>that
>> >> > as an immediate obstacle.
>> >> 
>> >> I already have the implementation which eliminates the wildcard if we
>> >> care about this. It was part of a previous hazptr series version.
>> >> 
>> >> Do you want me to resurrect it on top of the current series ?
>> >> This depends on:
>> >> 
>> >> - ptr_eq(),
>> >> - then use ptr_eq() to compare the loaded pointer (pre mb)
>> >>   with the re-loaded pointer (post-mb).
>> >> 
>> >> See:
>>
>>https://lore.kernel.org/all/20251218014531.3793471-1-mathieu.desnoyers@efficios.com/
>> >
>> >The main objection was over the content and style of the kernel-doc
>> >header comment, right?  I am guessing that it should be possible to
>> >resolve this to roughly equal disgust of all concerned.  ;-)
>> >
>> >We did make some progress on this sort of pointer issue in C++29
>> >this past June:
>> >
>> >https://people.kernel.org/paulmck/c-pointer-zap-and-oota-progress
>> >
>> >But the piece you need is this guy, which is still in process:
>> >
>> >https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2025/p3790r1.pdf
>> >
>> >Plus it will be some time before this reaches all the compilers used
>> >to build the Linux kernel, and probably even more time to reach the
>> >C language.  I do have pen-on-paper notes that will lead to a draft
>> >of the corresponding C-language working paper, but these things do not
>> >move quickly.
>> >
>> >So, yes, we will need something like ptr_eq() for some years to come.
>> >
>> >Back to your original question, given the fix for the above bug and
>> >given the current use case, I believe we can get the current series
>into
>> >mainline.  Give or take Linus's thoughts on the matter.  But either
>way,
>> >we will need a version that allows the user to avoid all wildcard use
>> >sooner rather than later.
>> >
>> >So having a series on top of the current one for a later merge window
>> >would be a very good thing!
>> >
>> Can I participate in this? :)
>
>If Mathieu is OK with it, feel free to look at the patch stack that
>Mathieu sent the URL for earlier in this thread.  Either way, please
>feel free to look at the stack in my -rcu tree based on v7.3-rc1 and
>headed by this commit:
>
>4398b7c192d ("hazptr: Implement two-phase wildcard scan")
>
>Perhaps you can find the bug that kernel test robot located.  ;-)
>
>My -rcu tree is here:
>
>git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
>
>Just so you know, in all cases, your taking on a task does not preclude
>others from also taking that same task on.
>
>							Thanx, Paul
>
>> --- Thanks!
>>
>https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
Hey, test this fix?

From 3e92b8153c31106d6a080e1c9bbe9bf1e86e1f63 Mon Sep 17 00:00:00 2001
From: Bradley Morgan <brads@mainlining.org>
Date: Mon, 7 Sep 2026 18:00:08 +0000
Subject: [PATCH] hazptrtorture: Only detach acquired hazard pointers

hazptr_torture_acquire() detaches unconditionally, even when the
readlock fails. A failed acquire leaves nothing to detach, but the
detach still promotes the context to its backup slot and chains that
slot into the running CPU's overflow list. The reader then retries on
its own CPU, the fast path hands out a per-CPU slot and overwrites
ctx->slot, and the chained backup node is orphaned, still linked,
with nobody left to unchain it.

The next detach of the same context chains the same node a second
time, into another CPU's list, and the node ends up reachable from
both. The eventual release unchains it once, hlist_del() poisons
node->next, and the first list is left pointing at the poisoned node.
The writer's next hazptr_synchronize() walks that list, steps onto
LIST_POISON1 (0x100 on i386, where POISON_POINTER_DELTA is 0), and
reads slot.addr at offset 8 of the backup slot, address 0x108, which
is the crash the robot hit.

  cpuA (IPI acquire)     cpuR (reader)          cpuD (do_pending)
  ---------------------  ---------------------  -------------------
  readlock() returns
    NULL
  detach chains the
    backup node into
    cpuA list
                         hpp_htp is NULL,
                           continue
                         reacquire, ctx->slot
                           is now a cpuR
                           per-CPU slot
                         acquire succeeds,
                           defer, detach chains
                           the SAME node into
                           cpuR list
                                                release, unchain
                                                  once, node->next
                                                  is POISON1
                                                kfree(hppp)
  synchronize walks cpuA
    list, node->next is
    0x100, reads 0x108,
    Oops

Skip the detach when the acquire failed. The slot holds NULL in that
case, note_context_switch() and the synchronize scanners skip NULL
slots, and the next acquire overwrites ctx->slot, so leaving the
context attached is safe.

The robot's original report was against the defer path before detach
existed, which 4bd7f458229a fixed. This is the same crash surviving
through the IPI acquire path that 6357ec235c59 added.

Fixes: 6357ec235c59 ("hazptrtorture: Fix hazptr ownership issue")
Reported-by: kernel test robot <yi1.lai@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202608130915.62b53936-lkp@intel.com
Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 kernel/rcu/hazptrtorture.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index 7c8b589..267f262 100644
--- a/kernel/rcu/hazptrtorture.c
+++ b/kernel/rcu/hazptrtorture.c
@@ -373,8 +373,11 @@ static void hazptr_torture_acquire(void *hppp_in)
 	/*
 	 * Acquiring a hazard pointer from a remote CPU.
 	 * Detach hazptr from its task so it can be released by another task.
+	 * A failed acquire has nothing to detach, and detaching one anyway
+	 * orphans the chained backup slot on this CPU's overflow list.
 	 */
-	hazptr_detach(&hppp->hpp_hc);
+	if (hppp->hpp_htp)
+		hazptr_detach(&hppp->hpp_hc);
 	atomic_long_inc(per_cpu_ptr(&hazptr_torture_acquires_irq, raw_smp_processor_id()));
 }
 
-- 
2.47.3


--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
