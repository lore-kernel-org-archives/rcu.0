Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1486B563FDB;
	Tue,  8 Sep 2026 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882789; cv=none; b=KB8/ndq8H9r8U8H4OxbxEwnVlwMWicxRi7KlPS4WMhz6Vd+yP9abKdE61NSaZCvcle+LiYpNJy9pJoIQPYNso36leKCnYkCHtH9ggGol4BUginJsl9fS0v0BrGYgu59+afamF0l4V/MZw9oBEU/zGglm9mTlwo104M2MzDGiXNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882789; c=relaxed/simple;
	bh=FukBsNOUxII8H7puZtPe4XdMUNkWgygzzqqpbPg9BUU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=UgqniZm9bLcfW8Ewv3K2QEUUZrQCNIQdfDuToyCFxWzKYRfUX00yIk8d4ofMeXRpJt4G3PKi27T8Go3yVa+cRh4lwg5kGY4J7dhRU0BYFMDrhq/qpSsC88J8UsRmozyA920OteYJjreOaZRGG5fdeZdmTrjqsXRqjQ9oEKWtSYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=MwZW1Bna; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=hMdKHMBp; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="MwZW1Bna";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="hMdKHMBp"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788882766; bh=kJAyamF3aBcgQgrV0u6SKuK
	UtNm2AMZgI2DLrfMy4rw=; b=MwZW1BnaAY0RxHC3OKVqTSeWFusFVpwmqRtDd0e3DDEMGARX7d
	47BqhcqP15SZMqhYQn2E2PSEQM6IxPh+kwu0tN1zsQfv8dZinjRcy071DoZwHajEg7vuXGrqR8C
	LTe5JVaPXI23h4LyrctUsBmj4eTGU/KIvXSL0UmlHoYfglF2UrwNux5YZv8XGFeQkXY1uHVVyd/
	c5M8sS+6PBl904og4EKL5C3LTpL1pHZatekm0SuRnIcat4g2ca0P+TqxQ10Cv0Gv0VSEMVSPE+3
	ywP3Ge7jRph0cou+Rb5RXwd0d4jM2dlbe9Vr/8aw/r6AVrzXx5zBE6COzlAqSf/nKdg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788882766; bh=kJAyamF3aBcgQgrV0u6SKuK
	UtNm2AMZgI2DLrfMy4rw=; b=hMdKHMBpOHuH/tw8WAgPq7Bniozl2g/UT1tHhvttc48OTYjRCg
	vbc4K4xhkF4tHiu2yJOc24snPgUB9bG9VsCg==;
Date: Tue, 08 Sep 2026 16:52:45 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E . McKenney" <paulmck@kernel.org>
CC: linux-kernel@vger.kernel.org, kernel test robot <yi1.lai@intel.com>,
 Boqun Feng <boqun@kernel.org>, rcu@vger.kernel.org, lkmm@lists.linux.dev
Subject: Re: [PATCH] hazptr: handle NULL address in hazptr_detach
In-Reply-To: <7e574430-c77e-4ba9-aab0-cdaed40f788f@efficios.com>
References: <20260908152228.4154-1-mathieu.desnoyers@efficios.com> <E8BCA0DB-FB79-4348-BB0D-229E8B550D91@mainlining.org> <7e574430-c77e-4ba9-aab0-cdaed40f788f@efficios.com>
Message-ID: <0ED21EF9-F762-40D9-A54A-30F8B2DBCF31@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 8 September 2026 16:29:31 BST, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>On 2026-09-08 11:24, Bradley Morgan wrote:
>> On 8 September 2026 16:22:14 BST, Mathieu Desnoyers
>> <mathieu.desnoyers@efficios.com> wrote:
>>> When hazptr_acquire loads a NULL pointer, it sets:
>>> 
>>> - slot_item->slot.addr = NULL,
>>> - slot_item->ctx.ctx = ctx
>>> - ctx->slot = slot
>>> 
>>> And it returns NULL.
>>> 
>>> Then hazptr_detach is called on this ctx, it will act on the ctx as if
>>> needed to be promoted to backup slot, even though it has a NULL addr.
>>> 
>>> Looking at what hazptr_note_context_switch() does before promoting
>>> to backup slot, it checks for a NULL slot->addr, which is exactly
>>> what is missing from hazptr_detach.
>>> 
>>> With this in place there would be no need to explicitly check the
>>> hazptr_acquire() return value before calling hazptr_detach().
>>> 
>>> hazptr_release() has a early return check for NULL addr as well, so it
>>> makes sense that detach does an early return (no-op) similarly.
>>> 
>> 
>> You shall kill me for this!!
>> 
>> Could you perhaps do a splat in ze commit description pls?
>
>The splat is available at the "Closes" URL below. I'm not sure whether
>we should duplicate this verbose information ?
>
>Paul ?
>


This is a example of what I did.

From 8861f6d5c0678a7c5089c7b272509fc5931b8437 Mon Sep 17 00:00:00 2001
From: Bradley Morgan <brads@mainlining.org>
Date: Thu, 27 Aug 2026 17:43:38 +0000
Subject: ima: Check for ERR_PTR from dentry_path() in validate_hash_algo()

From: Bradley Morgan <brads@mainlining.org>

commit 8861f6d5c0678a7c5089c7b272509fc5931b8437 upstream.

dentry_path() returns ERR_PTR(-ENAMETOOLONG) when the path exceeds the
buffer. validate_hash_algo() passes the result straight to
integrity_audit_msg() without checking. ERR_PTR is not NULL, so
integrity_audit_message() sees a valid pointer and calls strlen() on
it, which faults:

    BUG: unable to handle page fault for address: ffffffffffffffdc
    RIP: 0010:strlen+0x30/0xa0
    Call Trace:
     audit_log_untrustedstring+0x19/0x30
     integrity_audit_message+0x366/0x4f0
     ima_inode_setxattr+0x512/0x5f0

Check for IS_ERR() and use NULL instead, which makes the audit message
skip the name= field instead of crashing.

Fixes: 4f2946aa0c45 ("IMA: introduce a new policy option func=SETXATTR_CHECK")
Cc: stable@vger.kernel.org
Reported-by: syzbot+5ebeb3089ea6439c37be@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/6a8f89e5.1d9ded08.62e62.00bf.GAE@google.com/
Signed-off-by: Bradley Morgan <brads@mainlining.org>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 security/integrity/ima/ima_appraise.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -754,6 +754,8 @@ static int validate_hash_algo(struct den
 		return -EACCES;
 
 	path = dentry_path(dentry, pathbuf, PATH_MAX);
+	if (IS_ERR(path))
+		path = NULL;
 
 	integrity_audit_msg(AUDIT_INTEGRITY_DATA, d_inode(dentry), path,
 			    "set_data", errmsg, -EACCES, 0);


>Thanks,
>
>Mathieu
>
>> 
>> 
>>> Fixes: 6357ec235c59 ("hazptrtorture: Fix hazptr ownership issue")
>>> Reported-by: kernel test robot <yi1.lai@intel.com>
>>> Closes:
>https://lore.kernel.org/oe-lkp/202608130915.62b53936-lkp@intel.com
>>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>> Reviewed-by: Bradley Morgan <brads@mainlining.org>
>>> Cc: Paul E. McKenney <paulmck@kernel.org>
>>> Cc: Boqun Feng <boqun@kernel.org>
>>> Cc: Bradley Morgan <brads@mainlining.org>
>>> Cc: <rcu@vger.kernel.org>
>>> Cc: <lkmm@lists.linux.dev>
>>> ---
>>> include/linux/hazptr.h | 4 +++-
>>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>> 
>>> diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
>>> index 43122c5673bd..d1670121947a 100644
>>> --- a/include/linux/hazptr.h
>>> +++ b/include/linux/hazptr.h
>>> @@ -160,10 +160,12 @@ void hazptr_detach(struct hazptr_ctx *ctx)
>>> 	struct hazptr_slot *slot;
>>> 
>>> 	guard(preempt)();
>>> +	slot = ctx->slot;
>>> +	if (!slot->addr)
>>> +		return;
>>> #ifdef CONFIG_HAZPTR_DEBUG
>>> 	ctx->detach_task = ctx->detach_cpu = true;
>>> #endif
>>> -	slot = ctx->slot;
>>> 	if (unlikely(hazptr_slot_is_backup(ctx, slot)))
>>> 		return;
>>> 	hazptr_promote_to_backup_slot(ctx, slot);
>>> 
>> 
>> --- Thanks!
>>
>https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
>
>
>

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
