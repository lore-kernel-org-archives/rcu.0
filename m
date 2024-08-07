Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798511DF685;
	Wed,  7 Aug 2024 10:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723026707; cv=none; b=m3DtGsdiN4bl1QciXcMx6gXTLS6fNsh5CXXFnOX0Tgkex2sixYOodNquOKx4lNYG6o4x7CQ9i0F32ysxBEkSsCK89DO5dNxMWkebhUzyA2SAvsfq0c/NV5Yj8i/SG/li1MQa4bkQvXg1IATYs71RYYMeYLnRV1EPA8LbWDpqpAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723026707; c=relaxed/simple;
	bh=2NlTIsOxItqB2jzIp/5ureCC+QPO7m/8hI7FlxJyvaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IFanHHsC+pNU0Et8LWji7c3apGCD0i7zG+wCQGjJM6v0a7k640CaBsW77DYbV5WQHHPAJ8ZVcG/ZUclFcG5LqDw+GM86XmZETctoTAR6oJ1/5N/05mTwbYZQ/aQgqma+pgIt5npwAmoIVDgM8+SplQonYezMps0/S+fazIvLaFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YxdH1qXX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vcYRtDmt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YxdH1qXX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vcYRtDmt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YxdH1qXX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vcYRtDmt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YxdH1qXX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vcYRtDmt"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E058D21CF8;
	Wed,  7 Aug 2024 10:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723026694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EuVEO95mFBgy7A/J87dAp3t2Ac0+1I7QV5k30Rj6i0c=;
	b=YxdH1qXXixOjsSeR7XWT4mVBgYw4MIKJRlJPn8+9DEcB6Id7ZeJsf7jAwmIrUe7B8qslDX
	bthEONOthVa1Xs1o94b4bcxHgWYltEAlagcBW8TgQ3hAxh7q9f1O6z7+zQPBKwnmVERAN+
	hGQP+DOXciuO6o3OurjuOca8b7YiLNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723026694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EuVEO95mFBgy7A/J87dAp3t2Ac0+1I7QV5k30Rj6i0c=;
	b=vcYRtDmtYJYHVbuFcRFhhOq63pzn8Due2/K0avtWel9EtUI2XCebywtWT+rafw8fajSUJz
	29BVY9NHSqgED0DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723026694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EuVEO95mFBgy7A/J87dAp3t2Ac0+1I7QV5k30Rj6i0c=;
	b=YxdH1qXXixOjsSeR7XWT4mVBgYw4MIKJRlJPn8+9DEcB6Id7ZeJsf7jAwmIrUe7B8qslDX
	bthEONOthVa1Xs1o94b4bcxHgWYltEAlagcBW8TgQ3hAxh7q9f1O6z7+zQPBKwnmVERAN+
	hGQP+DOXciuO6o3OurjuOca8b7YiLNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723026694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EuVEO95mFBgy7A/J87dAp3t2Ac0+1I7QV5k30Rj6i0c=;
	b=vcYRtDmtYJYHVbuFcRFhhOq63pzn8Due2/K0avtWel9EtUI2XCebywtWT+rafw8fajSUJz
	29BVY9NHSqgED0DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8837F13B0B;
	Wed,  7 Aug 2024 10:31:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kGj1IAZNs2YsHwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 07 Aug 2024 10:31:34 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 07 Aug 2024 12:31:20 +0200
Subject: [PATCH v2 7/7] kunit, slub: add test_kfree_rcu() and
 test_leak_destroy()
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240807-b4-slab-kfree_rcu-destroy-v2-7-ea79102f428c@suse.cz>
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
X-Spam-Flag: NO
X-Spam-Score: -2.80

Add a test that will create cache, allocate one object, kfree_rcu() it
and attempt to destroy it. As long as the usage of kvfree_rcu_barrier()
in kmem_cache_destroy() works correctly, there should be no warnings in
dmesg and the test should pass.

Additionally add a test_leak_destroy() test that leaks an object on
purpose and verifies that kmem_cache_destroy() catches it.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 lib/slub_kunit.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
index e6667a28c014..6e3a1e5a7142 100644
--- a/lib/slub_kunit.c
+++ b/lib/slub_kunit.c
@@ -5,6 +5,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/rcupdate.h>
 #include "../mm/slab.h"
 
 static struct kunit_resource resource;
@@ -157,6 +158,34 @@ static void test_kmalloc_redzone_access(struct kunit *test)
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
+	kfree_rcu(p, rcu);
+	kmem_cache_destroy(s);
+
+	KUNIT_EXPECT_EQ(test, 0, slab_errors);
+}
+
+static void test_leak_destroy(struct kunit *test)
+{
+	struct kmem_cache *s = test_kmem_cache_create("TestSlub_kfree_rcu",
+							64, SLAB_NO_MERGE);
+	kmem_cache_alloc(s, GFP_KERNEL);
+
+	kmem_cache_destroy(s);
+
+	KUNIT_EXPECT_EQ(test, 1, slab_errors);
+}
+
 static int test_init(struct kunit *test)
 {
 	slab_errors = 0;
@@ -177,6 +206,8 @@ static struct kunit_case test_cases[] = {
 
 	KUNIT_CASE(test_clobber_redzone_free),
 	KUNIT_CASE(test_kmalloc_redzone_access),
+	KUNIT_CASE(test_kfree_rcu),
+	KUNIT_CASE(test_leak_destroy),
 	{}
 };
 

-- 
2.46.0

