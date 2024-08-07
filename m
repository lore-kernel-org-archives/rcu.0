Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82311C823D;
	Wed,  7 Aug 2024 10:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723026703; cv=none; b=K0zLRhccWozs5JnCZ2C3vGEVfvHlqcrqLorTK3JpgXODiOaOVBHrc3gmU+E0lEgMnF15CGWP21SMRfx0KMDNFxEfE9AZ1dXjGE3qhNbGuRle6iF7OJvN8P/dJoANTDMS26i91JJWy+2M6VHcnLMCROzeFj8v02TGUz38gBWJrSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723026703; c=relaxed/simple;
	bh=f1UN3sUNh+9LBaSZt6eaV0/ZDh2ZO0Hxr7n+OHWD/3g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IEcu8xAjZNeQj2PMwhtqz3I9bHywoHZqZt7TByRNd9PO49yeVLnSxaRQe3651fJ6SL9ysYmqa4LO/t/Aguzp9r6bAWOzukK0NBmCDoWdLTUc/yUFOlSDrS1ZEL6N5IYQ86VU0mu3jSnLIH1/JkTG7XYo5N0xL9CS00ualpkXpnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cLY3/utF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aKb3bOME; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cLY3/utF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aKb3bOME; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cLY3/utF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aKb3bOME";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cLY3/utF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aKb3bOME"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9D1BE21B30;
	Wed,  7 Aug 2024 10:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723026693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MYAQdZfiQ9b2HS7QQayr4v2PzJCMJBGtNuCobIJ9kog=;
	b=cLY3/utFzR5G3V/XxZK66w1hKI7zztrmY2agOcJq2AtoIbw0KWSjpeZCldsX94i4eEQSV4
	KoTs0wdmYXemgTm1TPUpfcr782fz/9E9l4YQLA8wvpn4zbENmVTG8Kk9Uj7JBHCBZhpcAD
	lWxbMEzL60zqw5BIi3i4FvJE3gPz3eY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723026693;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MYAQdZfiQ9b2HS7QQayr4v2PzJCMJBGtNuCobIJ9kog=;
	b=aKb3bOMEXUnsdzgDug3GWG+Gfd26M4sIVpomf1zjqE4sNJKZax0GGgM3p4N7i13iwnmkq0
	cjtKorDtNeDJ2tBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="cLY3/utF";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=aKb3bOME
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723026693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MYAQdZfiQ9b2HS7QQayr4v2PzJCMJBGtNuCobIJ9kog=;
	b=cLY3/utFzR5G3V/XxZK66w1hKI7zztrmY2agOcJq2AtoIbw0KWSjpeZCldsX94i4eEQSV4
	KoTs0wdmYXemgTm1TPUpfcr782fz/9E9l4YQLA8wvpn4zbENmVTG8Kk9Uj7JBHCBZhpcAD
	lWxbMEzL60zqw5BIi3i4FvJE3gPz3eY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723026693;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MYAQdZfiQ9b2HS7QQayr4v2PzJCMJBGtNuCobIJ9kog=;
	b=aKb3bOMEXUnsdzgDug3GWG+Gfd26M4sIVpomf1zjqE4sNJKZax0GGgM3p4N7i13iwnmkq0
	cjtKorDtNeDJ2tBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7078B13297;
	Wed,  7 Aug 2024 10:31:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KnTUGgVNs2YsHwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 07 Aug 2024 10:31:33 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 0/7] mm, slub: handle pending kfree_rcu() in
 kmem_cache_destroy()
Date: Wed, 07 Aug 2024 12:31:13 +0200
Message-Id: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPFMs2YC/42NQQ6CMBBFr2Jm7ZgyKQquvIchhraDNBowM0BEw
 t2tnMDle8l/fwFliaxw3i0gPEWNfZeA9jvwbd3dGWNIDGTImlOWo7Ooz9rhoxHmm/gRA+sg/Yx
 FHgI5ChxKgrR/CTfxvbWvVeI26tDLvF1N2c/+U50yNGiPjsrCeiKTX3RUPvgPVOu6fgGMaZPzw
 AAAAA==
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
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
 Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
 Jann Horn <jannh@google.com>, Mateusz Guzik <mjguzik@gmail.com>, 
 Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.1
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 9D1BE21B30
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[kernel.org,joelfernandes.org,joshtriplett.org,gmail.com,linux.com,google.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[goodmis.org,efficios.com,gmail.com,inria.fr,kernel.org,zx2c4.com,linux-foundation.org,linux.dev,kvack.org,vger.kernel.org,google.com,googlegroups.com,suse.cz];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLsm9p66qmnckghmjmpccdnq6s)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Also in git:
https://git.kernel.org/vbabka/l/slab-kfree_rcu-destroy-v2r2

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
it adds no additional concerns to kfree_rcu() users.

We already have the precedence in some parts of the kmem_cache cleanup
being done asynchronously for SLAB_TYPESAFE_BY_RCU caches. The v1 of
this RFC took the same approach for asynchronously waiting for pending
kfree_rcu(). Mateusz Guzik on IRC questioned this approach, and it turns
out the rcu_barrier() used to be synchronous before commit 657dc2f97220
("slab: remove synchronous rcu_barrier() call in memcg cache release
path") and the motivation for that is no longer applicable. So instead
in v2 the existing barrier is reverted to be synchronous, and the new
barrier for kfree_rcu() is also called sychronously.

The new kvfree_rcu_barrier() was provided by Uladzislau Rezki in a patch
[5] carried now by this series.

There is also a bunch of preliminary cleanup steps. The potentially
visible one is that sysfs and debugfs directories, as well as
/proc/slabinfo record of the cache are now removed immediately during
kmem_cache_destroy() - previously this would be delayed for
SLAB_TYPESAFE_BY_RCU caches or left around forever if leaked objects
were detected. Even though we no longer have the delayed removal, leaked
objects should not prevent the cache to be recreated including its sysfs
and debugfs directories, so it's better to make this cleanup anyway.
The immediate removal is the simplest solution (compared to e.g.
renaming the directories) and should not make debugging harder - while
it won't be possible to check debugfs for allocation traces of leaked
objects, they are listed with more detail in dmesg anyway.

[1] https://lore.kernel.org/all/20240609082726.32742-1-Julia.Lawall@inria.fr/
[2] https://lore.kernel.org/all/20240612143305.451abf58@kernel.org/
[3] https://lore.kernel.org/all/Zmo9-YGraiCj5-MI@zx2c4.com/
[4] https://docs.google.com/document/d/1v0rcZLvvjVGejT3523W0rDy_sLFu2LWc_NR3fQItZaA/edit
[5] https://lore.kernel.org/all/20240801111039.79656-1-urezki@gmail.com/

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
Cc: Alexander Potapenko <glider@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: kasan-dev@googlegroups.com
Cc: Jann Horn <jannh@google.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
Changes in v2:
- Include the necessary barrier implementation (by Uladzislau Rezki)
- Switch to synchronous barriers (Mateusz Guzik)
- Moving of kfence_shutdown_cache() outside slab_mutex done in a
  separate step for review and bisectability.
- Additional kunit test for destroying a cache with leaked object.
- Link to v1: https://lore.kernel.org/r/20240715-b4-slab-kfree_rcu-destroy-v1-0-46b2984c2205@suse.cz

---
Uladzislau Rezki (Sony) (1):
      rcu/kvfree: Add kvfree_rcu_barrier() API

Vlastimil Babka (6):
      mm, slab: dissolve shutdown_cache() into its caller
      mm, slab: unlink slabinfo, sysfs and debugfs immediately
      mm, slab: move kfence_shutdown_cache() outside slab_mutex
      mm, slab: reintroduce rcu_barrier() into kmem_cache_destroy()
      mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()
      kunit, slub: add test_kfree_rcu() and test_leak_destroy()

 include/linux/rcutiny.h |   5 +++
 include/linux/rcutree.h |   1 +
 kernel/rcu/tree.c       | 103 ++++++++++++++++++++++++++++++++++++++++----
 lib/slub_kunit.c        |  31 ++++++++++++++
 mm/slab_common.c        | 111 ++++++++++++++----------------------------------
 5 files changed, 163 insertions(+), 88 deletions(-)
---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240715-b4-slab-kfree_rcu-destroy-85dd2b2ded92

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>

