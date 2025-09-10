Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155C7311C05
	for <rcu@vger.kernel.org>; Wed, 10 Sep 2025 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491305; cv=none; b=VKo/MllJTuoDMzwLjUol24bvYVw6GiRARE5/V+WKgn8yBVQfLs8S5YdqY5hHhAklxTBQjtT2vk0sZCQZdgw6uVzSjn9iI46geNmbKqOQSy7uL48sAURlVFBex0vzqUWZyetnEOlZue96uOYzJmo373O9WIx79BuP7+jQgEI4Yz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491305; c=relaxed/simple;
	bh=8zhwdOkNAvH6snya/EkLPN9kkVJJEEo+XjxQ5KsrJ7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p/YtPchMb+AVNNP72aIskqC/ypJvqHSdlOEITaC233LF+cuO7bOBeW87brwVck/If0uoUgDn/9NECqZLxA608m4fkjEVpz3MrL/54flddStpJIl+IAXsqapM8fKReAziIysoLT4bEusxqsf1RNVv0ZTim3uQgIjdegSacOY7+Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YPw5IO+o; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sgSvKRdD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YPw5IO+o; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sgSvKRdD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YPw5IO+o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sgSvKRdD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YPw5IO+o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sgSvKRdD"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5304A5CB34;
	Wed, 10 Sep 2025 08:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757491267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JknvsOxfmdGK99z5Y7Du3/KRq6UYdu6X7lKlwYsXCV8=;
	b=YPw5IO+oJdz5rFhGGiXcLxntBg4dQtv/AZfDa58nfUW0pulrlTBA78HLoJ8DalVdbjN3AJ
	C0egF1mCnxK3hEeFFci2DMnofdQigpmjOllksLUOJifn1F9oZDsgEoSbaLzbMkhxOmzqkE
	fcLhoNGshkR+ZB083dHYP3RKv71CQ98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757491267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JknvsOxfmdGK99z5Y7Du3/KRq6UYdu6X7lKlwYsXCV8=;
	b=sgSvKRdDq2XsiiXk/7Crr8DG5iWigMyXMXUcR0U8vCxpaJ7jxU3b7OtFGpoLxNh6s3912i
	WhVESaxaLatiyjAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757491267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JknvsOxfmdGK99z5Y7Du3/KRq6UYdu6X7lKlwYsXCV8=;
	b=YPw5IO+oJdz5rFhGGiXcLxntBg4dQtv/AZfDa58nfUW0pulrlTBA78HLoJ8DalVdbjN3AJ
	C0egF1mCnxK3hEeFFci2DMnofdQigpmjOllksLUOJifn1F9oZDsgEoSbaLzbMkhxOmzqkE
	fcLhoNGshkR+ZB083dHYP3RKv71CQ98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757491267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JknvsOxfmdGK99z5Y7Du3/KRq6UYdu6X7lKlwYsXCV8=;
	b=sgSvKRdDq2XsiiXk/7Crr8DG5iWigMyXMXUcR0U8vCxpaJ7jxU3b7OtFGpoLxNh6s3912i
	WhVESaxaLatiyjAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2542513A54;
	Wed, 10 Sep 2025 08:01:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wLDRCEMwwWgGJAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 10 Sep 2025 08:01:07 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 10 Sep 2025 10:01:19 +0200
Subject: [PATCH v8 17/23] testing/radix-tree/maple: Hack around kfree_rcu
 not existing
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-slub-percpu-caches-v8-17-ca3099d8352c@suse.cz>
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
In-Reply-To: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
To: Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
 Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 maple-tree@lists.infradead.org, vbabka@suse.cz, 
 Pedro Falcato <pfalcato@suse.de>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,oracle.com,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,suse.cz,suse.de];
	R_RATELIMIT(0.00)[to_ip_from(RLwn5r54y1cp81no5tmbbew5oc)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.cz:mid,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

From: "Liam R. Howlett" <Liam.Howlett@oracle.com>

liburcu doesn't have kfree_rcu (or anything similar). Despite that, we
can hack around it in a trivial fashion, by adding a wrapper.

The wrapper only works for maple_nodes because we cannot get the
kmem_cache pointer any other way in the test code.

Link: https://lore.kernel.org/all/20250812162124.59417-1-pfalcato@suse.de/
Suggested-by: Pedro Falcato <pfalcato@suse.de>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 tools/testing/shared/maple-shared.h | 11 +++++++++++
 tools/testing/shared/maple-shim.c   |  6 ++++++
 2 files changed, 17 insertions(+)

diff --git a/tools/testing/shared/maple-shared.h b/tools/testing/shared/maple-shared.h
index dc4d30f3860b9bd23b4177c7d7926ac686887815..2a1e9a8594a2834326cd9374738b2a2c7c3f9f7c 100644
--- a/tools/testing/shared/maple-shared.h
+++ b/tools/testing/shared/maple-shared.h
@@ -10,4 +10,15 @@
 #include <time.h>
 #include "linux/init.h"
 
+void maple_rcu_cb(struct rcu_head *head);
+#define rcu_cb		maple_rcu_cb
+
+#define kfree_rcu(_struct, _memb)		\
+do {                                            \
+    typeof(_struct) _p_struct = (_struct);      \
+                                                \
+    call_rcu(&((_p_struct)->_memb), rcu_cb);    \
+} while(0);
+
+
 #endif /* __MAPLE_SHARED_H__ */
diff --git a/tools/testing/shared/maple-shim.c b/tools/testing/shared/maple-shim.c
index 9d7b743415660305416e972fa75b56824211b0eb..16252ee616c0489c80490ff25b8d255427bf9fdc 100644
--- a/tools/testing/shared/maple-shim.c
+++ b/tools/testing/shared/maple-shim.c
@@ -6,3 +6,9 @@
 #include <linux/slab.h>
 
 #include "../../../lib/maple_tree.c"
+
+void maple_rcu_cb(struct rcu_head *head) {
+	struct maple_node *node = container_of(head, struct maple_node, rcu);
+
+	kmem_cache_free(maple_node_cache, node);
+}

-- 
2.51.0

