Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47ED22332E;
	Thu, 12 Dec 2024 18:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026537; cv=none; b=jVkbiCqfda6T8TWHOVyBiAUBHIBAtO+43T3GE/ZTh+nId32OPZNZIfowD1oLhok4aib0q907I926F4LJRovov5kq6wCMLgQTeafQUCCTh9B10aFteLpcVbU8UfPM3404rzYWNnCbUw/LBNn7kDI4dZwwrtx17oaOSTYhU8ZuaXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026537; c=relaxed/simple;
	bh=Z4wVBF0PHj8Zq5EQV7Us0YE2VClVTJCMcUE2buYl+h4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=avy1VBuI0Gpl3a757wvhE6aW7KTgojECZShiA/k2gHkiDxoQub5hd8QQuxqZbcl3U3Zj6/uGuvMo6jVoWYCbDJ/m14NRGYi1p0rZSRm9uJgHrFA7LohQG+KbVRI/cp2riWZdTeuSomoUhuCaKLN8ZAe558xqsuKsarbnHAcrJ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4+Vfvzf; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4+Vfvzf"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5401d3ea5a1so970512e87.3;
        Thu, 12 Dec 2024 10:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734026534; x=1734631334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tH4hkCLHUFdjR9ahFZD+4T/NQJlUp6AP/fKB9gG9Cew=;
        b=c4+Vfvzf4A5EVqBEVI/gePjYo/DtU90dggTNSmhfUss5n3NlXgwFnRy80eY7TyowMN
         KMUBYljPeq3HLYBRMqUse/U5i7XbBCO9h2E1AJdZ7MhaQ6thwlUlT6l4OxctVz6NUOiM
         WVe6se+I7UMh7AQKkJUGF2ekyQHqvAdVUDF6CwPGVYYdASY6IiXeYZEBc3x6hGc7lFq6
         09U7Fl4e4QJ3bVRpS9aF2CdRWV1ZAd54hRuQBv7yZzQ8+O4cHQqqtbndgm3TN4weR8Bb
         YaS8fBYal7gTw4IPuaNtYJ03E4rogz6BfHAi92Ucsj/CRhqbUf2m4S8jVWGsCWSNlaro
         Fbuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026534; x=1734631334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tH4hkCLHUFdjR9ahFZD+4T/NQJlUp6AP/fKB9gG9Cew=;
        b=MGQ+Eq2zc00Ket3iOkTUz4PyTtJkC2/Z9k89M4N2+mM1xricerD3GhwoqeCrVeofae
         5WC8wY4h9EC6JmUeW6uedduU7pmMpxQvcBzFNmA1Jc/r1i1jfxL9+tXecNfv23oEGLTX
         93Tau/UGIaVEbB56HKg66w/V0eN465r0zIQJsBPZemj1hQvtR5tEi+xY50Bf91+spatd
         yQ4pPq3DzFYwfsTGx9o57UPumfpmefbMbydFE1iUm+XpXLnMzJdqT/rurveWHAtfzyvv
         /A2UpvUOPBLaxuTajecAfLPu4FtH9PDqOpmbtFRyPdN2cvp/3ENWbiZasqep8KTI7/7h
         0G4g==
X-Forwarded-Encrypted: i=1; AJvYcCXhcxqVh9/ccW0fK4Tkvk6VxJFJssiylrgGth/VNNHhNzL043bIQFVeZuQshRy7z6t7/F5OU8RXacDICX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF+hAG5O0sYVdk95LiHjAfdEXObGYxbOcUMn8H409QyGXbPcUS
	91KIkrFWp5JxsMV4gTO3iSCRP3yHmdjys6vSBz+sGRTmY2iZ0IT4
X-Gm-Gg: ASbGncuti2AVV1rlS2llxzIz10bRWMuA1ijmgc9biGZTDBh5EqPQv574kxnRLNcVnJW
	Mu1g7idn9nNky4rMSX1p1J8UXoQSsXGdbbGi48Y8uuH+Rsa9ZkyFbKUa93v5ytOVbpGhFwk2uXf
	VPQRRrN1T78ZPfbkIV/jFQ6Ui86Mws/fKT1OxxoabyaBkLzdTZijLPsYpIWq/AV6ZYLPc9C52Eb
	lsDmZfmciejSMQusvG9rX+wr2MpAxrdShkt94r85Ag3qfzNh01+
X-Google-Smtp-Source: AGHT+IEKLvPMI5CiAsBGeGMYPXutOtLCJKZ20+8zR8pPilM981v0MVz8wxdnXFoxtX1lsxgDEQ77sQ==
X-Received: by 2002:a05:6512:3b13:b0:53e:350a:7298 with SMTP id 2adb3069b0e04-54034111a86mr428178e87.25.1734026533208;
        Thu, 12 Dec 2024 10:02:13 -0800 (PST)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e39375d36sm1940645e87.7.2024.12.12.10.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 10:02:12 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v2 2/5] rcu/kvfree: Move some functions under CONFIG_TINY_RCU
Date: Thu, 12 Dec 2024 19:02:05 +0100
Message-Id: <20241212180208.274813-3-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212180208.274813-1-urezki@gmail.com>
References: <20241212180208.274813-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently when a tiny RCU is enabled, the tree.c file is not
compiled, thus duplicating function names do not conflict with
each other.

Because of moving of kvfree_rcu() functionality to the SLAB,
we have to reorder some functions and place them together under
CONFIG_TINY_RCU macro definition. Therefore, those functions name
will not conflict when a kernel is compiled for CONFIG_TINY_RCU
flavor.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 90 +++++++++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 43 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e69b867de8ef..b3853ae6e869 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3653,16 +3653,6 @@ static void kfree_rcu_monitor(struct work_struct *work)
 		schedule_delayed_monitor_work(krcp);
 }
 
-static enum hrtimer_restart
-schedule_page_work_fn(struct hrtimer *t)
-{
-	struct kfree_rcu_cpu *krcp =
-		container_of(t, struct kfree_rcu_cpu, hrtimer);
-
-	queue_delayed_work(system_highpri_wq, &krcp->page_cache_work, 0);
-	return HRTIMER_NORESTART;
-}
-
 static void fill_page_cache_func(struct work_struct *work)
 {
 	struct kvfree_rcu_bulk_data *bnode;
@@ -3698,27 +3688,6 @@ static void fill_page_cache_func(struct work_struct *work)
 	atomic_set(&krcp->backoff_page_cache_fill, 0);
 }
 
-static void
-run_page_cache_worker(struct kfree_rcu_cpu *krcp)
-{
-	// If cache disabled, bail out.
-	if (!rcu_min_cached_objs)
-		return;
-
-	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
-			!atomic_xchg(&krcp->work_in_progress, 1)) {
-		if (atomic_read(&krcp->backoff_page_cache_fill)) {
-			queue_delayed_work(system_unbound_wq,
-				&krcp->page_cache_work,
-					msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
-		} else {
-			hrtimer_init(&krcp->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-			krcp->hrtimer.function = schedule_page_work_fn;
-			hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
-		}
-	}
-}
-
 // Record ptr in a page managed by krcp, with the pre-krc_this_cpu_lock()
 // state specified by flags.  If can_alloc is true, the caller must
 // be schedulable and not be holding any locks or mutexes that might be
@@ -3779,6 +3748,51 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
 	return true;
 }
 
+#if !defined(CONFIG_TINY_RCU)
+
+static enum hrtimer_restart
+schedule_page_work_fn(struct hrtimer *t)
+{
+	struct kfree_rcu_cpu *krcp =
+		container_of(t, struct kfree_rcu_cpu, hrtimer);
+
+	queue_delayed_work(system_highpri_wq, &krcp->page_cache_work, 0);
+	return HRTIMER_NORESTART;
+}
+
+static void
+run_page_cache_worker(struct kfree_rcu_cpu *krcp)
+{
+	// If cache disabled, bail out.
+	if (!rcu_min_cached_objs)
+		return;
+
+	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
+			!atomic_xchg(&krcp->work_in_progress, 1)) {
+		if (atomic_read(&krcp->backoff_page_cache_fill)) {
+			queue_delayed_work(system_unbound_wq,
+				&krcp->page_cache_work,
+					msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
+		} else {
+			hrtimer_init(&krcp->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+			krcp->hrtimer.function = schedule_page_work_fn;
+			hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
+		}
+	}
+}
+
+void __init kfree_rcu_scheduler_running(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
+
+		if (need_offload_krc(krcp))
+			schedule_delayed_monitor_work(krcp);
+	}
+}
+
 /*
  * Queue a request for lazy invocation of the appropriate free routine
  * after a grace period.  Please note that three paths are maintained,
@@ -3944,6 +3958,8 @@ void kvfree_rcu_barrier(void)
 }
 EXPORT_SYMBOL_GPL(kvfree_rcu_barrier);
 
+#endif /* #if !defined(CONFIG_TINY_RCU) */
+
 static unsigned long
 kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 {
@@ -3985,18 +4001,6 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 	return freed == 0 ? SHRINK_STOP : freed;
 }
 
-void __init kfree_rcu_scheduler_running(void)
-{
-	int cpu;
-
-	for_each_possible_cpu(cpu) {
-		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
-
-		if (need_offload_krc(krcp))
-			schedule_delayed_monitor_work(krcp);
-	}
-}
-
 /*
  * During early boot, any blocking grace-period wait automatically
  * implies a grace period.
-- 
2.39.5

