Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF6615491;
	Mon, 15 Jul 2024 20:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721075382; cv=none; b=mtHJv3EbqDBPpjjafTCv9rckQ/+BzJI4zRU+MWt8YrbfTAwwFIH4ugNUqbgW7tOdHnaOGA9sSSUiqv45USCyEgQ6z/urAKVkFPvvF1/jYqiH5N7aF73j6QhljdM7r11u2uf05TEmv1yl0HWldzPsyUhSs/QZjL5P611yVkz9eBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721075382; c=relaxed/simple;
	bh=XXQMOkIX+VJkP/xOnGSxQ+KYecbSwprT4Vo/S1Zu5hQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l70eZ8b++Vv5YY9pZQ2xSjWL/SwehyApcugz346AXymUHHfUxlcZ89YDCwPNvte7xsY2Nr3sE10E8upNsYn734kQ9wIJTec06iythiNTclhczID8jUc+anubQ5o9uuMTUx8heHmh8+X4grFbZXsu++i/cssBFD55GNacSN+XNpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IchGYqVK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=evMTmCrr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IchGYqVK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=evMTmCrr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IchGYqVK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="evMTmCrr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IchGYqVK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="evMTmCrr"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BA01B210F6;
	Mon, 15 Jul 2024 20:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721075378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=63ptlEDSf2NF4mqHOwhlrxuC2a4rLEbYrta5gvgyEc0=;
	b=IchGYqVKTSTLgxc6iItiNxB8xYcgyho9SGEIHdG4AvGblPLUEGncmz+QAw9gCZeuYszYBo
	hDpm2S4wepd1ry/XsrtRiysjqoo2aldpOROpoUxAii8f9lIRXpgYcd3Oh+mmqeLWCu2J2D
	eXC1GfxqvuZMh8bTQhOMVpnEuPoDI3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721075378;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=63ptlEDSf2NF4mqHOwhlrxuC2a4rLEbYrta5gvgyEc0=;
	b=evMTmCrrFOKvt+r76bJUkmHSGlLuXlmEdht9Fxt/VkvV8cIaoVObsQSvRCCjheyDPipECt
	Snp+IvBW3laNcQCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721075378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=63ptlEDSf2NF4mqHOwhlrxuC2a4rLEbYrta5gvgyEc0=;
	b=IchGYqVKTSTLgxc6iItiNxB8xYcgyho9SGEIHdG4AvGblPLUEGncmz+QAw9gCZeuYszYBo
	hDpm2S4wepd1ry/XsrtRiysjqoo2aldpOROpoUxAii8f9lIRXpgYcd3Oh+mmqeLWCu2J2D
	eXC1GfxqvuZMh8bTQhOMVpnEuPoDI3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721075378;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=63ptlEDSf2NF4mqHOwhlrxuC2a4rLEbYrta5gvgyEc0=;
	b=evMTmCrrFOKvt+r76bJUkmHSGlLuXlmEdht9Fxt/VkvV8cIaoVObsQSvRCCjheyDPipECt
	Snp+IvBW3laNcQCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 979351395F;
	Mon, 15 Jul 2024 20:29:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6Em9JLKGlWbvUwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 15 Jul 2024 20:29:38 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 15 Jul 2024 22:29:27 +0200
Subject: [PATCH RFC 1/6] mm, slab: make caches with refcount of 0
 unmergeable
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-b4-slab-kfree_rcu-destroy-v1-1-46b2984c2205@suse.cz>
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
X-Spam-Flag: NO
X-Spam-Score: 1.20
X-Spamd-Result: default: False [1.20 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,joelfernandes.org,joshtriplett.org,gmail.com,linux.com,google.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[goodmis.org,efficios.com,gmail.com,inria.fr,kernel.org,zx2c4.com,linux-foundation.org,linux.dev,kvack.org,vger.kernel.org,suse.cz];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: *

Slab caches with refcount 0 are in the process of being destroyed so
it's undesirable for new caches to attempt merging with them. A
synchronous destruction happens under slab_mutex thus excluding
concurrent cache creation and merging. Full destruction of
SLAB_TYPESAFE_BY_RCU caches might be delayed, but the cache is still
taken off the slab_caches list immediately, thus unreachable by cache
creation.

However a cache where __kmem_cache_shutdown() fails because it contains
objects that were not freed (due to a bug in the cache user) will be
left on the slab_caches list and might be considered for merging.
Also the following patches will introduce a possibility of a cache with
refcount 0 being temporarily reachable on the slab_list even in case of
no bugs, due to kfree_rcu() in flight.

For these reasons, prevent merging with caches that have zero refcount.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab_common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 70943a4c1c4b..3ba205bda95d 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -150,9 +150,11 @@ int slab_unmergeable(struct kmem_cache *s)
 #endif
 
 	/*
-	 * We may have set a slab to be unmergeable during bootstrap.
+	 * We may have set a cache to be unmergeable (-1) during bootstrap.
+	 * 0 is for cache being destroyed asynchronously, or cache that failed
+	 * to destroy due to outstanding objects.
 	 */
-	if (s->refcount < 0)
+	if (s->refcount <= 0)
 		return 1;
 
 	return 0;

-- 
2.45.2

