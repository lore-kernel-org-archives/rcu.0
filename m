Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5072E92C9
	for <rcu@vger.kernel.org>; Wed, 23 Jul 2025 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753277726; cv=none; b=B/fZXG4DtUKBPw7ml8vUT+JXVtnKJHQsyo3/UIB2IqqmiSZKWDSQRTJH2+AvLNZYunfkCNueoI/qY2aSotx98KFufFrtk3KaR83+2aeegEqfuwYd+np5bh3Kxrn5iT3xJyfWqaYJ38QR9blpE1/z2NQGlxM+84vkZiIYv8X3tC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753277726; c=relaxed/simple;
	bh=N92RPV8qw0pn5y79OhPB/vfZVX/JyOGcG+2Hg6SRHKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CpjFice15v3UjdUhVDWwsDW9TG7RiDMLOyK3sW/t/ShfZY5sJ3DrBPvPf0O5Z1XObtoS8mxWy6ZwpelG3IpT4joDBLMWY2vTnIMwcuisRXzCCm5TFhIOoMfgDkggUnzAI5yFC7DuUyHXZOmZPIkmzRztIgYT1DT2USpWug4hU00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aRy0XfV6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q81RoC3k; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aRy0XfV6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q81RoC3k; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aRy0XfV6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q81RoC3k";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aRy0XfV6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q81RoC3k"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B5FF7218F3;
	Wed, 23 Jul 2025 13:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753277704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BZ8jFguaUhh6ngJiPeQDDEWlyXz498l0EKqDytKUQuU=;
	b=aRy0XfV6iBHXc66Atd1OdHGcjOJGeVoDwjCdDi6IG1bqBLcKJ03/Ff4rIHu8ienAkNndOt
	7tKn/qP7oLqwY8TurNMa3eEGZ2DkqfD+BVqGpYBGZZISazTibzMxZMebBqVsMZrM8FnKgM
	ne7GThlYOUOie8dD7tbLgYExXL+P4u4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753277704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BZ8jFguaUhh6ngJiPeQDDEWlyXz498l0EKqDytKUQuU=;
	b=Q81RoC3k+Z4CAeXV+PTWo4u8vh/2Wn16aPOVxjCfIaXnN/mzeCqB9IOAHMQ7h8/oLePiSo
	zT/j7zbDqxQu19BQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=aRy0XfV6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Q81RoC3k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753277704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BZ8jFguaUhh6ngJiPeQDDEWlyXz498l0EKqDytKUQuU=;
	b=aRy0XfV6iBHXc66Atd1OdHGcjOJGeVoDwjCdDi6IG1bqBLcKJ03/Ff4rIHu8ienAkNndOt
	7tKn/qP7oLqwY8TurNMa3eEGZ2DkqfD+BVqGpYBGZZISazTibzMxZMebBqVsMZrM8FnKgM
	ne7GThlYOUOie8dD7tbLgYExXL+P4u4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753277704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BZ8jFguaUhh6ngJiPeQDDEWlyXz498l0EKqDytKUQuU=;
	b=Q81RoC3k+Z4CAeXV+PTWo4u8vh/2Wn16aPOVxjCfIaXnN/mzeCqB9IOAHMQ7h8/oLePiSo
	zT/j7zbDqxQu19BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FF1F13ADD;
	Wed, 23 Jul 2025 13:35:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AOy/JgjlgGh0IwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 23 Jul 2025 13:35:04 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 23 Jul 2025 15:34:44 +0200
Subject: [PATCH v5 11/14] testing/radix-tree/maple: Increase readers and
 reduce delay for faster machines
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-slub-percpu-caches-v5-11-b792cd830f5d@suse.cz>
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz>
In-Reply-To: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz>
To: Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 maple-tree@lists.infradead.org, vbabka@suse.cz, 
 "Liam R. Howlett" <howlett@gmail.com>
X-Mailer: b4 0.14.2
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B5FF7218F3
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,oracle.com,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,suse.cz];
	R_RATELIMIT(0.00)[to_ip_from(RLfsjnp7neds983g95ihcnuzgq)];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.51

From: "Liam R. Howlett" <howlett@gmail.com>

Add more threads and reduce the timing of the readers to increase the
possibility of catching the rcu changes.  The test does not pass unless
the reader is seen.

Signed-off-by: Liam R. Howlett <howlett@gmail.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 tools/testing/radix-tree/maple.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 2c0b3830125336af760768597d39ed07a2f8e92b..f6f923c9dc1039997953a94ec184c560b225c2d4 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -35062,7 +35062,7 @@ void run_check_rcu_slowread(struct maple_tree *mt, struct rcu_test_struct *vals)
 
 	int i;
 	void *(*function)(void *);
-	pthread_t readers[20];
+	pthread_t readers[30];
 	unsigned int index = vals->index;
 
 	mt_set_in_rcu(mt);
@@ -35080,14 +35080,14 @@ void run_check_rcu_slowread(struct maple_tree *mt, struct rcu_test_struct *vals)
 		}
 	}
 
-	usleep(5); /* small yield to ensure all threads are at least started. */
+	usleep(3); /* small yield to ensure all threads are at least started. */
 
 	while (index <= vals->last) {
 		mtree_store(mt, index,
 			    (index % 2 ? vals->entry2 : vals->entry3),
 			    GFP_KERNEL);
 		index++;
-		usleep(5);
+		usleep(2);
 	}
 
 	while (i--)
@@ -35098,6 +35098,7 @@ void run_check_rcu_slowread(struct maple_tree *mt, struct rcu_test_struct *vals)
 	MT_BUG_ON(mt, !vals->seen_entry3);
 	MT_BUG_ON(mt, !vals->seen_both);
 }
+
 static noinline void __init check_rcu_simulated(struct maple_tree *mt)
 {
 	unsigned long i, nr_entries = 1000;

-- 
2.50.1

