Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7CD205E12;
	Tue, 12 Nov 2024 16:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731429591; cv=none; b=hcLo1nfihT4qPzQYG00WNYxoBy8uhoBWlj7Sq1/bUyS8RZViSXoIKnW/8V57LzgW5KBlfK9ddQowAH9UzN0CAZ3e15v9NXvHqNS+FEwtkIiF2nNlyAYeIJsrp8ROP7DRAVvjkE9xb8OtX6J+6l+zfN6LKWlFxNl9+1I/+U5L+1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731429591; c=relaxed/simple;
	bh=jrjNeQrg4Y6Q90C5KnN6MCGHYIumQnwgEsaBWJqxoPE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lkQNgOy6XcKrLGX1d2W6VO8pJeHhkD0MmnoXn5q/3402aUcXDG0lZZDn/D9fagtV0CuEeOq/hEEQGC9bHMq7AVNllZ+/Q70G6iQ//hZyTPW2SAPFGj1bAI0ZZNStykGsZxIdRytSVQWpCUugTiV9reXgaSIzm3VdRxcuAsamfN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2eroh3gD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OysSNrAe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2eroh3gD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OysSNrAe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2eroh3gD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OysSNrAe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2eroh3gD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OysSNrAe"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2A4192125B;
	Tue, 12 Nov 2024 16:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731429587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pX5XqWFuG3n9LwBO2U3xPxKlLvLasNncvRSUxm7ttVQ=;
	b=2eroh3gDGMIqWoJdfYQyg3IC04lHLJl9CaAzhp0zsuOJcvtxTi+wAwc21vNB4GIS0tqGnL
	2HHzQ7EsdyXpkHpeuFh4QUl53m0JeQrPsAjf1FbscPpVuOFpJHaxoIXGJfbbyhDtRcgZEZ
	gvqiKkS3EX5k71VO5MvniJsIDWv7a6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731429587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pX5XqWFuG3n9LwBO2U3xPxKlLvLasNncvRSUxm7ttVQ=;
	b=OysSNrAeRRHr8rpcc63UKcc6mOzGqOxq/JzXwkge0zXOPAtVxwWwnUnXBJ4bs6frPLtUBt
	Ttqz5tYWi6QzJ0Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731429587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pX5XqWFuG3n9LwBO2U3xPxKlLvLasNncvRSUxm7ttVQ=;
	b=2eroh3gDGMIqWoJdfYQyg3IC04lHLJl9CaAzhp0zsuOJcvtxTi+wAwc21vNB4GIS0tqGnL
	2HHzQ7EsdyXpkHpeuFh4QUl53m0JeQrPsAjf1FbscPpVuOFpJHaxoIXGJfbbyhDtRcgZEZ
	gvqiKkS3EX5k71VO5MvniJsIDWv7a6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731429587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pX5XqWFuG3n9LwBO2U3xPxKlLvLasNncvRSUxm7ttVQ=;
	b=OysSNrAeRRHr8rpcc63UKcc6mOzGqOxq/JzXwkge0zXOPAtVxwWwnUnXBJ4bs6frPLtUBt
	Ttqz5tYWi6QzJ0Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0897313301;
	Tue, 12 Nov 2024 16:39:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3bbFAdOEM2e6IwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 12 Nov 2024 16:39:47 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH RFC 0/6] SLUB percpu sheaves
Date: Tue, 12 Nov 2024 17:38:44 +0100
Message-Id: <20241112-slub-percpu-caches-v1-0-ddc0bdc27e05@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJSEM2cC/23OTW7CMBCG4asgrxnksYMds6pUqQfoFrGwnQmxW
 khkE4sf5e6YiNINy2+kefTeWKIYKLHN4sYi5ZBCfywDlwvmO3vcE4SmbCa4kIiihvQ7Ohgo+mE
 Eb31HCUxVYW0ER2w0K49DpDacZ3TLvr8+2a4c29gf4NRFsi+P18hRSSX0SgmuwEB21v3YjzQmW
 vnrw+pCOvXxMvdlOYvPFPMuJUvgoJxv11JpLZx/WY+GjH9AxTWKtwAWQJLCltumNkb9A9M03QG
 xVwEhLwEAAA==
X-Change-ID: 20231128-slub-percpu-caches-9441892011d7
To: Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, 
 Pekka Enberg <penberg@kernel.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Matthew Wilcox <willy@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 maple-tree@lists.infradead.org, Vlastimil Babka <vbabka@suse.cz>, 
 Mateusz Guzik <mjguzik@gmail.com>, Jann Horn <jannh@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5756; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=jrjNeQrg4Y6Q90C5KnN6MCGHYIumQnwgEsaBWJqxoPE=;
 b=kA0DAAgBu+CwddJFiJoByyZiAGczhL+gOGo314aXTenHsl4pdqBxeF0WE0nM/eroeKF9OI8SS
 4kBMwQAAQgAHRYhBHu7yEEVmSNIlkhN8bvgsHXSRYiaBQJnM4S/AAoJELvgsHXSRYiaYw4IAKIE
 DTkzGrd3X45JbIdX5pg1Hi7YnW57+8VADZajXUiKM2kZ9NhNQ6GCWgZEiISnux42UvlIpfcso3W
 qlHz9x1onVb/RdE+jQ3j/TkLGN+DFTqDy10MSZEv2OdOfCyogWSKplVAJ6guCpJOWbf/0v8nPfb
 aqem4MEvW60ZSU/msTVefuTFKSaIBIvRd6AzMh2D+TdH/6d3OFkKI1GyP1+OYyHbZctnAp6udZO
 w/uvtQLcCe+D6yPiHigp9+ZZ+oYpCuNL/otk6HVkPWkJdFWyP2a/ISKIAovVF5nQ/y3WQT5KWBb
 fHAZ+JZhBqSViwYH8/CB9LhLAYfgxjoP976BxME=
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,oracle.com,infradead.org,kvack.org,vger.kernel.org,lists.infradead.org,suse.cz,google.com];
	R_RATELIMIT(0.00)[to_ip_from(RLtz7ce9b89hw8xzamye9qeynd)];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Hi,

This is a RFC to add an opt-in percpu array-based caching layer to SLUB.
The name "sheaf" was invented by Matthew so we don't call it magazine
like the original Bonwick paper. The per-NUMA-node cache of sheaves is
thus called "barn".

This may seem similar to the arrays in SLAB, but the main differences
are:

- opt-in, not used for every cache
- does not distinguish NUMA locality, thus no "alien" arrays that would
  need periodical flushing
- improves kfree_rcu() handling
- API for obtaining a preallocated sheaf that can be used for guaranteed
  and efficient allocations in a restricted context, when upper bound is
  known but rarely reached

The motivation comes mainly from the ongoing work related to VMA
scalability and the related maple tree operations. This is why maple
tree node and vma caches are sheaf-enabled in the RFC. Performance benefits
were measured by Suren in preliminary non-public versions.

A sheaf-enabled cache has the following expected advantages:

- Cheaper fast paths. For allocations, instead of local double cmpxchg,
  with Patch 5 it's preempt_disable() and no atomic operations. Same for
  freeing, which is normally a local double cmpxchg only for a short
  term allocations (so the same slab is still active on the same cpu when
  freeing the object) and a more costly locked double cmpxchg otherwise.
  The downside is lack of NUMA locality guarantees for the allocated
  objects.

  I hope this scheme will also allow (non-guaranteed) slab allocations
  in context where it's impossible today and achieved by building caches
  on top of slab, i.e. the BPF allocator.

- kfree_rcu() batching. kfree_rcu() will put objects to a separate
  percpu sheaf and only submit the whole sheaf to call_rcu() when full.
  After the grace period, the sheaf can be used for allocations, which
  is more efficient than handling individual slab objects (even with the
  batching done by kfree_rcu() implementation itself). In case only some
  cpus are allowed to handle rcu callbacks, the sheaf can still be made
  available to other cpus on the same node via the shared barn.
  Both maple_node and vma caches can benefit from this.

- Preallocation support. A prefilled sheaf can be borrowed for a short
  term operation that is not allowed to block and may need to allocate
  some objects. If an upper bound (worst case) for the number of
  allocations is known, but only much fewer allocations actually needed
  on average, borrowing and returning a sheaf is much more efficient then
  a bulk allocation for the worst case followed by a bulk free of the
  many unused objects. Maple tree write operations should benefit from
  this.

Patch 1 implements the basic sheaf functionality and using
local_lock_irqsave() for percpu sheaf locking.

Patch 2 adds the kfree_rcu() support.

Patches 3 and 4 enable sheaves for maple tree nodes and vma's.

Patch 5 replaces the local_lock_irqsave() locking with a cheaper scheme
inspired by online conversations with Mateusz Guzik and Jann Horn. In
the past I have tried to copy the scheme from page allocator's pcplists
that also avoids disabling irqs by using a trylock for operations that
might be attempted from an irq handler conext. But spin locks used for
pcplists are more costly than a simple flag with only compiler barriers.
On the other hand it's not possible to take the lock from a different
cpu (except for hotplug handling when the actual local cpu cannot race
with us), but we don't need that remote locking for sheaves.

Patch 6 implements borrowing prefilled sheaf, with maple tree being the
ancticipated user once converted to use it by someone more knowledgeable
than myself.

(RFC) LIMITATIONS:

- with slub_debug enabled, objects in sheaves are considered allocated
  so allocation/free stacktraces may become imprecise and checking of
  e.g. redzone violations may be delayed

- kfree_rcu() via sheaf is only hooked to tree rcu, not tiny rcu. Also
  in case we fail to allocate a sheaf, and fallback to the existing
  implementation, it may use kfree_bulk() where destructors are not
  hooked. It's however possible we won't need the destructor support
  for now at all if vma_lock is moved to vma itself [1] and if it's
  possible to free anon_name and numa balancing tracking immediately
  and not after a grace period.

- in case a prefilled sheaf is requested with more objects than the
  cache's sheaf_capacity, it will fail. This should be possible to
  handle by allocating a bigger sheaf and then freeing it when returned,
  to avoid mixing up different sizes. Ineffective, but acceptable if
  very rare.

[1] https://lore.kernel.org/all/20241111205506.3404479-1-surenb@google.com/

Vlastimil

git branch: https://git.kernel.org/vbabka/l/slub-percpu-sheaves-v1r5

---
Vlastimil Babka (6):
      mm/slub: add opt-in caching layer of percpu sheaves
      mm/slub: add sheaf support for batching kfree_rcu() operations
      maple_tree: use percpu sheaves for maple_node_cache
      mm, vma: use sheaves for vm_area_struct cache
      mm, slub: cheaper locking for percpu sheaves
      mm, slub: sheaf prefilling for guaranteed allocations

 include/linux/slab.h |   60 +++
 kernel/fork.c        |   27 +-
 kernel/rcu/tree.c    |    8 +-
 lib/maple_tree.c     |   11 +-
 mm/slab.h            |   27 +
 mm/slab_common.c     |    8 +-
 mm/slub.c            | 1427 ++++++++++++++++++++++++++++++++++++++++++++++++--
 7 files changed, 1503 insertions(+), 65 deletions(-)
---
base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
change-id: 20231128-slub-percpu-caches-9441892011d7

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>

