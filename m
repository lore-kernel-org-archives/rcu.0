Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C250C3148A8
	for <rcu@vger.kernel.org>; Wed, 10 Sep 2025 08:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491332; cv=none; b=Zh4VA05UzldOk/htNpERDXNgyjicnWgolX3t9pRlhFrSBLNbgWYg6R6nGH0NXDfwM/ukvtlXiChx3QJA92chPQfd6pE1wNH41uW7fz8Aj248AGph3JYreBoN0RFXwNRC//jU8AMzEjxBqf9t4REdk88eKEHeqk8UxEJPsqRnEM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491332; c=relaxed/simple;
	bh=FINhSf1K8oG3NyvpCAz8PnZ+wOCcUWskrNLcKXQDC68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PKprPlSgNz8JWnyd3iVcqZuOVpQIkT4kFELgHM7I1DGEeEvxG3zzVcAkZwOGMXITe+Q2oPHGHigxDmZegSQrna8KJe4S9HDwjoTcCy5atZ2k2bXqSU92pDAbgOBaWMkZaWtEeqrRfJAOWohDrYekr74ql8sPr8mISPjr9mszgmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LodN7bzu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+Y1JntXq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LodN7bzu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+Y1JntXq"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2AC845CAE7;
	Wed, 10 Sep 2025 08:01:07 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757491267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dlC5rsgvDhfAffIlycTkJFaG9lSl4Vf5QxNcsetL14c=;
	b=LodN7bzutE7Li/V2EfwBNo4CuHvBVnPrKn7N0CJHxkP6oZ+sCh0VtaNamgRGLIEbFtrTwE
	dqoK3vZjGYZGlxgQbI3hFtniCG7KYYOmMENRmFlAPyfSHh/S7FPOKdp4qEN3Vb5EMXCcDy
	SFOg5lKQvKf9w2qVLXoVh65hgGJguOM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757491267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dlC5rsgvDhfAffIlycTkJFaG9lSl4Vf5QxNcsetL14c=;
	b=+Y1JntXqx0cxt+zFArNgueEShnHg/9pKpuK+RXieCuu5zrPcCctkmAIBa1hgYTY57coLkV
	gn4XLtuRcRGskUAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6605D13AFB;
	Wed, 10 Sep 2025 08:01:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OACgGEIwwWgGJAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 10 Sep 2025 08:01:06 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 10 Sep 2025 10:01:11 +0200
Subject: [PATCH v8 09/23] maple_tree: remove redundant __GFP_NOWARN
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-slub-percpu-caches-v8-9-ca3099d8352c@suse.cz>
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
 Qianfeng Rong <rongqianfeng@vivo.com>, Wei Yang <richard.weiyang@gmail.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>
X-Mailer: b4 0.14.2
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[];
	R_RATELIMIT(0.00)[to(RL941jgdop1fyjkq8h4),to_ip_from(RLfsjnp7neds983g95ihcnuzgq)]
X-Rspamd-Queue-Id: 2AC845CAE7
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00

From: Qianfeng Rong <rongqianfeng@vivo.com>

Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT") made
GFP_NOWAIT implicitly include __GFP_NOWARN.

Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT (e.g.,
`GFP_NOWAIT | __GFP_NOWARN`) is now redundant.  Let's clean up these
redundant flags across subsystems.

No functional changes.

Link: https://lkml.kernel.org/r/20250804125657.482109-1-rongqianfeng@vivo.com
Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 lib/maple_tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index b4ee2d29d7a962ca374467d0533185f2db3d35ff..38fb68c082915211c80f473d313159599fe97e2c 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1344,11 +1344,11 @@ static void mas_node_count_gfp(struct ma_state *mas, int count, gfp_t gfp)
  * @mas: The maple state
  * @count: The number of nodes needed
  *
- * Note: Uses GFP_NOWAIT | __GFP_NOWARN for gfp flags.
+ * Note: Uses GFP_NOWAIT for gfp flags.
  */
 static void mas_node_count(struct ma_state *mas, int count)
 {
-	return mas_node_count_gfp(mas, count, GFP_NOWAIT | __GFP_NOWARN);
+	return mas_node_count_gfp(mas, count, GFP_NOWAIT);
 }
 
 /*

-- 
2.51.0

