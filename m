Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3322030F7F1
	for <rcu@vger.kernel.org>; Wed, 10 Sep 2025 08:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491279; cv=none; b=KFOGiFPW8Fo1zs09bo95hhZhk7Jpgfl0FcexbvFu1gHsEiyVL/QCjOFpx4PXZ+deJD6yka3d3nPo/D3U0GTzif5R9V6UBhwkjkTHXPbEg1oetkgCPICtcjSCM89+Ys5h0pLq1F6oJxgFtBblzR/qojg/4nlTjlXsdxmaQgP2/Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491279; c=relaxed/simple;
	bh=qXPM1Ew8/JntXWuqVpN7a+OvhDZNQagk5/amz0MEe40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BgMHl+wGjzdJUAgZlxHN/+4B+tvwVUp1dOgdP0nZCxuPzYvGIXCbmdxk8Ypufg4FBntWRulYc453dgTDDSb3S999dymlpX4Kwp7Ai1KR88ykwK9kj3VPsELhHLWvmSyzehWN5Tq6B7H5aPojOqfmN+lJrwbKbJEEmAOAXJlskDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hn2urHv2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hH2gs4l0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hn2urHv2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hH2gs4l0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hn2urHv2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hH2gs4l0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hn2urHv2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hH2gs4l0"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4159D5CAF3;
	Wed, 10 Sep 2025 08:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757491267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rtSF476Ds9zbd6MrnqNt5+BMzWFkMQ3IyLGQJMUX73s=;
	b=hn2urHv2OiGDeG2e77bSB5GER9p4pdJ++ttQNeukFcxzmDTFL1R94/ETAf5iNKiSBwR+6x
	ZYkrNBrQDTlWBvyTDBzQhNjSR/WOnFyoSj0iyiuRMnsb1wIvmEfvLFUcAYSWx8KUF0+mEr
	SnI+RpORYz5Ma98hX+6mHa/6FVAo+PY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757491267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rtSF476Ds9zbd6MrnqNt5+BMzWFkMQ3IyLGQJMUX73s=;
	b=hH2gs4l0wjzny7y+HOMHTr+laUPULtcUp47P7if3WBPoc92+bHFc6mQ32QvuGbOkqQQk8a
	9cZ0vzGBTGKnyMBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hn2urHv2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hH2gs4l0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757491267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rtSF476Ds9zbd6MrnqNt5+BMzWFkMQ3IyLGQJMUX73s=;
	b=hn2urHv2OiGDeG2e77bSB5GER9p4pdJ++ttQNeukFcxzmDTFL1R94/ETAf5iNKiSBwR+6x
	ZYkrNBrQDTlWBvyTDBzQhNjSR/WOnFyoSj0iyiuRMnsb1wIvmEfvLFUcAYSWx8KUF0+mEr
	SnI+RpORYz5Ma98hX+6mHa/6FVAo+PY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757491267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rtSF476Ds9zbd6MrnqNt5+BMzWFkMQ3IyLGQJMUX73s=;
	b=hH2gs4l0wjzny7y+HOMHTr+laUPULtcUp47P7if3WBPoc92+bHFc6mQ32QvuGbOkqQQk8a
	9cZ0vzGBTGKnyMBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE4CF13B02;
	Wed, 10 Sep 2025 08:01:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2A5JKkIwwWgGJAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 10 Sep 2025 08:01:06 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 10 Sep 2025 10:01:14 +0200
Subject: [PATCH v8 12/23] tools/testing/vma: Implement vm_refcnt reset
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-slub-percpu-caches-v8-12-ca3099d8352c@suse.cz>
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
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 4159D5CAF3
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email]
X-Spam-Score: -4.51

From: "Liam R. Howlett" <Liam.Howlett@oracle.com>

Add the reset of the ref count in vma_lock_init().  This is needed if
the vma memory is not zeroed on allocation.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 tools/testing/vma/vma_internal.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index f8cf5b184d5b51dd627ff440943a7af3c549f482..6b6e2b05918c9f95b537f26e20a943b34082825a 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -1373,6 +1373,8 @@ static inline void ksm_exit(struct mm_struct *mm)
 
 static inline void vma_lock_init(struct vm_area_struct *vma, bool reset_refcnt)
 {
+	if (reset_refcnt)
+		refcount_set(&vma->vm_refcnt, 0);
 }
 
 static inline void vma_numab_state_init(struct vm_area_struct *vma)

-- 
2.51.0

