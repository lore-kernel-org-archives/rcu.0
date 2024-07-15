Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CE613AD29;
	Mon, 15 Jul 2024 20:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721075384; cv=none; b=fXkoqfN1Zus7L70S9EV4vnR1KXOgqsKuibwACWTOIYKXa0X062+covc1uhIsyPSWTlvQNp6AMkoRzVgdeaTrvBWn1/fQlI6jTmo7ZjGjK+NPuVDX6E406F91BjQQslBxaJG37X1wRxF22jI8fwqLeDWr0GtTZCGFia0IyvG9Hto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721075384; c=relaxed/simple;
	bh=pEZhyYNs5WAL93I3RCTnKrlUfIydbtryCuiay7Vw+G8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I4B4rVkNZHcGD2/5FvqenEvNnOfa2AXSsucZwFv2s1tksveINxNUpvBPjA4P6LYZnE6PPLTzzqKca4gfa0jB4g1q9eqRQd0TvXqP5WwE7FqzRWZvktx4o5NatCVZnLx2CaGMIyeMCI8626UV0Pk+BT/riF+4pX+s1BBt/MW1Nos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=prIKxLzt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aE2aSMpu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=prIKxLzt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aE2aSMpu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="prIKxLzt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aE2aSMpu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="prIKxLzt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aE2aSMpu"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5119A21BD0;
	Mon, 15 Jul 2024 20:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721075379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yWewRUcOUAtVmN4JR7Gtyt2MolU1IAn0Ns4fcy6NIVg=;
	b=prIKxLztGfLbdeAhqgcoCK1H8//juWuOKqdI91X4l4EJajX8iU9dBgUIGHI3oTtT90n1En
	fQg+/C1t4mT5ErXDMfBha2YRuPoew0wPFfBnkeYyzXsLYW1WxkU/p8BRc1tUfOWDsSWGWn
	HpwOqvdETyGUnPP9tPNEBEpZKg2A9ro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721075379;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yWewRUcOUAtVmN4JR7Gtyt2MolU1IAn0Ns4fcy6NIVg=;
	b=aE2aSMpuuGQWpz2WP9mQoUBD+DMuFoYlFRvPk5ajs9R0pwV7ByK+B24CBCTjYYCEhB3Ue/
	/BDr04RNGcmpkdCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=prIKxLzt;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=aE2aSMpu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721075379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yWewRUcOUAtVmN4JR7Gtyt2MolU1IAn0Ns4fcy6NIVg=;
	b=prIKxLztGfLbdeAhqgcoCK1H8//juWuOKqdI91X4l4EJajX8iU9dBgUIGHI3oTtT90n1En
	fQg+/C1t4mT5ErXDMfBha2YRuPoew0wPFfBnkeYyzXsLYW1WxkU/p8BRc1tUfOWDsSWGWn
	HpwOqvdETyGUnPP9tPNEBEpZKg2A9ro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721075379;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yWewRUcOUAtVmN4JR7Gtyt2MolU1IAn0Ns4fcy6NIVg=;
	b=aE2aSMpuuGQWpz2WP9mQoUBD+DMuFoYlFRvPk5ajs9R0pwV7ByK+B24CBCTjYYCEhB3Ue/
	/BDr04RNGcmpkdCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31A361396E;
	Mon, 15 Jul 2024 20:29:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0NDVC7OGlWbvUwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 15 Jul 2024 20:29:39 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 15 Jul 2024 22:29:32 +0200
Subject: [PATCH RFC 6/6] kunit, slub: add test_kfree_rcu()
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-b4-slab-kfree_rcu-destroy-v1-6-46b2984c2205@suse.cz>
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
X-Rspamd-Queue-Id: 5119A21BD0
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

Add a test that will create cache, allocate one object, kfree_rcu() it
and attempt to destroy it. If the asynchronous cache freeing works
correctly, there should be no warnings in dmesg.

Since the warnings in the failure case are produced by a work callback,
I don't know if it's possible to capture it in the kunit test result
properly.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 lib/slub_kunit.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
index e6667a28c014..e3e4d0ca40b7 100644
--- a/lib/slub_kunit.c
+++ b/lib/slub_kunit.c
@@ -5,6 +5,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/rcupdate.h>
 #include "../mm/slab.h"
 
 static struct kunit_resource resource;
@@ -157,6 +158,26 @@ static void test_kmalloc_redzone_access(struct kunit *test)
 	kmem_cache_destroy(s);
 }
 
+struct test_kfree_rcu_struct {
+	struct rcu_head rcu;
+};
+
+static void test_kfree_rcu(struct kunit *test)
+{
+	struct kmem_cache *s = test_kmem_cache_create("TestSlub_kfree_rcu",
+				sizeof(struct test_kfree_rcu_struct),
+				SLAB_NO_MERGE);
+	struct test_kfree_rcu_struct *p = kmem_cache_alloc(s, GFP_KERNEL);
+
+	kasan_disable_current();
+
+	KUNIT_EXPECT_EQ(test, 0, slab_errors);
+
+	kasan_enable_current();
+	kfree_rcu(p, rcu);
+	kmem_cache_destroy(s);
+}
+
 static int test_init(struct kunit *test)
 {
 	slab_errors = 0;
@@ -177,6 +198,7 @@ static struct kunit_case test_cases[] = {
 
 	KUNIT_CASE(test_clobber_redzone_free),
 	KUNIT_CASE(test_kmalloc_redzone_access),
+	KUNIT_CASE(test_kfree_rcu),
 	{}
 };
 

-- 
2.45.2

