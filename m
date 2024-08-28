Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD8815530C;
	Wed, 28 Aug 2024 11:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724843375; cv=none; b=fUme3eENBjilKBkzt/IzKTC59zns73QAXzaPRzRiD3UsY30ap2MZKXBsv27fkKZXXOt7iLPLuH+yxNnjl3MJxy4Ro+tmGVSc76FdsV+tjHVIVvOJx+ZBg1pktUBDY4eXLH4/hPt3z6biromdIVAgXyYBYIqGAtTxfFlOD0ChcVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724843375; c=relaxed/simple;
	bh=tH5AVuZaz/SBuoF41LI0/mhbZ9VYmt+O9y2koTLDQwg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qXxnQ31KdZ94p0NFBdqOcc9Nxotf9GWCaeJYxyUlDniGHzavG1xoTkQD5sTHOg29I+mCOX94SRkRbQuZ2yvXptyDxnldOyymk8XfRYm79dciXO2N6gcYHy3KRr8+6i/Wxj53Vbt46HgSjYVy7UJqPV1yy1lP5l2W45rapCvlSJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ju0TJd4C; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ju0TJd4C"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-533462b9428so11132504e87.3;
        Wed, 28 Aug 2024 04:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724843372; x=1725448172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=APgBV8G9YmayHbdpoOGlYHq23hZ8pxfAdj4J5HwI9Jg=;
        b=ju0TJd4C3K/XPl/8aUKdXG///gYcJH0hrfmgKmvlSLLfVTWCa8TAeGCenxvnPDNfh5
         hwEpgFggJ4pi5kfiu7KYcOFZOy9KQad6I64OS06E3UsH7ilqF96VDYd1DnQMBwa0LOXJ
         s9yXuuTR+1h6GZ+CQzizoDy0CJMo33C0VKhbh7TGGHMb/sOBaQ1xejUvk3UR4gIFTVSk
         jtVKqQsim6lx6ZW4+l/B8L8f0KpXVJoRESL7ZNuRTXXpr7KROWsiNmX25T526wm8Vlju
         eGDaKoc+IDbxIDbmAL1AfK5nDuBgWWluF12ilP06/MyiMyCnnI2ORky2uWoCR2pGHJd+
         X1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724843372; x=1725448172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=APgBV8G9YmayHbdpoOGlYHq23hZ8pxfAdj4J5HwI9Jg=;
        b=q+7lHZvTTmaeni60HiOVdqfvi48YPxfr+QD7HGMjugX2ZQFWGwBZ5zZPrIzHYxZcqq
         ajT6W2GNr+Or00gtQe+FVxYb0z0woVS93eTJN1P/kzKo67Q12rTBs8dPDJdFfGQBnX1c
         KV7w3XUCRSHtNXzp4+RXBv65PaR7acytvbJLWaJsr2ibFgMSn6u5DKQtkViqRexye3um
         glOGhdQ5G3yZZkj4ax5+0/sYSxr0W+UT+Ym8F9Ed0pSG2fsoF5URtySLi6r/B7nxIEuZ
         qPJxAU1TefBrZ72z0PAF7b7Y01TrlSlY3dvDmzpmYgfECwRRlUJvzEkOn/hRNT4DSvsa
         ZfPw==
X-Forwarded-Encrypted: i=1; AJvYcCVMfPiOSk8ysJmh9vzVigv6KLd6jCqfJXY7zsprBBwgoep1avYnXmZCYwZDVjbxWNPNAaNXbT2y8SWvfw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyExB0tXarjg3zvhVx49nP4UoBUrNGDr6y7c5uJ3RQrmySeFpJr
	5b/qLmM1k6PFnsBMvYPFtpwoJv9xgVYap/LYbPVaAoJLh+MRAIYS
X-Google-Smtp-Source: AGHT+IEwrZjfzGPiUUcd0oy9ve5M3+k155o6iB3Qt18BMKOUcB5vJW9DYhSPs+vbkqgWQiJIYGZe9w==
X-Received: by 2002:a05:6512:3d20:b0:52e:73f5:b7c4 with SMTP id 2adb3069b0e04-5343887e063mr12923255e87.37.1724843371157;
        Wed, 28 Aug 2024 04:09:31 -0700 (PDT)
Received: from pc638.lan (84-217-131-213.customers.ownit.se. [84.217.131.213])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea5d6bdsm2154922e87.208.2024.08.28.04.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 04:09:30 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 1/4] rcu/kvfree: Support dynamic rcu_head for single argument objects
Date: Wed, 28 Aug 2024 13:09:26 +0200
Message-Id: <20240828110929.3713-1-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a support of dynamically attaching an rcu_head to an object
which gets freed via the single argument of kvfree_rcu(). This is
used in the path, when a page allocation fails due to a high memory
pressure.

The basic idea behind of this is to minimize a hit of slow path
which requires a caller to wait until a grace period is passed.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 53 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index be00aac5f4e7..0124411fecfb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3425,6 +3425,11 @@ kvfree_rcu_bulk(struct kfree_rcu_cpu *krcp,
 	cond_resched_tasks_rcu_qs();
 }
 
+struct dyn_rcu_head {
+	unsigned long *ptr;
+	struct rcu_head rh;
+};
+
 static void
 kvfree_rcu_list(struct rcu_head *head)
 {
@@ -3433,15 +3438,32 @@ kvfree_rcu_list(struct rcu_head *head)
 	for (; head; head = next) {
 		void *ptr = (void *) head->func;
 		unsigned long offset = (void *) head - ptr;
+		struct dyn_rcu_head *drhp = NULL;
+
+		/*
+		 * For dynamically attached rcu_head, a ->func field
+		 * points to _offset_, i.e. not to a pointer which has
+		 * to be freed. For such objects, adjust an offset and
+		 * pointer.
+		 */
+		if (__is_kvfree_rcu_offset((unsigned long) ptr)) {
+			drhp = container_of(head, struct dyn_rcu_head, rh);
+			offset = (unsigned long) drhp->rh.func;
+			ptr = drhp->ptr;
+		}
 
 		next = head->next;
 		debug_rcu_head_unqueue((struct rcu_head *)ptr);
 		rcu_lock_acquire(&rcu_callback_map);
 		trace_rcu_invoke_kvfree_callback(rcu_state.name, head, offset);
 
-		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset)))
+		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset))) {
 			kvfree(ptr);
 
+			if (drhp)
+				kvfree(drhp);
+		}
+
 		rcu_lock_release(&rcu_callback_map);
 		cond_resched_tasks_rcu_qs();
 	}
@@ -3787,6 +3809,21 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
 	return true;
 }
 
+static struct rcu_head *
+attach_rcu_head_to_object(void *obj)
+{
+	struct dyn_rcu_head *rhp;
+
+	rhp = kmalloc(sizeof(struct dyn_rcu_head), GFP_KERNEL |
+		__GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
+
+	if (!rhp)
+		return NULL;
+
+	rhp->ptr = obj;
+	return &rhp->rh;
+}
+
 /*
  * Queue a request for lazy invocation of the appropriate free routine
  * after a grace period.  Please note that three paths are maintained,
@@ -3830,9 +3867,17 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 	if (!success) {
 		run_page_cache_worker(krcp);
 
-		if (head == NULL)
-			// Inline if kvfree_rcu(one_arg) call.
-			goto unlock_return;
+		if (!head) {
+			krc_this_cpu_unlock(krcp, flags);
+			head = attach_rcu_head_to_object(ptr);
+			krcp = krc_this_cpu_lock(&flags);
+
+			if (!head)
+				// Inline if kvfree_rcu(one_arg) call.
+				goto unlock_return;
+
+			ptr = (rcu_callback_t) offsetof(struct dyn_rcu_head, rh);
+		}
 
 		head->func = ptr;
 		head->next = krcp->head;
-- 
2.39.2

