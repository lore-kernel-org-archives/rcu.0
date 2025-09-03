Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB0B301026
	for <rcu@vger.kernel.org>; Wed,  3 Sep 2025 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904442; cv=none; b=ZWRqxwKDFpwDka3Rk7aLPeydDimDaYeeQ7TaUeaPlgodLaQQtQJnAGrmaEvk80AlJXbqjitvGssWGFFxbHR6rRlI5/OyFESkukogW0reEuTYXbI8rJNbXPJobAFioRpEz4lsWz5jLQT88gFwCQ5YKZvByCd7LFZ9B4IoZ+e+IEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904442; c=relaxed/simple;
	bh=isKMO/oEHRqTdYv8cphz4X4oJvUf3JlTf8u3MNzeRuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pnr71KSvFMd97qkJoxn+fpIZu3qzHperyy+Yw/Lf+acTHRR7BagqOEN1lDFfOwzRD4UJlIKe124Z8UwLnyxtcnbHKDDIXw0TnX5ZkjbMnHu7vEI5WfSP1mRPZVCHZcOywvZhW0jmqQCIpubhjlsxt/hEnVvljFzZW2VRWAm3f5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xmlnP3KJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=N4++Wte7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xmlnP3KJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=N4++Wte7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xmlnP3KJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="N4++Wte7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xmlnP3KJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="N4++Wte7"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AEC901F745;
	Wed,  3 Sep 2025 13:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756904410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8VowGBFfDXG/GD85vj37Bupo+CslYBKF/PIHnrFTIo=;
	b=xmlnP3KJzd9cpQ2KM9zzpkXW/WInltLBBIOx1WWqZstmEQ8zlGEsKFADxRv2DWWqhVy+g7
	bH6hbWOVsz1cZLixljP1tJxgbpWYrX16+YFgN6UjjsXNaHGrhSrVHTYdM+v2zVQvWkGRf1
	2WBXlMwwIxcQZds6glBZ4JTZmCtNwBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756904410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8VowGBFfDXG/GD85vj37Bupo+CslYBKF/PIHnrFTIo=;
	b=N4++Wte7jeEZOXvrC75+VMaUkacqmOM3kfAzUKtfPmsg95/u4HsVUJSInm3u2ssLDRl2z/
	ZvUNnf7oZJOVtVBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xmlnP3KJ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=N4++Wte7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756904410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8VowGBFfDXG/GD85vj37Bupo+CslYBKF/PIHnrFTIo=;
	b=xmlnP3KJzd9cpQ2KM9zzpkXW/WInltLBBIOx1WWqZstmEQ8zlGEsKFADxRv2DWWqhVy+g7
	bH6hbWOVsz1cZLixljP1tJxgbpWYrX16+YFgN6UjjsXNaHGrhSrVHTYdM+v2zVQvWkGRf1
	2WBXlMwwIxcQZds6glBZ4JTZmCtNwBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756904410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8VowGBFfDXG/GD85vj37Bupo+CslYBKF/PIHnrFTIo=;
	b=N4++Wte7jeEZOXvrC75+VMaUkacqmOM3kfAzUKtfPmsg95/u4HsVUJSInm3u2ssLDRl2z/
	ZvUNnf7oZJOVtVBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB42D13B03;
	Wed,  3 Sep 2025 13:00:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +FNHNdk7uGitOAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 03 Sep 2025 13:00:09 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 03 Sep 2025 14:59:52 +0200
Subject: [PATCH v7 10/21] tools/testing/vma: Implement vm_refcnt reset
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-slub-percpu-caches-v7-10-71c114cdefef@suse.cz>
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
X-Spam-Flag: NO
X-Rspamd-Queue-Id: AEC901F745
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:mid,suse.cz:email,oracle.com:email]
X-Spam-Score: -4.51

From: "Liam R. Howlett" <Liam.Howlett@oracle.com>

Add the reset of the ref count in vma_lock_init().  This is needed if
the vma memory is not zeroed on allocation.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 tools/testing/vma/vma_internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 3639aa8dd2b06ebe5b9cfcfe6669994fd38c482d..2f1c586400cfd65413d2ff82199590b43796b18c 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -1418,8 +1418,8 @@ static inline void ksm_exit(struct mm_struct *mm)
 
 static inline void vma_lock_init(struct vm_area_struct *vma, bool reset_refcnt)
 {
-	(void)vma;
-	(void)reset_refcnt;
+	if (reset_refcnt)
+		refcount_set(&vma->vm_refcnt, 0);
 }
 
 static inline void vma_numab_state_init(struct vm_area_struct *vma)

-- 
2.51.0

