Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABA9267B6D
	for <rcu@vger.kernel.org>; Fri, 14 Feb 2025 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550484; cv=none; b=IhOpmGALQ6kVNFRC4rswuf0koFqojtgi4yabieCAx+OJFTVUF/gPs7zXaPscsAYK0qLzNkyzvqAwqNUMritfIlEQWDtUUoKUDT9J6iz6a4Qb3eFFoMOC/tQ5JnQN94aixEkwa4Zy3vmT+8rma/thh8OYK/e59e0ENzl9gNK1cKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550484; c=relaxed/simple;
	bh=GxAykvygZDwHr+rMyJeAGXj+HSWrHTHeqy5RzPvWngo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MaK/TzMSx6Z9FI7ZW97xW4wtQhxao6jg46wjiyH+jVUWYdKI6wQSeneeqeRXRuiISsKUJ0apjfZOHF4sEcpVkip6sTs2MfnszSMVQhAmGRBhrFEQpUcdEEXqPMfPqPC+/uvKCYOEvY+cUCn8+u62hO5JDbhfBX6MpPVBdqkKX3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=fail smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FpUnZ8Jw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FybShcH+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FpUnZ8Jw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FybShcH+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FpUnZ8Jw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FybShcH+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FpUnZ8Jw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FybShcH+"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B92C42117D;
	Fri, 14 Feb 2025 16:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739550462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GaCYe+OEwMyM/ciPR9cdhcr1JY5HT+u6CwMm73JcQ7Y=;
	b=FpUnZ8JwEuFAZsbEuF7Z15Lr/OVP5f2ut541wcsVGpno2oeEvbGcEQrP1ZFch3lFU2CKZN
	L0Dvd36wbSPnlnSWri3Wnkan1yOspbXOirKfsMLtGIurXlsidC8+D+CpG+4zBLF7skeEJk
	7aEdxB0yipiR/E6/5tWe/nz3U+2S0RY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739550462;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GaCYe+OEwMyM/ciPR9cdhcr1JY5HT+u6CwMm73JcQ7Y=;
	b=FybShcH+TSd/qpYk8NdgYVWZwt++GnRT4WuQEnujxAyxs2Yhru2NcJqhWpW/zbYAWCQRhm
	oyVUltV/HBnNk9DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739550462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GaCYe+OEwMyM/ciPR9cdhcr1JY5HT+u6CwMm73JcQ7Y=;
	b=FpUnZ8JwEuFAZsbEuF7Z15Lr/OVP5f2ut541wcsVGpno2oeEvbGcEQrP1ZFch3lFU2CKZN
	L0Dvd36wbSPnlnSWri3Wnkan1yOspbXOirKfsMLtGIurXlsidC8+D+CpG+4zBLF7skeEJk
	7aEdxB0yipiR/E6/5tWe/nz3U+2S0RY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739550462;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GaCYe+OEwMyM/ciPR9cdhcr1JY5HT+u6CwMm73JcQ7Y=;
	b=FybShcH+TSd/qpYk8NdgYVWZwt++GnRT4WuQEnujxAyxs2Yhru2NcJqhWpW/zbYAWCQRhm
	oyVUltV/HBnNk9DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A488913285;
	Fri, 14 Feb 2025 16:27:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QBvhJ/5ur2eHSAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 14 Feb 2025 16:27:42 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 14 Feb 2025 17:27:40 +0100
Subject: [PATCH RFC v2 04/10] locking/local_lock: add localtry_trylock()
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-slub-percpu-caches-v2-4-88592ee0966a@suse.cz>
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
In-Reply-To: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
To: Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 maple-tree@lists.infradead.org, Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.2
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,suse.cz];
	R_RATELIMIT(0.00)[to_ip_from(RLtz7ce9b89hw8xzamye9qeynd)];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 

Add a localtry_trylock() variant without _irqsave that will be used in
slab sheaves implementation. Thanks to only disabling preemption and not
irqs, it has a lower overhead. It's not necessary to disable irqs to
avoid a deadlock if the irq context uses trylock and can handle
failures.

Also make the comment of localtry_trylock() more clear, and fix a
compilation failure in localtry_lock_init().

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/local_lock.h          | 13 ++++++++++++-
 include/linux/local_lock_internal.h | 31 +++++++++++++++++++++++++++----
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
index 05c254a5d7d3e6db64d7f81a3a4a10f5a942c29e..1a0bc35839e360d5c8170105849c3883463852f8 100644
--- a/include/linux/local_lock.h
+++ b/include/linux/local_lock.h
@@ -77,6 +77,16 @@
 #define localtry_lock_irqsave(lock, flags)				\
 	__localtry_lock_irqsave(lock, flags)
 
+/**
+ * localtry_trylock - Try to acquire a per CPU local lock.
+ * @lock:	The lock variable
+ *
+ * The function can be used in any context such as NMI or HARDIRQ. Due to
+ * locking constrains it will _always_ fail to acquire the lock in NMI or
+ * HARDIRQ context on PREEMPT_RT.
+ */
+#define localtry_trylock(lock)		__localtry_trylock(lock)
+
 /**
  * localtry_trylock_irqsave - Try to acquire a per CPU local lock, save and disable
  *			      interrupts if acquired
@@ -84,7 +94,8 @@
  * @flags:	Storage for interrupt flags
  *
  * The function can be used in any context such as NMI or HARDIRQ. Due to
- * locking constrains it will _always_ fail to acquire the lock on PREEMPT_RT.
+ * locking constrains it will _always_ fail to acquire the lock in NMI or
+ * HARDIRQ context on PREEMPT_RT.
  */
 #define localtry_trylock_irqsave(lock, flags)				\
 	__localtry_trylock_irqsave(lock, flags)
diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
index c1369b300777d3ff3700cfd8bd4de8186124f036..67bd13d142fac39bc0f8b2c05eaf81717ff480f9 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -137,7 +137,7 @@ do {								\
 #define __localtry_lock_init(lock)				\
 do {								\
 	__local_lock_init(&(lock)->llock);			\
-	WRITE_ONCE(&(lock)->acquired, 0);			\
+	WRITE_ONCE((lock)->acquired, 0);			\
 } while (0)
 
 #define __localtry_lock(lock)					\
@@ -167,6 +167,24 @@ do {								\
 		WRITE_ONCE(lt->acquired, 1);			\
 	} while (0)
 
+#define __localtry_trylock(lock)				\
+	({							\
+		localtry_lock_t *lt;				\
+		bool _ret;					\
+								\
+		preempt_disable();				\
+		lt = this_cpu_ptr(lock);			\
+		if (!READ_ONCE(lt->acquired)) {			\
+			WRITE_ONCE(lt->acquired, 1);		\
+			local_trylock_acquire(&lt->llock);	\
+			_ret = true;				\
+		} else {					\
+			_ret = false;				\
+			preempt_enable();			\
+		}						\
+		_ret;						\
+	})
+
 #define __localtry_trylock_irqsave(lock, flags)			\
 	({							\
 		localtry_lock_t *lt;				\
@@ -275,12 +293,10 @@ do {								\
 #define __localtry_unlock_irq(lock)			__local_unlock(lock)
 #define __localtry_unlock_irqrestore(lock, flags)	__local_unlock_irqrestore(lock, flags)
 
-#define __localtry_trylock_irqsave(lock, flags)			\
+#define __localtry_trylock(lock)				\
 	({							\
 		int __locked;					\
 								\
-		typecheck(unsigned long, flags);		\
-		flags = 0;					\
 		if (in_nmi() | in_hardirq()) {			\
 			__locked = 0;				\
 		} else {					\
@@ -292,4 +308,11 @@ do {								\
 		__locked;					\
 	})
 
+#define __localtry_trylock_irqsave(lock, flags)			\
+	({							\
+		typecheck(unsigned long, flags);		\
+		flags = 0;					\
+		__localtry_trylock(lock);			\
+	})
+
 #endif /* CONFIG_PREEMPT_RT */

-- 
2.48.1

