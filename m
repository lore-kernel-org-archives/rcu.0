Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07399304BA6
	for <rcu@vger.kernel.org>; Wed,  3 Sep 2025 13:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904469; cv=none; b=gojfO+WYM5qbUosxg7S7Y/SQXBNRrjg0Gi8L0pdYdRBKMsomk6d+6wxpUEvmnxAnNyO0LHiJQCMG0DagnPUr8yGHb56XgrnB+vmfXghyOO3bYsKZdxc5RI+9aVJW0Q/4PktHoeEypfUWssxlURmAcoo+JHwKJQrfh3wgXwN/VJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904469; c=relaxed/simple;
	bh=OcjndUE8gaQOpDzBjlFgvhR58KrlDl0vH/GNTgWNlFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E4U97xOImPF4aht/gW/Mn7Rds7ISmutI3mGNj2Ryu0hDhV0LaBqAiuUxIhCfANOiSJm5xRAU5eqXTl9vldWmgLtRUKoJ1MbcLGp/lY6FOySDVXF6045NbjQpabrSJRAmUvBk3uDXLPJatDWj9KBvsB13Q5IUOR2bPuZJR45zwPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=g/crOFhD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+sVatJLy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=g/crOFhD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+sVatJLy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="g/crOFhD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+sVatJLy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="g/crOFhD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+sVatJLy"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CDB631F747;
	Wed,  3 Sep 2025 13:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756904410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oVt3cZeiI6R/GA6oApyVXQ+OhlrdalPHGhvrN43p2wQ=;
	b=g/crOFhD4na0C8rkDfdx8cUVpPT9jg4mfQfUrEEG4AJVIvPjBSHqVuQMjx53jybGO8wQv1
	DWgjWKKW0nkBALpU4bUzjCI3zEvlwoWuUoE/GApq97pTKowgtq9dqLM59Kh0Ov/9ySkgTY
	CFgYJ/oUj4EsO0+gbZKWXeBV7c/nkaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756904410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oVt3cZeiI6R/GA6oApyVXQ+OhlrdalPHGhvrN43p2wQ=;
	b=+sVatJLyO7r62pCDRCB73fRH3sZeAriIa9SwQJzFj/GY9Z4x+DyRR3hpk8Usdnb5CGo5as
	RkaYUntMqWg2EMAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756904410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oVt3cZeiI6R/GA6oApyVXQ+OhlrdalPHGhvrN43p2wQ=;
	b=g/crOFhD4na0C8rkDfdx8cUVpPT9jg4mfQfUrEEG4AJVIvPjBSHqVuQMjx53jybGO8wQv1
	DWgjWKKW0nkBALpU4bUzjCI3zEvlwoWuUoE/GApq97pTKowgtq9dqLM59Kh0Ov/9ySkgTY
	CFgYJ/oUj4EsO0+gbZKWXeBV7c/nkaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756904410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oVt3cZeiI6R/GA6oApyVXQ+OhlrdalPHGhvrN43p2wQ=;
	b=+sVatJLyO7r62pCDRCB73fRH3sZeAriIa9SwQJzFj/GY9Z4x+DyRR3hpk8Usdnb5CGo5as
	RkaYUntMqWg2EMAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29A3313B06;
	Wed,  3 Sep 2025 13:00:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GEjhCdo7uGitOAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 03 Sep 2025 13:00:10 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 03 Sep 2025 14:59:55 +0200
Subject: [PATCH v7 13/21] maple_tree: use percpu sheaves for
 maple_node_cache
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-slub-percpu-caches-v7-13-71c114cdefef@suse.cz>
References: <20250903-slub-percpu-caches-v7-0-71c114cdefef@suse.cz>
In-Reply-To: <20250903-slub-percpu-caches-v7-0-71c114cdefef@suse.cz>
To: Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
 Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 maple-tree@lists.infradead.org, vbabka@suse.cz
X-Mailer: b4 0.14.2
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,oracle.com,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,suse.cz];
	R_RATELIMIT(0.00)[to_ip_from(RLwn5r54y1cp81no5tmbbew5oc)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid,oracle.com:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30

Setup the maple_node_cache with percpu sheaves of size 32 to hopefully
improve its performance. Note this will not immediately take advantage
of sheaf batching of kfree_rcu() operations due to the maple tree using
call_rcu with custom callbacks. The followup changes to maple tree will
change that and also make use of the prefilled sheaves functionality.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 lib/maple_tree.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index b4ee2d29d7a962ca374467d0533185f2db3d35ff..a0db6bdc63793b8bbd544e246391d99e880dede3 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6302,9 +6302,14 @@ bool mas_nomem(struct ma_state *mas, gfp_t gfp)
 
 void __init maple_tree_init(void)
 {
+	struct kmem_cache_args args = {
+		.align  = sizeof(struct maple_node),
+		.sheaf_capacity = 32,
+	};
+
 	maple_node_cache = kmem_cache_create("maple_node",
-			sizeof(struct maple_node), sizeof(struct maple_node),
-			SLAB_PANIC, NULL);
+			sizeof(struct maple_node), &args,
+			SLAB_PANIC);
 }
 
 /**

-- 
2.51.0

