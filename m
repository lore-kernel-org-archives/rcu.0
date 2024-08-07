Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3AB1E2103;
	Wed,  7 Aug 2024 10:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723026708; cv=none; b=YtDuceL/KlvVKwl/ECUw/19Qyd3QXknDDONZS9xYWtNTsxPqRoLmR+LPACZNJ+QlFv4YtmgwtBidn1fscT1PRF/9M4JPkd965xSzot91e7Zav5tjb5RMgbboRXwztSVbO6OHaE8c/s5Yje4pn33j9mLlCCfovwX4h4jAB7vOkfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723026708; c=relaxed/simple;
	bh=odcOPsl7Np+e6W0q9bc8BGObw3TeQehB272xRz/S2bw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SHip7bJFc35t22Dh3cVT5pHmUGk3aJIjLkwmuFA1uq4NZI2O530dB/mRLQx/zxR77qu7MkPh6mwljjtu22/Pqg2DyPLMZUEmFgy9b5XZ9CA+ypZgI06xZ3qAjsbPuKovl93pWdXNcV8e6//WG62xubZFRAaFNVOyXR4HFEw/whI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G9cWwfVr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=K+AeEX2G; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G9cWwfVr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=K+AeEX2G; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G9cWwfVr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="K+AeEX2G";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G9cWwfVr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="K+AeEX2G"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 98D2D21CF7;
	Wed,  7 Aug 2024 10:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723026694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=foIdXKngemBlbTDIsFcIDdiOSQLvnJzh8edzRJqHuXI=;
	b=G9cWwfVrm6JkmFYpoZ79hf1LRv8wfwCYrhj5x8KhYvHgPmR/Q8EoYbtVH8/cCiskxZYvvd
	E5icluLF+y0nv2ZVZL45wecJWESrbLKXcAvpFFq/iioLssYkIZYfITiIc/vSSC+Eb9IE1R
	+5ATK74aL1BUYbZYiE9eWHfEhcPz4xY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723026694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=foIdXKngemBlbTDIsFcIDdiOSQLvnJzh8edzRJqHuXI=;
	b=K+AeEX2G13kP7EZPoVKdShS1QkNC45172PSLvkDCLjgwVmS0cE6LRJjxTbf7bshybHTxvm
	PYcwtsP7pO28nBCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=G9cWwfVr;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=K+AeEX2G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723026694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=foIdXKngemBlbTDIsFcIDdiOSQLvnJzh8edzRJqHuXI=;
	b=G9cWwfVrm6JkmFYpoZ79hf1LRv8wfwCYrhj5x8KhYvHgPmR/Q8EoYbtVH8/cCiskxZYvvd
	E5icluLF+y0nv2ZVZL45wecJWESrbLKXcAvpFFq/iioLssYkIZYfITiIc/vSSC+Eb9IE1R
	+5ATK74aL1BUYbZYiE9eWHfEhcPz4xY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723026694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=foIdXKngemBlbTDIsFcIDdiOSQLvnJzh8edzRJqHuXI=;
	b=K+AeEX2G13kP7EZPoVKdShS1QkNC45172PSLvkDCLjgwVmS0cE6LRJjxTbf7bshybHTxvm
	PYcwtsP7pO28nBCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 629DA13B09;
	Wed,  7 Aug 2024 10:31:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GD/NFwZNs2YsHwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 07 Aug 2024 10:31:34 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 07 Aug 2024 12:31:19 +0200
Subject: [PATCH v2 6/7] mm, slab: call kvfree_rcu_barrier() from
 kmem_cache_destroy()
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240807-b4-slab-kfree_rcu-destroy-v2-6-ea79102f428c@suse.cz>
References: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz>
In-Reply-To: <20240807-b4-slab-kfree_rcu-destroy-v2-0-ea79102f428c@suse.cz>
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
X-Rspamd-Queue-Id: 98D2D21CF7
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

We would like to replace call_rcu() users with kfree_rcu() where the
existing callback is just a kmem_cache_free(). However this causes
issues when the cache can be destroyed (such as due to module unload).

Currently such modules should be issuing rcu_barrier() before
kmem_cache_destroy() to have their call_rcu() callbacks processed first.
This barrier is however not sufficient for kfree_rcu() in flight due
to the batching introduced by a35d16905efc ("rcu: Add basic support for
kfree_rcu() batching").

This is not a problem for kmalloc caches which are never destroyed, but
since removing SLOB, kfree_rcu() is allowed also for any other cache,
that might be destroyed.

In order not to complicate the API, put the responsibility for handling
outstanding kfree_rcu() in kmem_cache_destroy() itself. Use the newly
introduced kvfree_rcu_barrier() to wait before destroying the cache.
This is similar to how we issue rcu_barrier() for SLAB_TYPESAFE_BY_RCU
caches, but has to be done earlier, as the latter only needs to wait for
the empty slab pages to finish freeing, and not objects from the slab.

Users of call_rcu() with arbitrary callbacks should still issue
rcu_barrier() before destroying the cache and unloading the module, as
kvfree_rcu_barrier() is not a superset of rcu_barrier() and the
callbacks may be invoking module code or performing other actions that
are necessary for a successful unload.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab_common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index c40227d5fa07..1a2873293f5d 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -508,6 +508,9 @@ void kmem_cache_destroy(struct kmem_cache *s)
 	if (unlikely(!s) || !kasan_check_byte(s))
 		return;
 
+	/* in-flight kfree_rcu()'s may include objects from our cache */
+	kvfree_rcu_barrier();
+
 	cpus_read_lock();
 	mutex_lock(&slab_mutex);
 

-- 
2.46.0

