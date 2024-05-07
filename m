Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1068215E202;
	Tue,  7 May 2024 09:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074555; cv=none; b=QJdT6fGoBKP59BupbrQDiiZeNqpkr2+wo72E0wcsAfbIFKsSBb++Iaunh4r5FPXsOvsunEe4kgk25pXXi0vNWo5Luzx7JKhIRaOktP+kQ7ZTcLZgHNHZzdSEl2Z4Id0Xo0s3UalUyPIKKQiQbdjCS8qtrScU5R7uY1wwlB5bfOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074555; c=relaxed/simple;
	bh=l+TmEbx4CZVxGim40UrwGluV+jj9QY0FS6+FbuN8SPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jc6aZ4I5SAj6u75YVGP/87UU4HwumTK41V2wzNLK/oF8QUwvFfOch70av6C2w0KjkK9XS8zyj6Rla487YmTAJo/PQkruozWvEMXgrWGoe3wAUewgBnwAciHLs45Ut37hUhV8RSdXIdsYytPvbeh0gOzuQCl0uwtNTpa9ASudRdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FT58enar; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FT58enar"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e2b468ea12so27098181fa.1;
        Tue, 07 May 2024 02:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074551; x=1715679351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwgYfRQeH2LZBoFYMj3QaS/pu39IjMn5T1SZZO1FiIg=;
        b=FT58enars63RpPsOhVX2AsQVYIk3C8hc/WgNMvHrECFb6jYL0/RH8GmX+FPBXyZSYJ
         QSKPLzFhHIx3E1FWAf24Jb0QtgegemVrfO8BYTHSS5oKWEW8RMiCD+qIfR3mn5gGL7Lg
         YNcH7c4H1xECdc4gQOFDZd/8g4AccKi0XhiDruRI17mC7PNNLpCaymchSkzU2IVuT1ne
         aEcb8mONQiYykPQrsk3prI5EB9Wx9XEJzP7CzMQ0d7ykpiPLS/stXIQgEw901+UV2C25
         MiCPbEWbdAJp+zwGcik7yTrgP+Q/8dVV0CV/iVc5WY7opDkfUxZTvvtX+Bbn5IsHPIp8
         Q7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074551; x=1715679351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QwgYfRQeH2LZBoFYMj3QaS/pu39IjMn5T1SZZO1FiIg=;
        b=ZPPSvQCouoFvPGmENaLoHl+8iqPYBJUuDDbflBK6oWJL0t33aXfxGP3jlkRVn0Rb6P
         m4tVDWPrIvJbOoJDFJswE5f1jE7OnHoN5OkUwAooVHyGf2bIImn0IpAy9YDsoUgF/XBa
         dqBW6DeaN1n28X/hz7mfa9lWkAgt6m9rmrqrsethK9OQSERMED7epUR57zEJ0joNeQz3
         SvdJvxOpP1KTK1g/NYksMngua5HPypm8CtkQeJPvgWXg2ncuDl2Pu0YPWrrHgyFqUX6b
         E5m3HQlWKbzwghDWeXL6iv/rG2WUjkFlYllyF4F4LK7gMAOYvidnTmqxvLEE2ycM34JL
         zb/g==
X-Forwarded-Encrypted: i=1; AJvYcCUA0YpAtm9AcpIscFYjTwEFxr1cbrrDQVXu3od+XP7JUJBGPD0m910HhGAKlD6sOc+5QQRcnV9ccpl1ohiNtvsnfYGrRYrHx6Ff7kSw
X-Gm-Message-State: AOJu0Yx+WOxZ60chiT8Bc04s2zrok5LESh+OuUUK9RxVz7QIdCE3dIfC
	RttH8TfoxlTPdUKn3cvFF94x04JO/WnecbLK52TD5RYYxfzePJhc
X-Google-Smtp-Source: AGHT+IEpk0YG201j9uTFaKgX/2/QvGXXxyPYmpbGMIa2dQWtXy3VFHixmRjgHAflSWZemlMv04YvIQ==
X-Received: by 2002:a2e:a0d7:0:b0:2e2:1b1c:7462 with SMTP id 38308e7fff4ca-2e3d945ad29mr6199361fa.10.1715074551231;
        Tue, 07 May 2024 02:35:51 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:35:50 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 19/48] srcu: Make Tiny SRCU explicitly disable preemption
Date: Tue,  7 May 2024 11:35:01 +0200
Message-Id: <20240507093530.3043-20-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240507093530.3043-1-urezki@gmail.com>
References: <20240507093530.3043-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

Because Tiny SRCU is used only in kernels built with either
CONFIG_PREEMPT_NONE=y or CONFIG_PREEMPT_VOLUNTARY=y, there has not
been any need for TINY SRCU to explicitly disable preemption.  However,
the prospect of lazy preemption changes that, and the lazy-preemption
patches do result in rcutorture runs finding both too-short grace periods
and grace-period hangs for Tiny SRCU.

This commit therefore adds the needed preempt_disable() and
preempt_enable() calls to Tiny SRCU.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/srcutiny.h |  2 ++
 kernel/rcu/srcutiny.c    | 31 ++++++++++++++++++++++++++-----
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 447133171d95..4d96bbdb45f0 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -64,8 +64,10 @@ static inline int __srcu_read_lock(struct srcu_struct *ssp)
 {
 	int idx;
 
+	preempt_disable();  // Needed for PREEMPT_AUTO
 	idx = ((READ_ONCE(ssp->srcu_idx) + 1) & 0x2) >> 1;
 	WRITE_ONCE(ssp->srcu_lock_nesting[idx], READ_ONCE(ssp->srcu_lock_nesting[idx]) + 1);
+	preempt_enable();
 	return idx;
 }
 
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index c38e5933a5d6..5afd5cf494db 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -96,9 +96,12 @@ EXPORT_SYMBOL_GPL(cleanup_srcu_struct);
  */
 void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
 {
-	int newval = READ_ONCE(ssp->srcu_lock_nesting[idx]) - 1;
+	int newval;
 
+	preempt_disable();  // Needed for PREEMPT_AUTO
+	newval = READ_ONCE(ssp->srcu_lock_nesting[idx]) - 1;
 	WRITE_ONCE(ssp->srcu_lock_nesting[idx], newval);
+	preempt_enable();
 	if (!newval && READ_ONCE(ssp->srcu_gp_waiting) && in_task())
 		swake_up_one(&ssp->srcu_wq);
 }
@@ -117,8 +120,11 @@ void srcu_drive_gp(struct work_struct *wp)
 	struct srcu_struct *ssp;
 
 	ssp = container_of(wp, struct srcu_struct, srcu_work);
-	if (ssp->srcu_gp_running || ULONG_CMP_GE(ssp->srcu_idx, READ_ONCE(ssp->srcu_idx_max)))
+	preempt_disable();  // Needed for PREEMPT_AUTO
+	if (ssp->srcu_gp_running || ULONG_CMP_GE(ssp->srcu_idx, READ_ONCE(ssp->srcu_idx_max))) {
 		return; /* Already running or nothing to do. */
+		preempt_enable();
+	}
 
 	/* Remove recently arrived callbacks and wait for readers. */
 	WRITE_ONCE(ssp->srcu_gp_running, true);
@@ -130,9 +136,12 @@ void srcu_drive_gp(struct work_struct *wp)
 	idx = (ssp->srcu_idx & 0x2) / 2;
 	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
 	WRITE_ONCE(ssp->srcu_gp_waiting, true);  /* srcu_read_unlock() wakes! */
+	preempt_enable();
 	swait_event_exclusive(ssp->srcu_wq, !READ_ONCE(ssp->srcu_lock_nesting[idx]));
+	preempt_disable();  // Needed for PREEMPT_AUTO
 	WRITE_ONCE(ssp->srcu_gp_waiting, false); /* srcu_read_unlock() cheap. */
 	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
+	preempt_enable();
 
 	/* Invoke the callbacks we removed above. */
 	while (lh) {
@@ -150,8 +159,11 @@ void srcu_drive_gp(struct work_struct *wp)
 	 * at interrupt level, but the ->srcu_gp_running checks will
 	 * straighten that out.
 	 */
+	preempt_disable();  // Needed for PREEMPT_AUTO
 	WRITE_ONCE(ssp->srcu_gp_running, false);
-	if (ULONG_CMP_LT(ssp->srcu_idx, READ_ONCE(ssp->srcu_idx_max)))
+	idx = ULONG_CMP_LT(ssp->srcu_idx, READ_ONCE(ssp->srcu_idx_max));
+	preempt_enable();
+	if (idx)
 		schedule_work(&ssp->srcu_work);
 }
 EXPORT_SYMBOL_GPL(srcu_drive_gp);
@@ -160,9 +172,12 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
 {
 	unsigned long cookie;
 
+	preempt_disable();  // Needed for PREEMPT_AUTO
 	cookie = get_state_synchronize_srcu(ssp);
-	if (ULONG_CMP_GE(READ_ONCE(ssp->srcu_idx_max), cookie))
+	if (ULONG_CMP_GE(READ_ONCE(ssp->srcu_idx_max), cookie)) {
+		preempt_enable();
 		return;
+	}
 	WRITE_ONCE(ssp->srcu_idx_max, cookie);
 	if (!READ_ONCE(ssp->srcu_gp_running)) {
 		if (likely(srcu_init_done))
@@ -170,6 +185,7 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
 		else if (list_empty(&ssp->srcu_work.entry))
 			list_add(&ssp->srcu_work.entry, &srcu_boot_list);
 	}
+	preempt_enable();
 }
 
 /*
@@ -183,11 +199,13 @@ void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 
 	rhp->func = func;
 	rhp->next = NULL;
+	preempt_disable();  // Needed for PREEMPT_AUTO
 	local_irq_save(flags);
 	*ssp->srcu_cb_tail = rhp;
 	ssp->srcu_cb_tail = &rhp->next;
 	local_irq_restore(flags);
 	srcu_gp_start_if_needed(ssp);
+	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(call_srcu);
 
@@ -241,9 +259,12 @@ EXPORT_SYMBOL_GPL(get_state_synchronize_srcu);
  */
 unsigned long start_poll_synchronize_srcu(struct srcu_struct *ssp)
 {
-	unsigned long ret = get_state_synchronize_srcu(ssp);
+	unsigned long ret;
 
+	preempt_disable();  // Needed for PREEMPT_AUTO
+	ret = get_state_synchronize_srcu(ssp);
 	srcu_gp_start_if_needed(ssp);
+	preempt_enable();
 	return ret;
 }
 EXPORT_SYMBOL_GPL(start_poll_synchronize_srcu);
-- 
2.39.2

