Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE20113AA2A;
	Mon, 15 Jul 2024 20:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721075382; cv=none; b=cHCGzNrzjaObzQNkce/qwm9rfSHBz6+Hugs0TRli8yMJCGE/9X7Y4iIkLRWvpRTvwcTe2O8Ky87gf15bGbQhpR2s8Dxo6hi/c1oTq7VTmpIDk+wib0uF17VJA9JkgAk0cWygwpgT6KFSfMpE4Hq225VqDaNTnt7xsLChhguxVew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721075382; c=relaxed/simple;
	bh=PyA7+JE53jm1V8xWSKWX2udYT1/WEN+7GBfqS43WdJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PnNXpcxqNxUKhpd2XPaVphOQNWh24O5XXNiyZtQF2wnZXPrndEm5QpwEZhesS/Wm+jTqVxLJc0mxAgMARTi3hcR4afimc9KekGdgd43cu419PEUtaeg80hwNt6wfLWgzTDhHjqPJTq+14BgfrjkbyIJqfXcfQvQCcIgxpl1ZzVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SwlIHH5d; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o3BTn/mj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SwlIHH5d; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o3BTn/mj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SwlIHH5d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o3BTn/mj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SwlIHH5d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o3BTn/mj"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 161FB21BCE;
	Mon, 15 Jul 2024 20:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721075379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NU1ukOjEPV7zEMcpTecl7WdxnTW88aCY09Hfdb+DK10=;
	b=SwlIHH5d0ynfQ2BNBAJQLY3/sIgnYBrQFJjZOlOwPEVsX3LKgz9QDz/5pEvFogKr8ImAr3
	uDSCuxn3SbLkgB0p6T5MXVnoZpkRoCxI0ZUjMLC+UWX1kYFRnwq85/vXupm0TkfoW6BEhh
	ucAONbfc+WVe/TH5KP+axsZGc9U6vpY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721075379;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NU1ukOjEPV7zEMcpTecl7WdxnTW88aCY09Hfdb+DK10=;
	b=o3BTn/mjXjGJHsMvmm/YT9CypKvUmnDz59+qTmH6ye4Cy6nFtkAELn3eaYsl2cPgg2PfgP
	KtKQz92g/45hsCBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SwlIHH5d;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="o3BTn/mj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721075379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NU1ukOjEPV7zEMcpTecl7WdxnTW88aCY09Hfdb+DK10=;
	b=SwlIHH5d0ynfQ2BNBAJQLY3/sIgnYBrQFJjZOlOwPEVsX3LKgz9QDz/5pEvFogKr8ImAr3
	uDSCuxn3SbLkgB0p6T5MXVnoZpkRoCxI0ZUjMLC+UWX1kYFRnwq85/vXupm0TkfoW6BEhh
	ucAONbfc+WVe/TH5KP+axsZGc9U6vpY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721075379;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NU1ukOjEPV7zEMcpTecl7WdxnTW88aCY09Hfdb+DK10=;
	b=o3BTn/mjXjGJHsMvmm/YT9CypKvUmnDz59+qTmH6ye4Cy6nFtkAELn3eaYsl2cPgg2PfgP
	KtKQz92g/45hsCBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EACBD1395F;
	Mon, 15 Jul 2024 20:29:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kEgRObKGlWbvUwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 15 Jul 2024 20:29:38 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 15 Jul 2024 22:29:30 +0200
Subject: [PATCH RFC 4/6] mm, slab: simplify kmem_cache_release()
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-b4-slab-kfree_rcu-destroy-v1-4-46b2984c2205@suse.cz>
References: <20240715-b4-slab-kfree_rcu-destroy-v1-0-46b2984c2205@suse.cz>
In-Reply-To: <20240715-b4-slab-kfree_rcu-destroy-v1-0-46b2984c2205@suse.cz>
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
X-Rspamd-Queue-Id: 161FB21BCE
X-Spam-Flag: NO
X-Spam-Score: 0.99
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.99 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[kernel.org,joelfernandes.org,joshtriplett.org,gmail.com,linux.com,google.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[21];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[goodmis.org,efficios.com,gmail.com,inria.fr,kernel.org,zx2c4.com,linux-foundation.org,linux.dev,kvack.org,vger.kernel.org,suse.cz];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Level: 
X-Spamd-Bar: /

kfence_shutdown_cache() is now called always just before
kmem_cache_release() so move it there.

Also replace two variants of the functions by using
__is_defined(SLAB_SUPPORTS_SYSFS).

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab_common.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 2eef5ad37fa7..57962e1a5a86 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -486,7 +486,6 @@ kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
 }
 EXPORT_SYMBOL(kmem_buckets_create);
 
-#ifdef SLAB_SUPPORTS_SYSFS
 /*
  * For a given kmem_cache, kmem_cache_destroy() should only be called
  * once or there will be a use-after-free problem. The actual deletion
@@ -495,18 +494,12 @@ EXPORT_SYMBOL(kmem_buckets_create);
  */
 static void kmem_cache_release(struct kmem_cache *s)
 {
-	if (slab_state >= FULL) {
+	kfence_shutdown_cache(s);
+	if (__is_defined(SLAB_SUPPORTS_SYSFS) && slab_state >= FULL)
 		sysfs_slab_release(s);
-	} else {
+	else
 		slab_kmem_cache_release(s);
-	}
-}
-#else
-static void kmem_cache_release(struct kmem_cache *s)
-{
-	slab_kmem_cache_release(s);
 }
-#endif
 
 static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
 {
@@ -531,10 +524,8 @@ static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
 
 	rcu_barrier();
 
-	list_for_each_entry_safe(s, s2, &to_destroy, list) {
-		kfence_shutdown_cache(s);
+	list_for_each_entry_safe(s, s2, &to_destroy, list)
 		kmem_cache_release(s);
-	}
 }
 
 void slab_kmem_cache_release(struct kmem_cache *s)
@@ -591,7 +582,6 @@ void kmem_cache_destroy(struct kmem_cache *s)
 		schedule_work(&slab_caches_to_rcu_destroy_work);
 		mutex_unlock(&slab_mutex);
 	} else {
-		kfence_shutdown_cache(s);
 		kmem_cache_release(s);
 	}
 }

-- 
2.45.2

