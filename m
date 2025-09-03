Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE6F3002A3
	for <rcu@vger.kernel.org>; Wed,  3 Sep 2025 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904460; cv=none; b=htyyB38r9td2dnkf7fLjIR18/OjBFOCDakgHipDgMRAmffWAgdVad9sQPK7OYc8tb0nTCxi3Wk3ijdemAK5NbCY92cCbP1B5cmcWTezEYk0LQkLGg7KzIre3QC++66Qv4J0CQb2WqixqDq9GIPusmu2eLoFfxGo04HwdyEdfUW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904460; c=relaxed/simple;
	bh=SNS9mPclBWDQTLp0gzNlmhMRdVlMkCqS+zQlMmESaHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hf5AFG8L+WdJCA/KnHItBhFCL9Vq2uMj2KxJfkZJ7VIyEFt3GAm106130IdrRe1L9DFjxgq4wlhJi3y8ZBwCOp71c0EJIgA4D88EPc2sp2ZLYnJGT6I4z/euYTW3qKf+oCsyTrPEErghqu+uegrZZMhHowewLqS9yS+PRDTnEYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=omytXGUa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/uLDg7Ai; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=omytXGUa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/uLDg7Ai; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="omytXGUa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/uLDg7Ai";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="omytXGUa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/uLDg7Ai"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7FF9B1F46E;
	Wed,  3 Sep 2025 13:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756904410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=04FJ6mdlY7gFitpo8K6WI1BZw3Xwifvtp3g2IfjcN5g=;
	b=omytXGUab1APokv8IgrliU7EEnaR7rjmj689H5mwTxRcyC+zLjitLaAQcuqSM2LSvMeUSx
	6IhI/bsfGSdYNop32O25YDh5nnEOUk4MKjKPcF9s9Gx1fEQ83wc/8mCjZ70h1Q5NAQFyc1
	VaRLZxprUijo2uRFllSgCyocBoC6jqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756904410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=04FJ6mdlY7gFitpo8K6WI1BZw3Xwifvtp3g2IfjcN5g=;
	b=/uLDg7Aimp53izI7djRGz4dVIz4AAglWuPzXAwP4GzKBPMdo6k5EC7X96oW4P/aSDpKlqS
	xsDJJe7apmqrTYAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756904410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=04FJ6mdlY7gFitpo8K6WI1BZw3Xwifvtp3g2IfjcN5g=;
	b=omytXGUab1APokv8IgrliU7EEnaR7rjmj689H5mwTxRcyC+zLjitLaAQcuqSM2LSvMeUSx
	6IhI/bsfGSdYNop32O25YDh5nnEOUk4MKjKPcF9s9Gx1fEQ83wc/8mCjZ70h1Q5NAQFyc1
	VaRLZxprUijo2uRFllSgCyocBoC6jqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756904410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=04FJ6mdlY7gFitpo8K6WI1BZw3Xwifvtp3g2IfjcN5g=;
	b=/uLDg7Aimp53izI7djRGz4dVIz4AAglWuPzXAwP4GzKBPMdo6k5EC7X96oW4P/aSDpKlqS
	xsDJJe7apmqrTYAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C7F6C13B02;
	Wed,  3 Sep 2025 13:00:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4PaJMNk7uGitOAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 03 Sep 2025 13:00:09 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 03 Sep 2025 14:59:51 +0200
Subject: [PATCH v7 09/21] tools/testing/maple_tree: Fix
 check_bulk_rebalance() locks
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-slub-percpu-caches-v7-9-71c114cdefef@suse.cz>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,oracle.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

From: "Liam R. Howlett" <Liam.Howlett@oracle.com>

The check_bulk_rebalance() test was not correctly locking the tree which
caused issues with the sheaves testing in later patches.  Adding the
missing locks fixed the issue.

Fixes: a6e0ceb7bf48 ("maple_tree: check for MA_STATE_BULK on setting wr_rebalance")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 tools/testing/radix-tree/maple.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 172700fb7784d29f9403003b4484a5ebd7aa316b..159d5307b30a4b37e6cf2941848b8718e1b891d9 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -36465,6 +36465,7 @@ static inline void check_bulk_rebalance(struct maple_tree *mt)
 
 	build_full_tree(mt, 0, 2);
 
+	mas_lock(&mas);
 	/* erase every entry in the tree */
 	do {
 		/* set up bulk store mode */
@@ -36474,6 +36475,7 @@ static inline void check_bulk_rebalance(struct maple_tree *mt)
 	} while (mas_prev(&mas, 0) != NULL);
 
 	mas_destroy(&mas);
+	mas_unlock(&mas);
 }
 
 void farmer_tests(void)

-- 
2.51.0

