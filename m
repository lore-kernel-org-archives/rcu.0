Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C466F313532
	for <rcu@vger.kernel.org>; Wed, 10 Sep 2025 08:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491315; cv=none; b=aQSSzXflEVnNC4ePwU4gSPY2WEjL6PwekgwPLTq8wUtT6AIvf8YwWy8zPBKOkQwC0+GHfAkkXkXd5nOjmrQkY5hefj+qdNE+rvqqTZZHZ3eiow66oY6z8PLvfRioOC3MMuOUQ7srW0JmJxMltFRJ8c3oqrBunG0af0CgXSjsQd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491315; c=relaxed/simple;
	bh=IbW3Hwc2yVi+Ksjat79Bt0c8mqQegJtd4O77r1T6JHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f84xDbwI18ZOPFz7SatiI9bOezvxX3Nvu7hoeFsbREfn3fJbVuH/PSvE5ho1VqJ+z7utnqXIj29QlZSHNVf6Oa7rzjkU2Fd14peRxzUWzz+hBfK09YM8+HEcHymrLanldlEK1EMCUfrvNi7nkXSHlDxucMdY27Jd/gjBq87s2X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XOJHhG2v; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bhV8GnZN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XOJHhG2v; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bhV8GnZN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XOJHhG2v";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bhV8GnZN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XOJHhG2v";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bhV8GnZN"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 52F8B34C65;
	Wed, 10 Sep 2025 08:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757491267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yjD49SbUXnEu+0JzrLTF+521Hhj3syJQd2OSJQchv9c=;
	b=XOJHhG2vZC0MBDIR8MKa611bMkqdlds+kx5f2bVvAK7EafB0g36SkYhXp3kG8oqctrpgSV
	3M3EhLAgK6fqbyKh4Wq9YzldQn3iaG2tc7CXpjIPAlr3rQVNDOT0KH0cdLcWvU8Qdb0vk4
	wEGb4g3fR8/JvKoGU7VZM3eI7L3pjoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757491267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yjD49SbUXnEu+0JzrLTF+521Hhj3syJQd2OSJQchv9c=;
	b=bhV8GnZNs78mOmK/I+PAZDXMSRDwlJbqkgYKgIw7ozPEpkoL2S+VIXoYn6D9VO0Yo1w2fo
	vR9SeuVIChwey9BQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XOJHhG2v;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bhV8GnZN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757491267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yjD49SbUXnEu+0JzrLTF+521Hhj3syJQd2OSJQchv9c=;
	b=XOJHhG2vZC0MBDIR8MKa611bMkqdlds+kx5f2bVvAK7EafB0g36SkYhXp3kG8oqctrpgSV
	3M3EhLAgK6fqbyKh4Wq9YzldQn3iaG2tc7CXpjIPAlr3rQVNDOT0KH0cdLcWvU8Qdb0vk4
	wEGb4g3fR8/JvKoGU7VZM3eI7L3pjoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757491267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yjD49SbUXnEu+0JzrLTF+521Hhj3syJQd2OSJQchv9c=;
	b=bhV8GnZNs78mOmK/I+PAZDXMSRDwlJbqkgYKgIw7ozPEpkoL2S+VIXoYn6D9VO0Yo1w2fo
	vR9SeuVIChwey9BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1185313B06;
	Wed, 10 Sep 2025 08:01:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gK7/A0MwwWgGJAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 10 Sep 2025 08:01:07 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 10 Sep 2025 10:01:18 +0200
Subject: [PATCH v8 16/23] tools/testing: include maple-shim.c in maple.c
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-slub-percpu-caches-v8-16-ca3099d8352c@suse.cz>
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
In-Reply-To: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
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
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,oracle.com,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,suse.cz];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RLfsjnp7neds983g95ihcnuzgq)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 52F8B34C65
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
index c0543060dae2510477963331fb0ccdffd78ea965..4a35e1e7c64b7ce347cbd1693beeaacb0c4c330e 100644
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

