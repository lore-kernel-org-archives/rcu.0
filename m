Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FEC3234
	for <rcu@vger.kernel.org>; Fri, 14 Feb 2025 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550472; cv=none; b=Nmwt3On7jOHajQhAxU6XzXjIi1qZPazIzgTudD0Km+duWqYifPiNy3iIdpqxf5UUkjFQ/QLr3d/9/VGckOKFSKKM50KdrlAUJJBtdQSePCb6YDldtOtqY+9PSJX9jHd4WjRpzf8aWTMyRmZqpn+Hn/36jloXR95oS/IrEIV6/sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550472; c=relaxed/simple;
	bh=NBTYi6RzvX8crN6CyiiQ2D+XuuLAhlmsajhhMNLG9KA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=p2pcZjSpvp/Qe+h+QC3H+au1we1qkroiTnO39TTQ8MZt+GfgCeKVqau6duYr1QLzHcI5WwblFB1pXtbJkr//RxkJt6DAbY2VZRU507cob2zLjKMDlrRmaUq3ixOBqDBVzCTo63JQMMH6DxNYUhWGRM8CWX3wEnI0TaSwCNKVEOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=fail smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jyAmR/GF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PeFOIAhT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jyAmR/GF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PeFOIAhT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jyAmR/GF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PeFOIAhT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jyAmR/GF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PeFOIAhT"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 641572117B;
	Fri, 14 Feb 2025 16:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739550462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nf/XlYpDjnG9J+hfJsCr/dt+EOx2z1Zy5TaLLG3uKUw=;
	b=jyAmR/GFRnjTdWYnLeOUFxqCCOUKGjB0+iHnwCDdrfMOsRAOCi0i9YFrAkbMKDgYYj9TNM
	kEhtuAMS4adgcoZXjGcZzZMjkKn2PPvzShQDqmljVGFR861t0HX6h/DDvqCQQ2tTqD0J/E
	/3skWqa6qZu7w+DlpTAZN299DyUnDn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739550462;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nf/XlYpDjnG9J+hfJsCr/dt+EOx2z1Zy5TaLLG3uKUw=;
	b=PeFOIAhTBT76aPL3VwoUyh19OKDk1s2dkfvdg9l5pun1SHlbCJ8X+5jdUtG6fB2AL7ZKsV
	PL11ddLWB9LzL6Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739550462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nf/XlYpDjnG9J+hfJsCr/dt+EOx2z1Zy5TaLLG3uKUw=;
	b=jyAmR/GFRnjTdWYnLeOUFxqCCOUKGjB0+iHnwCDdrfMOsRAOCi0i9YFrAkbMKDgYYj9TNM
	kEhtuAMS4adgcoZXjGcZzZMjkKn2PPvzShQDqmljVGFR861t0HX6h/DDvqCQQ2tTqD0J/E
	/3skWqa6qZu7w+DlpTAZN299DyUnDn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739550462;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nf/XlYpDjnG9J+hfJsCr/dt+EOx2z1Zy5TaLLG3uKUw=;
	b=PeFOIAhTBT76aPL3VwoUyh19OKDk1s2dkfvdg9l5pun1SHlbCJ8X+5jdUtG6fB2AL7ZKsV
	PL11ddLWB9LzL6Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A31E13285;
	Fri, 14 Feb 2025 16:27:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sVnSEf5ur2eHSAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 14 Feb 2025 16:27:42 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH RFC v2 00/10] SLUB percpu sheaves
Date: Fri, 14 Feb 2025 17:27:36 +0100
Message-Id: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPlur2cC/22Qy2rDMBBFf8Vo3TGaseJHVoVCPqDbEookj2uR+
 BHJNk1D/r2KE0IXXd6BOffMXERg7ziIbXIRnhcX3NDHQC+JsK3uvxhcHbMgSRkilRCOs4GRvR1
 nsNq2HKBSCsuKJGJdiLg4em7c9wr9EO+7N7GPw8YPHUytZ/3kyRIl5llORZqTzKGCxWhz0K9hD
 pzanxurdWEa/Hn1W3AlxlWF0eU/lQVBQl1baWpLBcvNk7W/3s08n+Z45fTQMzow2KHr3LRNljx
 FBd7irbnjEPR6f3yHpI0kmd0rJ9ef4dB45k9v50enUlSaptKlxj+d119BymRYYQEAAA==
X-Change-ID: 20231128-slub-percpu-caches-9441892011d7
To: Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 maple-tree@lists.infradead.org, Vlastimil Babka <vbabka@suse.cz>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Alexei Starovoitov <ast@kernel.org>, 
 "Liam R. Howlett" <Liam.Howlett@Oracle.com>
X-Mailer: b4 0.14.2
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,suse.cz,linutronix.de,kernel.org,Oracle.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,infradead.org:url]
X-Spam-Flag: NO
X-Spam-Level: 

Hi,

This is the v2 RFC to add an opt-in percpu array-based caching layer to
SLUB. The name "sheaf" was invented by Matthew so we don't call it
magazine like the original Bonwick paper. The per-NUMA-node cache of
sheaves is thus called "barn".

This may seem similar to the arrays in SLAB, but the main differences
are:

- opt-in, not used for every cache
- does not distinguish NUMA locality, thus no "alien" arrays that would
  need periodical flushing
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
versions. I hope to have those numbers posted public as both this work
and the VMA and maple tree changes stabilize.

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

Patch 1 implements the basic sheaf functionality and using
local_lock_irqsave() for percpu sheaf locking.

Patch 2 adds the kfree_rcu() support.

Patch 3 is copied from the series "bpf, mm: Introduce try_alloc_pages()"
[2] to introduce a variant of local_lock that has a trylock operation.
Patch 4 adds a variant of the trylock without _irqsave. Patch 5 converts
percpu sheaves locking to the new variant of the lock.

Patch 6 implements borrowing prefilled sheaves, with maple tree being the
ancticipated user.

Patch 7 seeks to reduce barn spinlock contention. Separately for
possible evaluation.

Patches 8 and 9 by Liam add testing stubs that maple tree will use in
its userspace tests.

Patch 10 enables sheaves for the maple tree node cache, but does not
take advantage of prefilling yet.

(RFC) LIMITATIONS:

- with slub_debug enabled, objects in sheaves are considered allocated
  so allocation/free stacktraces may become imprecise and checking of
  e.g. redzone violations may be delayed

GIT TREES:

this series: https://git.kernel.org/vbabka/l/slub-percpu-sheaves-v2

To avoid conflicts, the series requires (and the branch above is based
on) the kfree_rcu() code refactoring scheduled for 6.15:

https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?h=slab/for-6.15/kfree_rcu_tiny

To facilitate testing/benchmarking, there's also a branch with Liam's
maple tree changes from [4] adapted to the current code:

https://git.kernel.org/vbabka/l/slub-percpu-sheaves-v2-maple

There are also two optimization patches for sheaves by Liam for
evaluation as I suspect they might not be universal win.

Vlastimil

[1] https://lore.kernel.org/all/20241111205506.3404479-1-surenb@google.com/
[2] https://lore.kernel.org/all/20250213033556.9534-4-alexei.starovoitov@gmail.com/
[3] https://lore.kernel.org/all/20250213224655.1680278-1-surenb@google.com/
[4] https://www.infradead.org/git/?p=users/jedix/linux-maple.git;a=shortlog;h=refs/heads/slub-percpu-sheaves-v2

---
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

Vlastimil Babka (7):
      slab: add opt-in caching layer of percpu sheaves
      slab: add sheaf support for batching kfree_rcu() operations
      locking/local_lock: add localtry_trylock()
      slab: switch percpu sheaves locking to localtry_lock
      slab: sheaf prefilling for guaranteed allocations
      slab: determine barn status racily outside of lock
      maple_tree: use percpu sheaves for maple_node_cache

 include/linux/local_lock.h            |   70 ++
 include/linux/local_lock_internal.h   |  146 ++++
 include/linux/slab.h                  |   50 ++
 lib/maple_tree.c                      |   11 +-
 mm/slab.h                             |    4 +
 mm/slab_common.c                      |   26 +-
 mm/slub.c                             | 1403 +++++++++++++++++++++++++++++++--
 tools/include/linux/slab.h            |   65 +-
 tools/testing/shared/linux.c          |  108 ++-
 tools/testing/shared/linux/rcupdate.h |   22 +
 10 files changed, 1840 insertions(+), 65 deletions(-)
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

