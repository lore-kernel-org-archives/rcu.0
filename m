Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDF017A2EE
	for <rcu@vger.kernel.org>; Fri, 25 Apr 2025 08:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745569677; cv=none; b=k3JWEFV1o53rOqzTeLenw5n8amGPAU67lxyRqrr7ng18JnU4cSTG28w/KkvvZICJH2Sc2iv/mQ+OSWHT4jFvIPeYy57Oke9pv34TByATrOIjh5hWg+22qQXexl9Rh6GQTE+4FC6f5uZMU/NRt2JQRkHJuuumqw2bD9b5Rr0up4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745569677; c=relaxed/simple;
	bh=sBDPAp0HPy8vjmmkX+PZk30VjcYafj0a2g1pDT2xgN0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SNuZb8g7+SywQHLuqwkNU0Nci/ZlOfVprqDouwXHZ+V5raLyBeb/eTl5YO0G/jsAMCfbLa1RfzR2AkHlk7RGtthrjkQNP6UcQgLXxSgiArCQSYRvYAnZbDi2WIj4G//pysU0hj0Du6TcKObDFCD3ImoypZrIbtkvSqJHIG7h13g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DP2Hzioa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XSfDmBC3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DP2Hzioa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XSfDmBC3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DP2Hzioa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XSfDmBC3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DP2Hzioa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XSfDmBC3"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A781121164;
	Fri, 25 Apr 2025 08:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745569672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DyQE//GcgRfm4C5qTatYzEET3PMAoGBC3YbFpdgMWgM=;
	b=DP2Hzioam72G/38bV3f9MW3AmDrnHgnXag/VxUEbCvfjiLCIgt+PNnepaGwYD2yHAkkDzq
	btFZP9TOHx9r+C3ImNOdQv6Mkm2XOdFExHz3MzeZ1ouV2j5WZ7gkwHxAYovdebOlATNQxw
	t93rGgLyXMMg34j3V4yVy2ra3Pv39ng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745569672;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DyQE//GcgRfm4C5qTatYzEET3PMAoGBC3YbFpdgMWgM=;
	b=XSfDmBC3EDhW7TMhwQZdpIjX1bZaE30Wvida2t4/btTd1t3cnqcY1ej06t4LZ18lvc4k5D
	sFFpOhgYjxLeu+Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745569672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DyQE//GcgRfm4C5qTatYzEET3PMAoGBC3YbFpdgMWgM=;
	b=DP2Hzioam72G/38bV3f9MW3AmDrnHgnXag/VxUEbCvfjiLCIgt+PNnepaGwYD2yHAkkDzq
	btFZP9TOHx9r+C3ImNOdQv6Mkm2XOdFExHz3MzeZ1ouV2j5WZ7gkwHxAYovdebOlATNQxw
	t93rGgLyXMMg34j3V4yVy2ra3Pv39ng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745569672;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DyQE//GcgRfm4C5qTatYzEET3PMAoGBC3YbFpdgMWgM=;
	b=XSfDmBC3EDhW7TMhwQZdpIjX1bZaE30Wvida2t4/btTd1t3cnqcY1ej06t4LZ18lvc4k5D
	sFFpOhgYjxLeu+Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8FD0A13A80;
	Fri, 25 Apr 2025 08:27:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IijLIohHC2htfwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 25 Apr 2025 08:27:52 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v4 0/9] SLUB percpu sheaves
Date: Fri, 25 Apr 2025 10:27:20 +0200
Message-Id: <20250425-slub-percpu-caches-v4-0-8a636982b4a4@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGlHC2gC/23QzU7DMBAE4FepfMbVru04dk+8B+Lgnw2xoE2wk
 wio+u44rWiFlOMc5tNozqxQTlTYYXdmmZZU0nCqQT3tWOjd6Y14ijUzAUIiCsPLx+z5SDmMMw8
 u9FS4VQqNFYAYW1aLY6YufV3Rl9eauzwc+dRncncKDAJqqUW71wI0t3zxzr+75zIX2oeflelTm
 Yb8fZ224IqtVYV1xtaKBTnwGAP4GERL0NytdcMi/oAGBKpNQFTAmMYKIrBau/+AfAAS201AVsB
 Ga4yKxmslH8Dldkumz7lePN2+Yd4V4mE4HtN02BlBXWy0dcaC7YRHiQoCehmpjpKNIwceGqzY5
 RfvPMFOtwEAAA==
X-Change-ID: 20231128-slub-percpu-caches-9441892011d7
To: Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 maple-tree@lists.infradead.org, vbabka@suse.cz, 
 "Liam R. Howlett" <Liam.Howlett@Oracle.com>
X-Mailer: b4 0.14.2
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,oracle.com,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,suse.cz,Oracle.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

Hi,

This is the v4 and first non-RFC series to add an opt-in percpu
array-based caching layer to SLUB, following the LSF/MM discussions.
Since v3 I've also made changes to achieve full compatibility with
slub_debug, and IRC discussions led to the last patch intended to
improve NUMA locality (the patch remains separate for evaluation
purposes).

Harry's RFC [1] also prompted me to reconsider the stat counters and as
a result I removed some that seemed unnecessary and added others that
were missing to evaluate how effective the barns and sheaf preffiling
are.

I have also addressed the RFC v3 feedback by Suren and Harry - thanks!

Note the name "sheaf" was invented by Matthew so we don't call the
arrays magazine like the original Bonwick paper. The per-NUMA-node cache
of sheaves is thus called "barn".

This caching may seem similar to the arrays in SLAB, but there are some
important differences:

- opt-in, not used for every cache
- does not distinguish NUMA locality, thus there are no per-node
  "shared" arrays (with possible lock contention) and no "alien" arrays
  that would need periodical flushing
  - NUMA restricted allocations and strict_numa mode is still honoured,
    the percpu sheaves are bypassed for those allocations
  - a later patch (for separate evaluation) makes freeing remote objects
    bypass sheaves so sheaves contain mostly (not strictly) local objects
- improves kfree_rcu() handling by reusing whole sheaves
- there is an API for obtaining a preallocated sheaf that can be used
  for guaranteed and efficient allocations in a restricted context, when
  the upper bound for needed objects is known but rarely reached

The motivation comes mainly from the ongoing work related to VMA locking
scalability and the related maple tree operations. This is why VMA and
maple nodes caches are sheaf-enabled in the patchset, but for maple tree
it's not a full conversion that would benefit from the improved
preallocation API.

Some performance benefits were measured by Suren and Liam in previous
versions. Suren's results in [2] looked quite promising.

A sheaf-enabled cache has the following expected advantages:

- Cheaper fast paths. For allocations, instead of local double cmpxchg,
  thanks to local_trylock() it becomes a preempt_disable() and no atomic
  operations. Same for freeing, which is normally a local double cmpxchg
  only for short term allocations (so the same slab is still active on the
  same cpu when freeing the object) and a more costly locked double
  cmpxchg otherwise.

  There is a possible downside with a larger fraction of
  non-NUMA-restricted allocations to get remote objects. The last patch
  changes it by making remote frees bypass sheaves. Some very preliminary
  measurements suggest only 5% frees are remote, but whether this is a net
  improvement has to be evaluated.

- kfree_rcu() batching and recycling. kfree_rcu() will put objects to a
  separate percpu sheaf and only submit the whole sheaf to call_rcu()
  when full. After the grace period, the sheaf can be used for
  allocations, which is more efficient than freeing and reallocating
  individual slab objects (even with the batching done by kfree_rcu()
  implementation itself). In case only some cpus are allowed to handle rcu
  callbacks, the sheaf can still be made available to other cpus on the
  same node via the shared barn. The maple_node cache uses kfree_rcu() and
  thus can benefit from this.

- Preallocation support. A prefilled sheaf can be privately borrowed to
  perform a short term operation that is not allowed to block in the
  middle and may need to allocate some objects. If an upper bound (worst
  case) for the number of allocations is known, but only much fewer
  allocations actually needed on average, borrowing and returning a sheaf
  is much more efficient then a bulk allocation for the worst case
  followed by a bulk free of the many unused objects. Maple tree write
  operations should benefit from this.

- Compatibility with slub_debug. When slub_debug is enabled for a cache,
  we simply don't create the percpu sheaves so that the debugging hooks
  (at the node partial list slowpaths) are reached as before. Sheaf
  preallocation still works by reusing the (ineffective) paths for
  requests exceeding the cache's sheaf_capacity. This is in line with the
  existing approach where debugging bypasses the fast paths.

GIT TREES:

this series: https://git.kernel.org/vbabka/l/slub-percpu-sheaves-v4r2

It is based on post-6.15-rc3 commit 82efd569a890 ("locking/local_lock:
fix _Generic() matching of local_trylock_t") as it definitely needs
local_trylock_t to work properly.

I have tried to rebase the full maple tree conversion, but there were
conflicts due to 6.15 changes and I don't know the code well enought to
resolve them confidently.

Vlastimil

[1] https://lore.kernel.org/all/20250407041810.13861-1-harry.yoo@oracle.com/
[2] https://lore.kernel.org/all/CAJuCfpFVopL%2BsMdU4bLRxs%2BHS_WPCmFZBdCmwE8qV2Dpa5WZnA@mail.gmail.com/

---
Changes in v4:
- slub_debug disables sheaves for the cache in order to work properly
- strict_numa mode works as intended
- added a separate patch to make freeing remote objects skip sheaves
- various code refactoring suggested by Suren and Harry
- removed less useful stat counters and added missing ones for barn
  and prefilled sheaf events
- Link to v3: https://lore.kernel.org/r/20250317-slub-percpu-caches-v3-0-9d9884d8b643@suse.cz

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
      tools: Add sheaves support to testing infrastructure

Vlastimil Babka (7):
      slab: add opt-in caching layer of percpu sheaves
      slab: add sheaf support for batching kfree_rcu() operations
      slab: sheaf prefilling for guaranteed allocations
      slab: determine barn status racily outside of lock
      maple_tree: use percpu sheaves for maple_node_cache
      mm, vma: use percpu sheaves for vm_area_struct cache
      mm, slub: skip percpu sheaves for remote object freeing

 include/linux/slab.h                  |   47 +
 kernel/fork.c                         |    1 +
 lib/maple_tree.c                      |   11 +-
 mm/slab.h                             |    5 +
 mm/slab_common.c                      |   32 +-
 mm/slub.c                             | 1573 +++++++++++++++++++++++++++++++--
 tools/include/linux/slab.h            |   65 +-
 tools/testing/shared/linux.c          |  108 ++-
 tools/testing/shared/linux/rcupdate.h |   22 +
 9 files changed, 1791 insertions(+), 73 deletions(-)
---
base-commit: 82efd569a8909f2b13140c1b3de88535aea0b051
change-id: 20231128-slub-percpu-caches-9441892011d7

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>

