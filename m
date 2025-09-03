Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC80307489
	for <rcu@vger.kernel.org>; Wed,  3 Sep 2025 13:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904479; cv=none; b=rSO9fBRhXW/oXbLkdiZD7OMxBrO1ud/VkOgrfem5aVNguW8LUf5qEXH7ozKAJ2n6eBOqbXf42G5cbzVobNfSkTjLYpYAZjeh+IbUZ6UE8CcBj8ptJ3MW40Yzu5pcOO0hW1KlxjwbizW80KQ8Piapy9zArcztbbn3fpvXOccklTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904479; c=relaxed/simple;
	bh=7O7Hz1Mts4IMOrx+TCnRt2ePdSfzexl/nOsXo91gEXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xfbn8XI8T1j9ql9mREBy8JEjy2+OpJgucEI3ZCZ1Fj3hgkbKsDN2REYYVf8EqAkeFC8fQ/bi8u669Z6LZ9fgqsFV093XCmJpno+/OZPH08bMCGHRxssmtW8GLEhVYUuPCWwwCjZWAwPU0exkC+9U+9pIEzJ02dz9WKTXiVssdQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UpE5aYpx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yG8ZP+1F; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UpE5aYpx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yG8ZP+1F; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UpE5aYpx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yG8ZP+1F";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UpE5aYpx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yG8ZP+1F"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D4CB52122B;
	Wed,  3 Sep 2025 13:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756904410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sL+qCDJGk4s8FKjAhsD7S3UX8bYd+2rVoRHmfBRAuDU=;
	b=UpE5aYpxnGAKCt1S0hrkBGoX0L860Cndg8O68gwLbljC5cpsm/uC7eKulYMEDJBOkwSt2e
	53g0APA9BXG6d149lzRi8S4oovaympDBz+GmQgHUqH4qkHbBotvbKmp05sxz6ERVZxUlJA
	0kZ/p2X06oWqU7MOOQIsmqhzAQ4oCkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756904410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sL+qCDJGk4s8FKjAhsD7S3UX8bYd+2rVoRHmfBRAuDU=;
	b=yG8ZP+1Fyl9iMw/IHXxgYX7BycvqdDO7RoSq2Beb8b1hmkpVGljEWuqK/WkC+IDrWxnFM+
	7najWcdnMm7jqWCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UpE5aYpx;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yG8ZP+1F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756904410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sL+qCDJGk4s8FKjAhsD7S3UX8bYd+2rVoRHmfBRAuDU=;
	b=UpE5aYpxnGAKCt1S0hrkBGoX0L860Cndg8O68gwLbljC5cpsm/uC7eKulYMEDJBOkwSt2e
	53g0APA9BXG6d149lzRi8S4oovaympDBz+GmQgHUqH4qkHbBotvbKmp05sxz6ERVZxUlJA
	0kZ/p2X06oWqU7MOOQIsmqhzAQ4oCkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756904410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sL+qCDJGk4s8FKjAhsD7S3UX8bYd+2rVoRHmfBRAuDU=;
	b=yG8ZP+1Fyl9iMw/IHXxgYX7BycvqdDO7RoSq2Beb8b1hmkpVGljEWuqK/WkC+IDrWxnFM+
	7najWcdnMm7jqWCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D9A913B07;
	Wed,  3 Sep 2025 13:00:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8BjFDto7uGitOAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 03 Sep 2025 13:00:10 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 03 Sep 2025 14:59:56 +0200
Subject: [PATCH v7 14/21] tools/testing: include maple-shim.c in maple.c
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-slub-percpu-caches-v7-14-71c114cdefef@suse.cz>
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
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux.dev,oracle.com,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,suse.cz];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RLfsjnp7neds983g95ihcnuzgq)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.cz:mid,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: D4CB52122B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

There's some duplicated code and we are about to add more functionality
in maple-shared.h that we will need in the userspace maple test to be
available, so include it via maple-shim.c

Co-developed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 tools/testing/radix-tree/maple.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 159d5307b30a4b37e6cf2941848b8718e1b891d9..7fe91f24849b35723ec6aadbe45ec7d2abedcc11 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -8,14 +8,6 @@
  * difficult to handle in kernel tests.
  */
 
-#define CONFIG_DEBUG_MAPLE_TREE
-#define CONFIG_MAPLE_SEARCH
-#define MAPLE_32BIT (MAPLE_NODE_SLOTS > 31)
-#include "test.h"
-#include <stdlib.h>
-#include <time.h>
-#include <linux/init.h>
-
 #define module_init(x)
 #define module_exit(x)
 #define MODULE_AUTHOR(x)
@@ -23,7 +15,9 @@
 #define MODULE_LICENSE(x)
 #define dump_stack()	assert(0)
 
-#include "../../../lib/maple_tree.c"
+#include "test.h"
+
+#include "../shared/maple-shim.c"
 #include "../../../lib/test_maple_tree.c"
 
 #define RCU_RANGE_COUNT 1000

-- 
2.51.0

