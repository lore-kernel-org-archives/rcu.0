Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7DB2676E8
	for <rcu@vger.kernel.org>; Fri, 14 Feb 2025 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550478; cv=none; b=NBbyDt5arzMh/LzyXhTogvKwOI5Y1pOHOsfG8FiqRvUYYUFXxbV1U6+JPksCV3Ljv4bxnZ6MXNGEoInRy3lbNRCirfjuiaY/GEZP4nyeymJhIpJBX3a/Q7nyuxyPo5gykOQCcBDORVZG4N0eOZZ/PtUGYdjT4qkeURNr2/RmDBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550478; c=relaxed/simple;
	bh=SfZM6Hd/9a+xP/g1M9E3hd7KH54fpbjNL+LRgFhlqds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=apJyxzBVCSMpNzJneUs7neLrdtaZjALn9abBdPLadQ+ijwezqQkOPAESB5YcYJ0H8IdurqVDnGQgHqy7B/1PSpj8Hs9Ps5Xe6vWouFcVpDVDMNWYvPef/IXi0UjhxH83iEpAnZucxamSRjCDE51GgQ6ABXEpu3C9hEhaOJn5BQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=fail smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vOD9ZPdY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7xUlR2eP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vOD9ZPdY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7xUlR2eP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vOD9ZPdY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7xUlR2eP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vOD9ZPdY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7xUlR2eP"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A93E01F385;
	Fri, 14 Feb 2025 16:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739550462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lIzXccUZA4q876S/J/zvPHpHT/q5C0HeBpiguBJ8hRk=;
	b=vOD9ZPdYLZSgZkoEYdGHxWYp06OQNiieFew/BV6VtjIm2elxKXiLMO599pPqSiNlLG9aJM
	GYMkv8DZWhSJBN9tMGO3tgd2Y1pRtTvqQypa37hKkcVtGPSMO2304jIgyXgAOaiK321Dzm
	twH0uRtFDoaQH5FPIcxkY3J3n/lUQAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739550462;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lIzXccUZA4q876S/J/zvPHpHT/q5C0HeBpiguBJ8hRk=;
	b=7xUlR2ePVk0IqasFXt+ElbqxdCy3a5wscKe8SsSrf5UthL13hHBrdf2mHZuVoDXgRiMb8C
	PRpbC8JI8kZb4fDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739550462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lIzXccUZA4q876S/J/zvPHpHT/q5C0HeBpiguBJ8hRk=;
	b=vOD9ZPdYLZSgZkoEYdGHxWYp06OQNiieFew/BV6VtjIm2elxKXiLMO599pPqSiNlLG9aJM
	GYMkv8DZWhSJBN9tMGO3tgd2Y1pRtTvqQypa37hKkcVtGPSMO2304jIgyXgAOaiK321Dzm
	twH0uRtFDoaQH5FPIcxkY3J3n/lUQAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739550462;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lIzXccUZA4q876S/J/zvPHpHT/q5C0HeBpiguBJ8hRk=;
	b=7xUlR2ePVk0IqasFXt+ElbqxdCy3a5wscKe8SsSrf5UthL13hHBrdf2mHZuVoDXgRiMb8C
	PRpbC8JI8kZb4fDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D39F13AFB;
	Fri, 14 Feb 2025 16:27:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qMYyIv5ur2eHSAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 14 Feb 2025 16:27:42 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 14 Feb 2025 17:27:39 +0100
Subject: [PATCH RFC v2 03/10] locking/local_lock: Introduce localtry_lock_t
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-slub-percpu-caches-v2-3-88592ee0966a@suse.cz>
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
In-Reply-To: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
To: Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 maple-tree@lists.infradead.org, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Alexei Starovoitov <ast@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.2
X-Spam-Level: 
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
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,linutronix.de,kernel.org,suse.cz];
	R_RATELIMIT(0.00)[to_ip_from(RLtz7ce9b89hw8xzamye9qeynd)];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid]
X-Spam-Score: -6.80
X-Spam-Flag: NO

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

In !PREEMPT_RT local_lock_irqsave() disables interrupts to protect
critical section, but it doesn't prevent NMI, so the fully reentrant
code cannot use local_lock_irqsave() for exclusive access.

Introduce localtry_lock_t and localtry_lock_irqsave() that
disables interrupts and sets acquired=1, so localtry_lock_irqsave()
from NMI attempting to acquire the same lock will return false.

In PREEMPT_RT local_lock_irqsave() maps to preemptible spin_lock().
Map localtry_lock_irqsave() to preemptible spin_trylock().
When in hard IRQ or NMI return false right away, since
spin_trylock() is not safe due to PI issues.

Note there is no need to use local_inc for acquired variable,
since it's a percpu variable with strict nesting scopes.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/local_lock.h          |  59 +++++++++++++++++
 include/linux/local_lock_internal.h | 123 ++++++++++++++++++++++++++++++++++++
 2 files changed, 182 insertions(+)

diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
index 091dc0b6bdfb9f4721f94d19828a38fbfa59346c..05c254a5d7d3e6db64d7f81a3a4a10f5a942c29e 100644
--- a/include/linux/local_lock.h
+++ b/include/linux/local_lock.h
@@ -51,6 +51,65 @@
 #define local_unlock_irqrestore(lock, flags)			\
 	__local_unlock_irqrestore(lock, flags)
 
+/**
+ * localtry_lock_init - Runtime initialize a lock instance
+ */
+#define localtry_lock_init(lock)		__localtry_lock_init(lock)
+
+/**
+ * localtry_lock - Acquire a per CPU local lock
+ * @lock:	The lock variable
+ */
+#define localtry_lock(lock)		__localtry_lock(lock)
+
+/**
+ * localtry_lock_irq - Acquire a per CPU local lock and disable interrupts
+ * @lock:	The lock variable
+ */
+#define localtry_lock_irq(lock)		__localtry_lock_irq(lock)
+
+/**
+ * localtry_lock_irqsave - Acquire a per CPU local lock, save and disable
+ *			 interrupts
+ * @lock:	The lock variable
+ * @flags:	Storage for interrupt flags
+ */
+#define localtry_lock_irqsave(lock, flags)				\
+	__localtry_lock_irqsave(lock, flags)
+
+/**
+ * localtry_trylock_irqsave - Try to acquire a per CPU local lock, save and disable
+ *			      interrupts if acquired
+ * @lock:	The lock variable
+ * @flags:	Storage for interrupt flags
+ *
+ * The function can be used in any context such as NMI or HARDIRQ. Due to
+ * locking constrains it will _always_ fail to acquire the lock on PREEMPT_RT.
+ */
+#define localtry_trylock_irqsave(lock, flags)				\
+	__localtry_trylock_irqsave(lock, flags)
+
+/**
+ * local_unlock - Release a per CPU local lock
+ * @lock:	The lock variable
+ */
+#define localtry_unlock(lock)		__localtry_unlock(lock)
+
+/**
+ * local_unlock_irq - Release a per CPU local lock and enable interrupts
+ * @lock:	The lock variable
+ */
+#define localtry_unlock_irq(lock)		__localtry_unlock_irq(lock)
+
+/**
+ * localtry_unlock_irqrestore - Release a per CPU local lock and restore
+ *			      interrupt flags
+ * @lock:	The lock variable
+ * @flags:      Interrupt flags to restore
+ */
+#define localtry_unlock_irqrestore(lock, flags)			\
+	__localtry_unlock_irqrestore(lock, flags)
+
 DEFINE_GUARD(local_lock, local_lock_t __percpu*,
 	     local_lock(_T),
 	     local_unlock(_T))
diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
index 8dd71fbbb6d2b6748969438c4642f7d970834871..c1369b300777d3ff3700cfd8bd4de8186124f036 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -15,6 +15,11 @@ typedef struct {
 #endif
 } local_lock_t;
 
+typedef struct {
+	local_lock_t	llock;
+	unsigned int	acquired;
+} localtry_lock_t;
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define LOCAL_LOCK_DEBUG_INIT(lockname)		\
 	.dep_map = {					\
@@ -31,6 +36,13 @@ static inline void local_lock_acquire(local_lock_t *l)
 	l->owner = current;
 }
 
+static inline void local_trylock_acquire(local_lock_t *l)
+{
+	lock_map_acquire_try(&l->dep_map);
+	DEBUG_LOCKS_WARN_ON(l->owner);
+	l->owner = current;
+}
+
 static inline void local_lock_release(local_lock_t *l)
 {
 	DEBUG_LOCKS_WARN_ON(l->owner != current);
@@ -45,11 +57,13 @@ static inline void local_lock_debug_init(local_lock_t *l)
 #else /* CONFIG_DEBUG_LOCK_ALLOC */
 # define LOCAL_LOCK_DEBUG_INIT(lockname)
 static inline void local_lock_acquire(local_lock_t *l) { }
+static inline void local_trylock_acquire(local_lock_t *l) { }
 static inline void local_lock_release(local_lock_t *l) { }
 static inline void local_lock_debug_init(local_lock_t *l) { }
 #endif /* !CONFIG_DEBUG_LOCK_ALLOC */
 
 #define INIT_LOCAL_LOCK(lockname)	{ LOCAL_LOCK_DEBUG_INIT(lockname) }
+#define INIT_LOCALTRY_LOCK(lockname)	{ .llock = { LOCAL_LOCK_DEBUG_INIT(lockname.llock) }}
 
 #define __local_lock_init(lock)					\
 do {								\
@@ -118,6 +132,86 @@ do {								\
 #define __local_unlock_nested_bh(lock)				\
 	local_lock_release(this_cpu_ptr(lock))
 
+/* localtry_lock_t variants */
+
+#define __localtry_lock_init(lock)				\
+do {								\
+	__local_lock_init(&(lock)->llock);			\
+	WRITE_ONCE(&(lock)->acquired, 0);			\
+} while (0)
+
+#define __localtry_lock(lock)					\
+	do {							\
+		localtry_lock_t *lt;				\
+		preempt_disable();				\
+		lt = this_cpu_ptr(lock);			\
+		local_lock_acquire(&lt->llock);			\
+		WRITE_ONCE(lt->acquired, 1);			\
+	} while (0)
+
+#define __localtry_lock_irq(lock)				\
+	do {							\
+		localtry_lock_t *lt;				\
+		local_irq_disable();				\
+		lt = this_cpu_ptr(lock);			\
+		local_lock_acquire(&lt->llock);			\
+		WRITE_ONCE(lt->acquired, 1);			\
+	} while (0)
+
+#define __localtry_lock_irqsave(lock, flags)			\
+	do {							\
+		localtry_lock_t *lt;				\
+		local_irq_save(flags);				\
+		lt = this_cpu_ptr(lock);			\
+		local_lock_acquire(&lt->llock);			\
+		WRITE_ONCE(lt->acquired, 1);			\
+	} while (0)
+
+#define __localtry_trylock_irqsave(lock, flags)			\
+	({							\
+		localtry_lock_t *lt;				\
+		bool _ret;					\
+								\
+		local_irq_save(flags);				\
+		lt = this_cpu_ptr(lock);			\
+		if (!READ_ONCE(lt->acquired)) {			\
+			WRITE_ONCE(lt->acquired, 1);		\
+			local_trylock_acquire(&lt->llock);	\
+			_ret = true;				\
+		} else {					\
+			_ret = false;				\
+			local_irq_restore(flags);		\
+		}						\
+		_ret;						\
+	})
+
+#define __localtry_unlock(lock)					\
+	do {							\
+		localtry_lock_t *lt;				\
+		lt = this_cpu_ptr(lock);			\
+		WRITE_ONCE(lt->acquired, 0);			\
+		local_lock_release(&lt->llock);			\
+		preempt_enable();				\
+	} while (0)
+
+#define __localtry_unlock_irq(lock)				\
+	do {							\
+		localtry_lock_t *lt;				\
+		lt = this_cpu_ptr(lock);			\
+		WRITE_ONCE(lt->acquired, 0);			\
+		local_lock_release(&lt->llock);			\
+		local_irq_enable();				\
+	} while (0)
+
+#define __localtry_unlock_irqrestore(lock, flags)		\
+	do {							\
+		localtry_lock_t *lt;				\
+		lt = this_cpu_ptr(lock);			\
+		WRITE_ONCE(lt->acquired, 0);			\
+		local_lock_release(&lt->llock);			\
+		local_irq_restore(flags);			\
+	} while (0)
+
 #else /* !CONFIG_PREEMPT_RT */
 
 /*
@@ -125,8 +219,10 @@ do {								\
  * critical section while staying preemptible.
  */
 typedef spinlock_t local_lock_t;
+typedef spinlock_t localtry_lock_t;
 
 #define INIT_LOCAL_LOCK(lockname) __LOCAL_SPIN_LOCK_UNLOCKED((lockname))
+#define INIT_LOCALTRY_LOCK(lockname) INIT_LOCAL_LOCK(lockname)
 
 #define __local_lock_init(l)					\
 	do {							\
@@ -169,4 +265,31 @@ do {								\
 	spin_unlock(this_cpu_ptr((lock)));			\
 } while (0)
 
+/* localtry_lock_t variants */
+
+#define __localtry_lock_init(lock)			__local_lock_init(lock)
+#define __localtry_lock(lock)				__local_lock(lock)
+#define __localtry_lock_irq(lock)			__local_lock(lock)
+#define __localtry_lock_irqsave(lock, flags)		__local_lock_irqsave(lock, flags)
+#define __localtry_unlock(lock)				__local_unlock(lock)
+#define __localtry_unlock_irq(lock)			__local_unlock(lock)
+#define __localtry_unlock_irqrestore(lock, flags)	__local_unlock_irqrestore(lock, flags)
+
+#define __localtry_trylock_irqsave(lock, flags)			\
+	({							\
+		int __locked;					\
+								\
+		typecheck(unsigned long, flags);		\
+		flags = 0;					\
+		if (in_nmi() | in_hardirq()) {			\
+			__locked = 0;				\
+		} else {					\
+			migrate_disable();			\
+			__locked = spin_trylock(this_cpu_ptr((lock)));	\
+			if (!__locked)				\
+				migrate_enable();		\
+		}						\
+		__locked;					\
+	})
+
 #endif /* CONFIG_PREEMPT_RT */

-- 
2.48.1

