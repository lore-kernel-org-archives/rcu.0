Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559A9329377
	for <rcu@vger.kernel.org>; Wed, 14 Jan 2026 18:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415662; cv=none; b=SisobSi9M0ZLkGcdtPaFb7d1kOvytcnjrlGG5b6+hiXzyalM7dAcVP2lx/OqzQQNG+clGolNf88gSYlUJSJVyl0lEEFjtzWOY/MD28X69/5K9GDy7lyRk3PkPxmZKOF6SbjfHN90/9KsztnVI3g3lK5UCpP2Mm1s3ye/ao5+p0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415662; c=relaxed/simple;
	bh=KZ6jA9OgWKzFSS9WndGq9wCP7OCFnoFubnkro8EsDTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nbBI8fyPZPsww56iAoDqByqVH1kYtgeOl4Sl2dfVJni6dOsI80O4VcGBap0UUfM6dV5DRILH33GPT3lvT67c68HM/J+rIqyNcS4DftGVmbAtmZdR24PollRJDPPkzSuSc+d9HWQwXgXQtsiG32olip4yoRzU4WOYZ8GmxGETwas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zgyp4/8p; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zgyp4/8p"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59b76c092acso111658e87.2
        for <rcu@vger.kernel.org>; Wed, 14 Jan 2026 10:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768415658; x=1769020458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CUPAgkqqJq6WozfacWaQbbhzVEXuv7nVNXJfVf9PrLw=;
        b=Zgyp4/8pRu835dOm9qPJBBCWGvOXvmJEpBonkBYboLFOafdiVVvOkDpJxgClgss4is
         YkwpYNC5nEvyc/erF9dD9upOxN403dMI+ots66OTaJDVsJ+Nk3B42Pf/jvYU49g69wKe
         OASIQbyNMdbrKWrznZXY2BY69X+XuHpZMby/JzgEXWvm8jpDF2CZiyIhS5WER+sI9ggx
         YhiappHyES8snkut7VteFjedLGG8XlCte77Xr+ztG7yGUZFZFJ22Zvt78mLE6Bn8RDI8
         tloTAL7IaJLYFpilawhffOCK2V0TLNoWJyB4POhgoVXIpjDbKbzOiA6o7LYqpZQja3XA
         Fvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768415658; x=1769020458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUPAgkqqJq6WozfacWaQbbhzVEXuv7nVNXJfVf9PrLw=;
        b=OT2yBfeAWlIQLx2AIDJIXRZcvoXGinpTe7KGMaUDzfQMPY/rBqQAsQWJCjYZgL13fv
         lbblcQrGaUKiFmYpk+SYUpo52SFRIfTbRcoHLkdFSGG2PgN4hXQLIxRQAH6QpPw1V1g9
         WwXzeaU4TDCBytbZSanrYRXRna1itaNO+zIclaGxr9vgjQZxvppFHnisyI9lM3n06Rbo
         l6tVC9kyNPl0vbPswIkainl6kgKSWM7zQmqqyDQmti8+ocXGJGEgpDhKk372x7UFCThe
         OO2wxQcEkYYSxyCIzLXMFNgQgP3cXFYiGtDqprCiP173LanCeg3fvacz4qmNwvNI8uxI
         Vljw==
X-Forwarded-Encrypted: i=1; AJvYcCVqMxYQTAzKJyi+Qxl7Gn1XegMYq+cM77HgDLbah08gXrjt2ALTL8xmmKxlN4ai1THFIkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqTtwbkGfBLNsd4XoewgCDd0whVdbM/NLAx2OWPGrEjRtraW5x
	L/XvO/9iAcuDbNJlOlsRTp72L5/WuCzx3P7IjATOqAXO3pk5HrW5ITmz
X-Gm-Gg: AY/fxX5gDujXxNXYdU1dpWBTd+krAHtU1SHTPq21nJ6JkCKaW/BD8bvUET94uHh1eey
	9geMP8HL8VRp++N95QFeZFtJflLnEzjcpBumeFxdY9r2p21X126Q56lu26TTEtC30EaS5hfkTrF
	jnZG0HXR1P1FFTU/zALlTZWfg+Z4WIGxXZnDcdPUdqlGUXiSTq/J6d4bZJEHsuTInsWc3Are10k
	NQzwuffssOOCwDVL6v0tSIsj7YllbLTYkS9suiMwLmvekC67qE9uR1pk5CjJdqW23cX0J71aTK1
	d86LBSS4TN9nrBV1iMH0HZD/DH1d6masPG1bthG60OdJ4WSjlJBx74NkkYo+5lgK8lYvYkaI5D5
	5CddlWw4haM0H/UfdyfgOFOiNDd0CHcra5egco7q1g+h7+TkbhjKZCZtaBXYaesJB2AkCCAl7lV
	dThIw=
X-Received: by 2002:a05:6512:ad6:b0:598:eed6:4975 with SMTP id 2adb3069b0e04-59ba1752d33mr999594e87.48.1768415657414;
        Wed, 14 Jan 2026 10:34:17 -0800 (PST)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59ba1045bbdsm917730e87.78.2026.01.14.10.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 10:34:16 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Vishal Chourasia <vishalc@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH] rcu: Latch normal synchronize_rcu() path on flood
Date: Wed, 14 Jan 2026 19:34:15 +0100
Message-ID: <20260114183415.286489-1-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, rcu_normal_wake_from_gp is only enabled by default
on small systems(<= 16 CPUs) or when a user explicitly set it
enabled.

This patch introduces an adaptive latching mechanism:
 * Tracks the number of in-flight synchronize_rcu() requests
   using a new atomic_t counter(rcu_sr_normal_count);

 * If the count exceeds RCU_SR_NORMAL_LATCH_THR(64), it sets
   the rcu_sr_normal_latched, reverting new requests onto the
   scaled wait_rcu_gp() path;

 * The latch is cleared only when the pending requests are fully
   drained(nr == 0);

 * Enables rcu_normal_wake_from_gp by default for all systems,
   relying on this dynamic throttling instead of static CPU
   limits.

Suggested-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 293bbd9ac3f4..c42d480d6e0b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1631,17 +1631,21 @@ static void rcu_sr_put_wait_head(struct llist_node *node)
 	atomic_set_release(&sr_wn->inuse, 0);
 }
 
-/* Enable rcu_normal_wake_from_gp automatically on small systems. */
-#define WAKE_FROM_GP_CPU_THRESHOLD 16
-
-static int rcu_normal_wake_from_gp = -1;
+static int rcu_normal_wake_from_gp = 1;
 module_param(rcu_normal_wake_from_gp, int, 0644);
 static struct workqueue_struct *sync_wq;
 
+#define RCU_SR_NORMAL_LATCH_THR 64
+
+/* Number of in-flight synchronize_rcu() calls queued on srs_next. */
+static atomic_long_t rcu_sr_normal_count;
+static atomic_t rcu_sr_normal_latched;
+
 static void rcu_sr_normal_complete(struct llist_node *node)
 {
 	struct rcu_synchronize *rs = container_of(
 		(struct rcu_head *) node, struct rcu_synchronize, head);
+	long nr;
 
 	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) &&
 		!poll_state_synchronize_rcu_full(&rs->oldstate),
@@ -1649,6 +1653,15 @@ static void rcu_sr_normal_complete(struct llist_node *node)
 
 	/* Finally. */
 	complete(&rs->completion);
+	nr = atomic_long_dec_return(&rcu_sr_normal_count);
+	WARN_ON_ONCE(nr < 0);
+
+	/*
+	 * Unlatch: switch back to normal path when fully
+	 * drained and if it has been latched.
+	 */
+	if (nr == 0)
+		(void)atomic_cmpxchg(&rcu_sr_normal_latched, 1, 0);
 }
 
 static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
@@ -1794,7 +1807,14 @@ static bool rcu_sr_normal_gp_init(void)
 
 static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
 {
+	long nr;
+
 	llist_add((struct llist_node *) &rs->head, &rcu_state.srs_next);
+	nr = atomic_long_inc_return(&rcu_sr_normal_count);
+
+	/* Latch: only when flooded and if unlatched. */
+	if (nr >= RCU_SR_NORMAL_LATCH_THR)
+		(void)atomic_cmpxchg(&rcu_sr_normal_latched, 0, 1);
 }
 
 /*
@@ -3268,7 +3288,8 @@ static void synchronize_rcu_normal(void)
 
 	trace_rcu_sr_normal(rcu_state.name, &rs.head, TPS("request"));
 
-	if (READ_ONCE(rcu_normal_wake_from_gp) < 1) {
+	if (READ_ONCE(rcu_normal_wake_from_gp) < 1 ||
+			atomic_read(&rcu_sr_normal_latched)) {
 		wait_rcu_gp(call_rcu_hurry);
 		goto trace_complete_out;
 	}
@@ -4892,12 +4913,6 @@ void __init rcu_init(void)
 	sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
 	WARN_ON(!sync_wq);
 
-	/* Respect if explicitly disabled via a boot parameter. */
-	if (rcu_normal_wake_from_gp < 0) {
-		if (num_possible_cpus() <= WAKE_FROM_GP_CPU_THRESHOLD)
-			rcu_normal_wake_from_gp = 1;
-	}
-
 	/* Fill in default value for rcutree.qovld boot parameter. */
 	/* -After- the rcu_node ->lock fields are initialized! */
 	if (qovld < 0)
-- 
2.47.3

