Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C8513AA27;
	Mon, 15 Jul 2024 20:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721075382; cv=none; b=WCRtsX3yHCZwXHLQRLCLM6CGvGe4jH3pNgfHgRhW2S9F+BfSEMV2TW9WqQaoHG06w/oMjvMhOShJyEeR2jg152XgvGl9bouPXbDPnQ1yajp9dQJCAtUF/NOuIt+aGiQHm6HFUbwUcPU5BwIM0AevgWZ0nVI2DnTbdkRCYYUztCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721075382; c=relaxed/simple;
	bh=VIzIr2ftz3VGl/9a+kvqfaCx0OdkI62PFlP2Re06nSQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gWuE4sHgDnZs7tbvUdYJRm51LqwOWs/kOvdXWJ/d5GBZQaeubtTtxqxdIHQbF8aw8SIlhzJkK93MEAeXUAxtGOFpduuMfJoU9GnLhLlcGBsuPOior8TP145Vv8DVBvOwiJDtdLEkLJu0WR6Wzz0r9YRL9qIy0fxbpo5ZqWYfsJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y942AQiL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BNzA+PdL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y942AQiL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BNzA+PdL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y942AQiL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BNzA+PdL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y942AQiL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BNzA+PdL"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A8D4D1F833;
	Mon, 15 Jul 2024 20:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721075378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nFhQJkP0hVFtv7RiR1BnRvXpYdV4uR56kXUx1iBwLxw=;
	b=y942AQiLOBUNQndlSNAur7bBcg+/vbEy+4H+qO+0upE5Hx9nPwnT7ceufmKKqikDHL8v19
	bZw23E+Cc8cJUxs6BElFQKfe2CzrlRsJNgdVGQJNRyAYmp4KVfqACxSM68hrUYy8FkJy2a
	+B3poHOCLzXk00jSlDnIxz9QxBWhy/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721075378;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nFhQJkP0hVFtv7RiR1BnRvXpYdV4uR56kXUx1iBwLxw=;
	b=BNzA+PdLwNNR7LhbjRyxnB2nzkgpFlP9hqsnfvC7wZkrlhEbHQjxyF+exu92uqcNLBvgyM
	GLjKKUDgfyS211Cg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=y942AQiL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BNzA+PdL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721075378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nFhQJkP0hVFtv7RiR1BnRvXpYdV4uR56kXUx1iBwLxw=;
	b=y942AQiLOBUNQndlSNAur7bBcg+/vbEy+4H+qO+0upE5Hx9nPwnT7ceufmKKqikDHL8v19
	bZw23E+Cc8cJUxs6BElFQKfe2CzrlRsJNgdVGQJNRyAYmp4KVfqACxSM68hrUYy8FkJy2a
	+B3poHOCLzXk00jSlDnIxz9QxBWhy/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721075378;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nFhQJkP0hVFtv7RiR1BnRvXpYdV4uR56kXUx1iBwLxw=;
	b=BNzA+PdLwNNR7LhbjRyxnB2nzkgpFlP9hqsnfvC7wZkrlhEbHQjxyF+exu92uqcNLBvgyM
	GLjKKUDgfyS211Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 78D6A137EB;
	Mon, 15 Jul 2024 20:29:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AkvnHLKGlWbvUwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 15 Jul 2024 20:29:38 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH RFC 0/6] mm, slub: handle pending kfree_rcu() in
 kmem_cache_destroy()
Date: Mon, 15 Jul 2024 22:29:26 +0200
Message-Id: <20240715-b4-slab-kfree_rcu-destroy-v1-0-46b2984c2205@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKaGlWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDc0NT3SQT3eKcxCTd7LSi1NT4ouRS3ZTU4pKi/EpdC9OUFKMko5TUFEs
 jJaD+gqLUtMwKsNnRSkFuzkqxtbUAu5BS8XAAAAA=
To: "Paul E. McKenney" <paulmck@kernel.org>, 
 Joel Fernandes <joel@joelfernandes.org>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
 Julia Lawall <Julia.Lawall@inria.fr>, Jakub Kicinski <kuba@kernel.org>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.0
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[kernel.org,joelfernandes.org,joshtriplett.org,gmail.com,linux.com,google.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[goodmis.org,efficios.com,gmail.com,inria.fr,kernel.org,zx2c4.com,linux-foundation.org,linux.dev,kvack.org,vger.kernel.org,suse.cz];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Queue-Id: A8D4D1F833

First RFC, feel free to ignore for now if too busy with merge window.
Also in git:
https://git.kernel.org/vbabka/l/slab-kfree_rcu-destroy-v1r0

Based on slab/for-next:
https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?h=slab/for-next

Since SLOB was removed, we have allowed kfree_rcu() for objects
allocated from any kmem_cache in addition to kmalloc().

Recently we have attempted to replace existing call_rcu() usage with
kfree_rcu() where the callback is a plain kmem_cache_free(), in a series
by Julia Lawall [1].

Jakub Kicinski pointed out [2] this was tried already in batman-adv but
had to be reverted due to kmem_cache_destroy() failing due to objects
remaining in the cache, despite rcu_barrier() being used.

Jason Donenfeld found the culprit [3] being a35d16905efc ("rcu: Add
basic support for kfree_rcu() batching") causing rcu_barrier() to be
insufficient.

This was never a problem for kfree_rcu() usage on kmalloc() objects as
the kmalloc caches are never destroyed, but arbitrary caches can be,
e.g. due to module unload.

Out of the possible solutions collected by Paul McKenney [4] the most
appealing to me is "kmem_cache_destroy() lingers for kfree_rcu()" as
it adds no additional concerns to kfree_rcu() users. We already have
the precedence in some parts of the kmem_cache cleanup being done
asynchronously for SLAB_TYPESAFE_BY_RCU caches.

This series implements the necessary changes to the slab allocator,
mainly that if there are objects remaining in the cache when
kmem_cache_destroy() is called it is assumed that it's due to pending
kfree_rcu(), and a asynchronous work is scheduled that performs the
necessary barrier and then tries again. If objects remain after the
barrier, the usual warning is reported and the cache remains
undestroyed.

Notably the proper barrier doesn't yet exist so hopefully Paul or the
RCU team can help here :) it should be able to make it pessimistic as it
won't hold up anything but the work item.

Some downsides of this approach for debugging exist but should be small
enough:

- we can no longer report the stack trace leading to a premature
  kmem_cache_destroy(), but arguably that's not that interesting as the
  allocation traces and other details about the remaining objects, which
  are still reported, just a bit later.
- objects that are freed after kmem_cache_destroy() but before the work
  item proceeds with the destroy after the barrier, are technically
  bugs, but we won't be able to catch them unless we add some checks into
  the freeing hotpaths. It's not worth it, IMHO.

There is also a bunch of preliminary steps. The potentially visible one
is that sysfs and debugfs directories are now removed immediately during
kmem_cache_destroy() - previously this would be delayed for
SLAB_TYPESAFE_BY_RCU caches or left around forever if remaining objects
were detected. The extra delay by asynchronous destroy due to
kfree_rcu() could mean that a module unload/load cycle could create a
new instance of the cache which would fail to create these directories -
a concern raised by Paul. The immediate removal is the simplest solution
(compared to e.g. renaming the directories) and should not make debugging
harder - while it won't be possible to check debugfs for allocation
traces of leaked objects, they are listed with more detail in dmesg
anyway.

[1] https://lore.kernel.org/all/20240609082726.32742-1-Julia.Lawall@inria.fr/
[2] https://lore.kernel.org/all/20240612143305.451abf58@kernel.org/
[3] https://lore.kernel.org/all/Zmo9-YGraiCj5-MI@zx2c4.com/
[4] https://docs.google.com/document/d/1v0rcZLvvjVGejT3523W0rDy_sLFu2LWc_NR3fQItZaA/edit

To: Paul E. McKenney <paulmck@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
To: Josh Triplett <josh@joshtriplett.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
CC: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Zqiang <qiang.zhang1211@gmail.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
To: Christoph Lameter <cl@linux.com>
To: David Rientjes <rientjes@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: rcu@vger.kernel.org

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
Vlastimil Babka (6):
      mm, slab: make caches with refcount of 0 unmergeable
      mm, slab: always maintain per-node slab and object count
      mm, slab: unlink sysfs and debugfs immediately
      mm, slab: simplify kmem_cache_release()
      mm, slab: asynchronously destroy caches with outstanding objects
      kunit, slub: add test_kfree_rcu()

 lib/slub_kunit.c |  22 ++++++++++
 mm/slab.h        |   4 +-
 mm/slab_common.c | 121 +++++++++++++++++++++++++++++++++++--------------------
 mm/slub.c        |  58 ++++++++++++--------------
 4 files changed, 129 insertions(+), 76 deletions(-)
---
base-commit: 436381eaf2a423e60fc8340399f7d2458091b383
change-id: 20240715-b4-slab-kfree_rcu-destroy-85dd2b2ded92

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>

