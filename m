Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9118A21505B
	for <rcu@vger.kernel.org>; Mon, 17 Mar 2025 14:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742222017; cv=none; b=Cu1A2Zul8gOaUfDPDN92tuzEJtQqNqsvdOnTu/bQEbZHuR34EboRrTg8XxxHY6FV6r80rtS2UC8qtwbnQjRwt7fnPwI/EJc/F8RQq3qO74a3mBqHp/F6N9eeF2PYsCicU1bMsGujOuwW58kflGgoTG9U2fkWF0YHm7xCat5loB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742222017; c=relaxed/simple;
	bh=cojkiGUZx3pqYU5Wc6gKC1QcalRM1Q2dL6QAknr/5fQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=J28xTrbKeRSvAy9zAp40ixL0AJKwlCIhryLIjKJrpaeoU3923C00aaP/YUb/EeFcXMQBNyZlrOY8yojhKZwASsK30qdoIfGLavaFVTjA0lRN4P2oNBpYQLII6kG/xdkxjzR6qPhJnrlfuy3/H3xN0Td1ANY7WShUQ8VCs9dhOh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mpILBlMf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=C65vA/SA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mpILBlMf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=C65vA/SA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mpILBlMf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="C65vA/SA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mpILBlMf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="C65vA/SA"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A2CD021A7F;
	Mon, 17 Mar 2025 14:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742222013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=POxYOC4nCskQkBmgoHQb2Fm/0NHB4W3IAhsdfcHg6ik=;
	b=mpILBlMf+l3YnmnWTYaOM6bJ/odxRu6RXeh0LRILT5/zLseMqJASSqcry5d32tgqAMelBJ
	/gWPVHYMGUUtPmeAshyJLQ+vcrCviSeO95ixjcohpKFk651PO4QChSC9NF/ynhROznj6du
	80fHv0SkulYEisOqbAVvYxZPBE+VmbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742222013;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=POxYOC4nCskQkBmgoHQb2Fm/0NHB4W3IAhsdfcHg6ik=;
	b=C65vA/SAQPyflkSErhepCAPOEfEeaQ2d9+Ymx0CYteJS9NbmbXo+yiXsuyopyUlBaPM1Ky
	sXuTlRs6AsA2KXAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742222013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=POxYOC4nCskQkBmgoHQb2Fm/0NHB4W3IAhsdfcHg6ik=;
	b=mpILBlMf+l3YnmnWTYaOM6bJ/odxRu6RXeh0LRILT5/zLseMqJASSqcry5d32tgqAMelBJ
	/gWPVHYMGUUtPmeAshyJLQ+vcrCviSeO95ixjcohpKFk651PO4QChSC9NF/ynhROznj6du
	80fHv0SkulYEisOqbAVvYxZPBE+VmbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742222013;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=POxYOC4nCskQkBmgoHQb2Fm/0NHB4W3IAhsdfcHg6ik=;
	b=C65vA/SAQPyflkSErhepCAPOEfEeaQ2d9+Ymx0CYteJS9NbmbXo+yiXsuyopyUlBaPM1Ky
	sXuTlRs6AsA2KXAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8839A139D2;
	Mon, 17 Mar 2025 14:33:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TVjqIL0y2GcycQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 17 Mar 2025 14:33:33 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH RFC v3 0/8] SLUB percpu sheaves
Date: Mon, 17 Mar 2025 15:33:01 +0100
Message-Id: <20250317-slub-percpu-caches-v3-0-9d9884d8b643@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ4y2GcC/22Qy26DMBBFfwV5XSOPAWOzqlSpH9BtFVW2GYqV8
 qgNqGmUf6+BNO0iyxlpzj1zzySgdxhIlZyJx8UFN/RxyB4SYlvdvyN1dZwJZzwD4JKGj9nQEb0
 dZ2q1bTFQlecgFWcAdUni4eixcV8b9JW8PD+RQ1w2fujo1HrUNx6TwEBkgpep4ExQRRejzVE/h
 jlgar9XVuvCNPjT5rfARoynOUSXeyoLUEbr2jJTW14iK26s1WHhv4CCccjvAngESFkojsiUEH8
 yh8v+msfPOdY0Xf8zOiC1Q9e5qUoWkUast7CqdxiC3gqskj2SZXvk5PoTPTYe8c3b+Sqd51yaR
 mmp4V/m5QeUltBpogEAAA==
X-Change-ID: 20231128-slub-percpu-caches-9441892011d7
To: Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 maple-tree@lists.infradead.org, vbabka@suse.cz, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Davidlohr Bueso <dave@stgolabs.net>, Alexei Starovoitov <ast@kernel.org>, 
 "Liam R. Howlett" <Liam.Howlett@Oracle.com>
X-Mailer: b4 0.14.2
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,oracle.com,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,suse.cz,linutronix.de,stgolabs.net,kernel.org,Oracle.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

Hi,

This is the v3 RFC to add an opt-in percpu array-based caching layer to
SLUB. This is to publish accumulated fixes since v2 ahead of LSF/MM. I
have also squashed the usage of localtry_lock to be used immediately
(not converted to in a separate patch) as the lock should be going to
6.15 at this point. There's still a patch introducing it for this RFC to
avoid depending on bpf-next tree.

The name "sheaf" was invented by Matthew so we don't call it magazine
like the original Bonwick paper. The per-NUMA-node cache of sheaves is
thus called "barn".

This may seem similar to the arrays in SLAB, but the main differences
are:

- opt-in, not used for every cache
- does not distinguish NUMA locality, thus no "shared" arrays and no
  "alien" arrays that would need periodical flushing
- improves kfree_rcu() handling
- API for obtaining a preallocated sheaf that can be used for guaranteed
  and efficient allocations in a restricted context, when the upper
  bound for needed objects is known but rarely reached

The motivation comes mainly from the ongoing work related to VMA
scalability and the related maple tree operations. This is why maple
tree nodes are sheaf-enabled in the RFC, but it's not a full conversion
that would take benefits of the improved preallocation API. The VMA part
is currently left out as it's expected that Suren will land the VMA
TYPESAFE_BY_RCU conversion [3] soon and there would be conflict with that.
With both series applied it means just adding a line to kmem_cache_args
in proc_caches_init().

Some performance benefits were measured by Suren and Liam in previous
versions. Suren's results in [5] look promising, so far except for the
preallocation support as used by the refactored maple tree code.

A sheaf-enabled cache has the following expected advantages:

- Cheaper fast paths. For allocations, instead of local double cmpxchg,
  after Patch 5 it's preempt_disable() and no atomic operations. Same for
  freeing, which is normally a local double cmpxchg only for a short
  term allocations (so the same slab is still active on the same cpu when
  freeing the object) and a more costly locked double cmpxchg otherwise.
  The downside is the lack of NUMA locality guarantees for the allocated
  objects.

- kfree_rcu() batching and recycling. kfree_rcu() will put objects to a
  separate percpu sheaf and only submit the whole sheaf to call_rcu()
  when full. After the grace period, the sheaf can be used for
  allocations, which is more efficient than freeing and reallocating
  individual slab objects (even with the batching done by kfree_rcu()
  implementation itself). In case only some cpus are allowed to handle rcu
  callbacks, the sheaf can still be made available to other cpus on the
  same node via the shared barn. The maple_node cache uses kfree_rcu() and
  thus can benefit from this.

- Preallocation support. A prefilled sheaf can be privately borrowed for
  a short term operation that is not allowed to block in the middle and
  may need to allocate some objects. If an upper bound (worst case) for
  the number of allocations is known, but only much fewer allocations
  actually needed on average, borrowing and returning a sheaf is much more
  efficient then a bulk allocation for the worst case followed by a bulk
  free of the many unused objects. Maple tree write operations should
  benefit from this.

Patch 1 is copied from the series "bpf, mm: Introduce try_alloc_pages()"
[2] to introduce a variant of local_lock that has a trylock operation.

Patch 2 implements the basic sheaf functionality as a caching layer on
top of (per-cpu) slabs.

Patch 3 adds the sheaf kfree_rcu() support.

Patch 4 implements borrowing prefilled sheaves, with maple tree being the
ancticipated user.

Patch 5 seeks to reduce barn spinlock contention. Separately for
possible evaluation.

Patches 6 and 7 by Liam add testing stubs that maple tree will use in
its userspace tests.

Patch 9 enables sheaves for the maple tree node cache, but does not
take advantage of prefilling yet.

(RFC) LIMITATIONS:

- with slub_debug enabled, objects in sheaves are considered allocated
  so allocation/free stacktraces may become imprecise and checking of
  e.g. redzone violations may be delayed

GIT TREES:

this series: https://git.kernel.org/vbabka/l/slub-percpu-sheaves-v3

To avoid conflicts, the series requires (and the branch above is based
on) the kfree_rcu() code refactoring scheduled for 6.15:

https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?h=slab/for-6.15/kfree_rcu_tiny

Vlastimil

[1] https://lore.kernel.org/all/20241111205506.3404479-1-surenb@google.com/
[2] https://lore.kernel.org/all/20250222024427.30294-2-alexei.starovoitov@gmail.com/
[3] https://lore.kernel.org/all/20250213224655.1680278-1-surenb@google.com/
[4] https://www.infradead.org/git/?p=users/jedix/linux-maple.git;a=shortlog;h=refs/heads/slub-percpu-sheaves-v2
[5] https://lore.kernel.org/all/CAJuCfpFVopL%2BsMdU4bLRxs%2BHS_WPCmFZBdCmwE8qV2Dpa5WZnA@mail.gmail.com/

---
Changes in v3:
- Squash localtry_lock conversion so it's used immediately.
- Incorporate feedback and add tags from Suren and Harry - thanks!
  - Mostly adding comments and some refactoring.
  - Fixes for kfree_rcu_sheaf() vmalloc handling, cpu hotremove
    flushing.
  - Fix wrong condition in kmem_cache_return_sheaf() that may have
    affected performance negatively.
  - Refactoring of free_to_pcs()
- Link to v2: https://lore.kernel.org/r/20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz

Changes in v2:
- Removed kfree_rcu() destructors support as VMAs will not need it
  anymore after [3] is merged.
- Changed to localtry_lock_t borrowed from [2] instead of an own
  implementation of the same idea.
- Many fixes and improvements thanks to Liam's adoption for maple tree
  nodes.
- Userspace Testing stubs by Liam.
- Reduced limitations/todos - hooking to kfree_rcu() is complete,
  prefilled sheaves can exceed cache's sheaf_capacity.
- Link to v1: https://lore.kernel.org/r/20241112-slub-percpu-caches-v1-0-ddc0bdc27e05@suse.cz

---
Liam R. Howlett (2):
      tools: Add testing support for changes to rcu and slab for sheaves
      tools: Add sheafs support to testing infrastructure

Sebastian Andrzej Siewior (1):
      locking/local_lock: Introduce localtry_lock_t

Vlastimil Babka (5):
      slab: add opt-in caching layer of percpu sheaves
      slab: add sheaf support for batching kfree_rcu() operations
      slab: sheaf prefilling for guaranteed allocations
      slab: determine barn status racily outside of lock
      maple_tree: use percpu sheaves for maple_node_cache

 include/linux/local_lock.h            |   70 ++
 include/linux/local_lock_internal.h   |  146 ++++
 include/linux/slab.h                  |   50 ++
 lib/maple_tree.c                      |   11 +-
 mm/slab.h                             |    4 +
 mm/slab_common.c                      |   29 +-
 mm/slub.c                             | 1463 +++++++++++++++++++++++++++++++--
 tools/include/linux/slab.h            |   65 +-
 tools/testing/shared/linux.c          |  108 ++-
 tools/testing/shared/linux/rcupdate.h |   22 +
 10 files changed, 1891 insertions(+), 77 deletions(-)
---
base-commit: 379487e17ca406b47392e7ab6cf35d1c3bacb371
change-id: 20231128-slub-percpu-caches-9441892011d7
prerequisite-message-id: 20250203-slub-tiny-kfree_rcu-v1-0-d4428bf9a8a1@suse.cz
prerequisite-patch-id: 1a4af92b5eb1b8bfc86bac8d7fc1ef0963e7d9d6
prerequisite-patch-id: f24a39c38103b7e09fbf2e6f84e6108499ab7980
prerequisite-patch-id: 23e90b23482f4775c95295821dd779ba4e3712e9
prerequisite-patch-id: 5c53a619477acdce07071abec0f40e79501ea40b

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>

