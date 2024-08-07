Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A275A1DD398;
	Wed,  7 Aug 2024 10:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723026704; cv=none; b=Dqi7p6sh+Q+vAbYcAbjxXrTajDnIb+VLvnSxjeVeSS+P42zJsUrbDfGXgxCOufD+qEw6srwXSHB27ETtOBchIKH8KGRU4SLVSGny+vTaBJuGaa7Uz6iNiKCzq3TOf9q8TswmDrdfywcrWWZjA+OFUtlGdeeh537BE08P54xIAIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723026704; c=relaxed/simple;
	bh=1SjpLUxInJUsm5hyKUAPgUIElsshMJHymB63wFaYeyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f2Sg+GApnCrOkB661yNjiK0PKgRfrZ+GEf+0s1QzZ5t1SypOESf4rLL+ToJW8Q6vdBQ0/djm8uzENmFYP13htjPc0JZRNlNntBYtZk1ScPiERDYTaWdEDkRXd0EFtKyf5f5+eVrwU1uvMl9v7YiqEklKpfiUtVRqrSkO6WThkKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=H+6QUiPp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eEuKmuDB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fOdhnuMq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1OHbFK1E; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="H+6QUiPp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eEuKmuDB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fOdhnuMq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1OHbFK1E"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C1E7121B34;
	Wed,  7 Aug 2024 10:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723026694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ZCscfrhLRUfMCCWf1VM+44Ik8h8Xr8RVOlGx1djGvg=;
	b=H+6QUiPpPhQpEm6CkhIQP14Nxt2nm39M0qa/fJzn4/8NcdPkEUbNCp5ApLUluDayMmbxsI
	Ogz3u05H/9SvrmD4bmitU98bMZCZWVObe1YdKZX1LpMN91aWxqVT48m9urAnIRc/CD5RO8
	1R58YVokSRFEo2xz5mpXUZIoyjK1GL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723026694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ZCscfrhLRUfMCCWf1VM+44Ik8h8Xr8RVOlGx1djGvg=;
	b=eEuKmuDBbPGuw/CzZG72wgUoZmxzsyiQjilyImHwCV8XORHQc5MhvIPrYkRCPLPWl+3ktT
	C3xDmnek8T5zSoDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723026693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ZCscfrhLRUfMCCWf1VM+44Ik8h8Xr8RVOlGx1djGvg=;
	b=fOdhnuMq7Epl6L70RKYzdyPXf7JSKSyqw8P8qa/e+I+vTB9ms9RMNNq8iguFye8Z6GQNMy
	KX61+KuWN4iKeQlnMUql60dxMyVrbLMIRCvCD5QyE/TsOEkeCgSI4F0BWo6MX0Tzl0j3RU
	hCGB5k4ZNsoMAoVbDGPKVBLFg6XktVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723026693;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ZCscfrhLRUfMCCWf1VM+44Ik8h8Xr8RVOlGx1djGvg=;
	b=1OHbFK1EKbGQNsgpWy4MW+DURb63K9CBOD0BAlrZCWjH1MoaX1crKULopCP6ajBRGJfEZs
	CfKnGAJqy5lLSYBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96CED13B03;
	Wed,  7 Aug 2024 10:31:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ePOIJAVNs2YsHwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 07 Aug 2024 10:31:33 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 07 Aug 2024 12:31:14 +0200
Subject: [PATCH v2 1/7] mm, slab: dissolve shutdown_cache() into its caller
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240807-b4-slab-kfree_rcu-destroy-v2-1-ea79102f428c@suse.cz>
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
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_TO(0.00)[kernel.org,joelfernandes.org,joshtriplett.org,gmail.com,linux.com,google.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[goodmis.org,efficios.com,gmail.com,inria.fr,kernel.org,zx2c4.com,linux-foundation.org,linux.dev,kvack.org,vger.kernel.org,google.com,googlegroups.com,suse.cz];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	R_RATELIMIT(0.00)[to_ip_from(RLtsk3gtac773whqka7ht6mdi4)]
X-Spam-Score: -2.80
X-Spam-Flag: NO
X-Spam-Level: 

There's only one caller of shutdown_cache() so move the code into it.
Preparatory patch for further changes, no functional change.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab_common.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 40b582a014b8..b76d65d7fe33 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -540,27 +540,6 @@ static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
 	}
 }
 
-static int shutdown_cache(struct kmem_cache *s)
-{
-	/* free asan quarantined objects */
-	kasan_cache_shutdown(s);
-
-	if (__kmem_cache_shutdown(s) != 0)
-		return -EBUSY;
-
-	list_del(&s->list);
-
-	if (s->flags & SLAB_TYPESAFE_BY_RCU) {
-		list_add_tail(&s->list, &slab_caches_to_rcu_destroy);
-		schedule_work(&slab_caches_to_rcu_destroy_work);
-	} else {
-		kfence_shutdown_cache(s);
-		debugfs_slab_release(s);
-	}
-
-	return 0;
-}
-
 void slab_kmem_cache_release(struct kmem_cache *s)
 {
 	__kmem_cache_release(s);
@@ -585,9 +564,26 @@ void kmem_cache_destroy(struct kmem_cache *s)
 	if (s->refcount)
 		goto out_unlock;
 
-	err = shutdown_cache(s);
+	/* free asan quarantined objects */
+	kasan_cache_shutdown(s);
+
+	err = __kmem_cache_shutdown(s);
 	WARN(err, "%s %s: Slab cache still has objects when called from %pS",
 	     __func__, s->name, (void *)_RET_IP_);
+
+	if (err)
+		goto out_unlock;
+
+	list_del(&s->list);
+
+	if (rcu_set) {
+		list_add_tail(&s->list, &slab_caches_to_rcu_destroy);
+		schedule_work(&slab_caches_to_rcu_destroy_work);
+	} else {
+		kfence_shutdown_cache(s);
+		debugfs_slab_release(s);
+	}
+
 out_unlock:
 	mutex_unlock(&slab_mutex);
 	cpus_read_unlock();

-- 
2.46.0

