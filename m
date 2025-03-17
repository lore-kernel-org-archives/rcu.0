Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7A8230995
	for <rcu@vger.kernel.org>; Mon, 17 Mar 2025 14:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742222018; cv=none; b=cPUnWcDdiiFuVM1B63wYt8ogCh6bycCLwkbUxgRE4MIIMri+BKvjDj/f4Tkku1bWPNHIuGJL4mAmxVhsxgBc9/hK5rxH8XsoStQnufxD5aehJbM0cvo2vlsCkkf59dksl0IHgzr4gdT0vI4Vf37RD1HwPRPqrjPjyYDlgp442Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742222018; c=relaxed/simple;
	bh=5iOakY+89Pj0YOnQvt/2O5/OyL1U8TtCyy7+4BzM/z0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YseIrL8YPSoHqznH/MaedYxTtuzIbij+WjdoTooKV/ccsIPiTZdSPLSv24ZsMXc0ZUwg0EbJKyEd8nZSCgNgPRBxY6cUjAjBBIClkenddgjinIruJjAIlv+VU1TVy83LcQoYlm94c2vZi4VnPm+RPQx9ack2wB7WZSogyNLLN68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UCcLsNG2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vxzVQvw6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UCcLsNG2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vxzVQvw6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UCcLsNG2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vxzVQvw6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UCcLsNG2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vxzVQvw6"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BD5271F7B6;
	Mon, 17 Mar 2025 14:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742222013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tCAdlDM2+tXBDumZZR7BbS1zlXHmvraj7d95vlj0GSo=;
	b=UCcLsNG2wnBJFeCQRigMOvcNxc8of2lhE8GV8xgGFar5DCl1+eGhF69R2AmaLIPlWGEt1L
	2wWN+dlDCF99X0/+WXs/MKI9VCpC2yNmAsfzHbtr44LCSBOm1fnvoD1moC+fZhPJ3qLqJ/
	7KDt7ov5pN1KHYxFUj8MGNtU5d0kx3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742222013;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tCAdlDM2+tXBDumZZR7BbS1zlXHmvraj7d95vlj0GSo=;
	b=vxzVQvw6ynbumcY64dJ4/jwa7t4EKLIfph8BfBBoiGOdYBWQZFRrUoj3BhDq5jvoAeMmLO
	5IDly0MtlMy8sLDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742222013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tCAdlDM2+tXBDumZZR7BbS1zlXHmvraj7d95vlj0GSo=;
	b=UCcLsNG2wnBJFeCQRigMOvcNxc8of2lhE8GV8xgGFar5DCl1+eGhF69R2AmaLIPlWGEt1L
	2wWN+dlDCF99X0/+WXs/MKI9VCpC2yNmAsfzHbtr44LCSBOm1fnvoD1moC+fZhPJ3qLqJ/
	7KDt7ov5pN1KHYxFUj8MGNtU5d0kx3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742222013;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tCAdlDM2+tXBDumZZR7BbS1zlXHmvraj7d95vlj0GSo=;
	b=vxzVQvw6ynbumcY64dJ4/jwa7t4EKLIfph8BfBBoiGOdYBWQZFRrUoj3BhDq5jvoAeMmLO
	5IDly0MtlMy8sLDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0FBE13A2C;
	Mon, 17 Mar 2025 14:33:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6D8GJ70y2GcycQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 17 Mar 2025 14:33:33 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 17 Mar 2025 15:33:02 +0100
Subject: [PATCH RFC v3 1/8] locking/local_lock: Introduce localtry_lock_t
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-slub-percpu-caches-v3-1-9d9884d8b643@suse.cz>
References: <20250317-slub-percpu-caches-v3-0-9d9884d8b643@suse.cz>
In-Reply-To: <20250317-slub-percpu-caches-v3-0-9d9884d8b643@suse.cz>
To: Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 maple-tree@lists.infradead.org, vbabka@suse.cz, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Davidlohr Bueso <dave@stgolabs.net>, Alexei Starovoitov <ast@kernel.org>
X-Mailer: b4 0.14.2
X-Spam-Score: -8.30
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,oracle.com,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,suse.cz,linutronix.de,stgolabs.net,kernel.org];
	R_RATELIMIT(0.00)[to_ip_from(RLsunix6otu811wnbhxcn9byqb)];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,linutronix.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

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
spin_trylock() is not safe due to explicit locking in the underneath
rt_spin_trylock() implementation. Removing this explicit locking and
attempting only "trylock" is undesired due to PI implications.

Note there is no need to use local_inc for acquired variable,
since it's a percpu variable with strict nesting scopes.

Acked-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Link: https://lore.kernel.org/r/20250222024427.30294-2-alexei.starovoitov@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/local_lock.h          |  70 +++++++++++++++++
 include/linux/local_lock_internal.h | 146 ++++++++++++++++++++++++++++++++++++
 2 files changed, 216 insertions(+)

diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
index 091dc0b6bdfb9f4721f94d19828a38fbfa59346c..1a0bc35839e360d5c8170105849c3883463852f8 100644
--- a/include/linux/local_lock.h
+++ b/include/linux/local_lock.h
@@ -51,6 +51,76 @@
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
+ * localtry_trylock - Try to acquire a per CPU local lock.
+ * @lock:	The lock variable
+ *
+ * The function can be used in any context such as NMI or HARDIRQ. Due to
+ * locking constrains it will _always_ fail to acquire the lock in NMI or
+ * HARDIRQ context on PREEMPT_RT.
+ */
+#define localtry_trylock(lock)		__localtry_trylock(lock)
+
+/**
+ * localtry_trylock_irqsave - Try to acquire a per CPU local lock, save and disable
+ *			      interrupts if acquired
+ * @lock:	The lock variable
+ * @flags:	Storage for interrupt flags
+ *
+ * The function can be used in any context such as NMI or HARDIRQ. Due to
+ * locking constrains it will _always_ fail to acquire the lock in NMI or
+ * HARDIRQ context on PREEMPT_RT.
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
index 8dd71fbbb6d2b6748969438c4642f7d970834871..67bd13d142fac39bc0f8b2c05eaf81717ff480f9 100644
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
@@ -118,6 +132,104 @@ do {								\
 #define __local_unlock_nested_bh(lock)				\
 	local_lock_release(this_cpu_ptr(lock))
 
+/* localtry_lock_t variants */
+
+#define __localtry_lock_init(lock)				\
+do {								\
+	__local_lock_init(&(lock)->llock);			\
+	WRITE_ONCE((lock)->acquired, 0);			\
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
@@ -125,8 +237,10 @@ do {								\
  * critical section while staying preemptible.
  */
 typedef spinlock_t local_lock_t;
+typedef spinlock_t localtry_lock_t;
 
 #define INIT_LOCAL_LOCK(lockname) __LOCAL_SPIN_LOCK_UNLOCKED((lockname))
+#define INIT_LOCALTRY_LOCK(lockname) INIT_LOCAL_LOCK(lockname)
 
 #define __local_lock_init(l)					\
 	do {							\
@@ -169,4 +283,36 @@ do {								\
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
+#define __localtry_trylock(lock)				\
+	({							\
+		int __locked;					\
+								\
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

