Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F67A1D365C;
	Wed,  7 Aug 2024 10:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723026704; cv=none; b=F+f6ntAOmecBulyG8bQAaqZ0NLo1MvfUqdquF9IVChKCLJbuZUDHQNYGWwFSPWr23r87Fo2O/83IFZnH2aCQjzGscw/XFuo2PKFHrakyyA+PhoYKskpSUZ4WdXL4rOVnzv+nqNtH7t33DpAD9eFi0j+JSdGrpx1Qf/SJGkdpHvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723026704; c=relaxed/simple;
	bh=evxzCTWCDQfcpF6frzqbhgzHo8yDiLX25dyXYcfc6kU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=giYg6xF9xE+wbkgxei0KA9vE/yyFj1JHRGEnsz4YGfuMpgqcyiDjWFgczJn3zBrksOHQXhwS2hi5Qy4+JlRaMTA6JEas0rrXuvByWGFgZLf4P5+HkqPT1gM562sMGoeyZBXMs02B1gtZiKmgBC80Nxb5Cq0L8awH+obkTXYHKpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wJzF/g6n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XJKck9Ri; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wJzF/g6n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XJKck9Ri; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wJzF/g6n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XJKck9Ri";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wJzF/g6n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XJKck9Ri"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1D32E21CF0;
	Wed,  7 Aug 2024 10:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723026694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Upn+l7aIdIa1NYqSvgAPp2lNr0Z+34OGHoqNziNBnOM=;
	b=wJzF/g6nBkUp2U1+03yNOdlGyz2ExiWnsH3D/0Wwg/RXxLwUipTPUlBysih9eTFbPT95HJ
	KnlcMXhUgiqjP73r6WibjR/7FEVkpwZXxuTlvlrwUfJ0/M8vHk9ErP/rWQOgmf/WRzOyDB
	8bIw7+Qj4Lac6rQngcwV16wpIcnjSdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723026694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Upn+l7aIdIa1NYqSvgAPp2lNr0Z+34OGHoqNziNBnOM=;
	b=XJKck9RiujgMYrmJ/eDJpmgVR9itnsNx6AAUnOBb58PCpTCwKezxC2ANlomHFHr15pB6uj
	THCMdGLt2CwDHBBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723026694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Upn+l7aIdIa1NYqSvgAPp2lNr0Z+34OGHoqNziNBnOM=;
	b=wJzF/g6nBkUp2U1+03yNOdlGyz2ExiWnsH3D/0Wwg/RXxLwUipTPUlBysih9eTFbPT95HJ
	KnlcMXhUgiqjP73r6WibjR/7FEVkpwZXxuTlvlrwUfJ0/M8vHk9ErP/rWQOgmf/WRzOyDB
	8bIw7+Qj4Lac6rQngcwV16wpIcnjSdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723026694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Upn+l7aIdIa1NYqSvgAPp2lNr0Z+34OGHoqNziNBnOM=;
	b=XJKck9RiujgMYrmJ/eDJpmgVR9itnsNx6AAUnOBb58PCpTCwKezxC2ANlomHFHr15pB6uj
	THCMdGLt2CwDHBBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E333F13297;
	Wed,  7 Aug 2024 10:31:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sNEoNwVNs2YsHwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 07 Aug 2024 10:31:33 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 07 Aug 2024 12:31:16 +0200
Subject: [PATCH v2 3/7] mm, slab: move kfence_shutdown_cache() outside
 slab_mutex
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240807-b4-slab-kfree_rcu-destroy-v2-3-ea79102f428c@suse.cz>
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
X-Spamd-Result: default: False [0.20 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_TO(0.00)[kernel.org,joelfernandes.org,joshtriplett.org,gmail.com,linux.com,google.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[goodmis.org,efficios.com,gmail.com,inria.fr,kernel.org,zx2c4.com,linux-foundation.org,linux.dev,kvack.org,vger.kernel.org,google.com,googlegroups.com,suse.cz];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: 0.20

kfence_shutdown_cache() is called under slab_mutex when the cache is
destroyed synchronously, and outside slab_mutex during the delayed
destruction of SLAB_TYPESAFE_BY_RCU caches.

It seems it should always be safe to call it outside of slab_mutex so we
can just move the call to kmem_cache_release(), which is called outside.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab_common.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index db61df3b4282..a079b8540334 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -492,6 +492,7 @@ EXPORT_SYMBOL(kmem_buckets_create);
  */
 static void kmem_cache_release(struct kmem_cache *s)
 {
+	kfence_shutdown_cache(s);
 	if (__is_defined(SLAB_SUPPORTS_SYSFS) && slab_state >= FULL)
 		sysfs_slab_release(s);
 	else
@@ -521,10 +522,8 @@ static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
 
 	rcu_barrier();
 
-	list_for_each_entry_safe(s, s2, &to_destroy, list) {
-		kfence_shutdown_cache(s);
+	list_for_each_entry_safe(s, s2, &to_destroy, list)
 		kmem_cache_release(s);
-	}
 }
 
 void slab_kmem_cache_release(struct kmem_cache *s)
@@ -563,9 +562,6 @@ void kmem_cache_destroy(struct kmem_cache *s)
 
 	list_del(&s->list);
 
-	if (!err && !rcu_set)
-		kfence_shutdown_cache(s);
-
 	mutex_unlock(&slab_mutex);
 	cpus_read_unlock();
 

-- 
2.46.0

