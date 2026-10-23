Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792782371;
	b=pE13sNQjBEZoOzyLEUff/8Z+lqp12jsOBUo/KmfAUjGOK9sVy+U8OQAVZKTfT5BJMK+H
	 caIXB0zBQaTfM4zOi7K0F3TNRtOdocaOjzPz3GWu5zP6csNR8UqPO1W4GqPPU0i8WOWVv
	 TfS24EGOUfFTbrX1WgeYyUrDHCIp0ODi/TRCHgA2sfXcoxWlqa+79BLjgMpQlOBP92WlK
	 PDwQw+bqy6ybsEu8pdpxBAdRWjKofh9pMBA3wXjCuenUSV6GSy7R7WAlhpePrSQVUykeS
	 sK2sO6AWa24L57+Vi0AAqK9v64xFDZ4Kln7bI6TiLiqJmo73AXvaFxT1UFxTUMsEd1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792782371;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=jncnN8hNB149YV/7QR6pbWspMiNEL/g00PLfD5StrJE=;
	b=p5jHrCbWmHkE/SSJH+nXDJwYQuXl8xAhEcxdxnRqN4XqTaNCUi7goQeJKgu905XqResg
	 L1GI1ZMgxyqjHl/w0tNwX3Mr1RyF2Pe4ksOUb7Iymdu2qcGO5QXLDSHGHDNgtvNbZ1TST
	 nf29x5qkk2kYwbBfveSsprURp1rxzpnOcIp8T6z6p1hzgGiPC3wA8ZW9rm9gplfhp/rmZ
	 sQPicX3OjY+kv3hl8VyjmvpzTZIwegxfo4I+TJj44JDTFcSnGZitXMVhj7Pn1XkcRc7q0
	 sjD4Z7gZvGMq7Ake2O+7tEw2B5Gtji7xgX9PjPEi4rNpd3KzgS7LoIiAjKI5GnmPf7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Wbx66lod;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5FA606A326
	for <rcu@vger.kernel.org>; Fri, 23 Oct 2026 19:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A5FA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Wbx66lod
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-151ba226e1bso2590609c88.0
        for <rcu@vger.kernel.org>; Fri, 23 Oct 2026 12:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792782370; x=1793387170; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jncnN8hNB149YV/7QR6pbWspMiNEL/g00PLfD5StrJE=;
        b=Wbx66lodXz//uoQzGumIuDsdaKzKeTZj2vxASniPeWt1xrX0mU5N3QQEqMKZD8a7SV
         TYLTGpQRxn5xl3LOPmQ3Q3pkJw5k3wjK4FVUjiP7aBWSAouEeFOS0SOQIv6YvHaskA05
         Rybst7Z3U+4/kIOzZKjoBGoYMqaRCMYrIdbqRgrPXg5repVmXNOVAKk71r00QWUJTaAP
         UqL9+WQq/Rlge82XdYmoQgSPVjjeSXCqnw7XQqcPMVUcZA4xJy+NbL5LuxqH52ERliNc
         ikIuWZTSTbuwNkhG2QbS1AQPXZDzzYm4Ig9/URBwwKGBE3bQE4xi0S3SFai3YAsErLaU
         ymHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792782370; x=1793387170;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jncnN8hNB149YV/7QR6pbWspMiNEL/g00PLfD5StrJE=;
        b=uimRJR/xpWQgZZ0vMzXk155RfmuUIXHtkUK103Be9ZaAuqpuKIJb5JOoum1C/WrvUh
         rn3LurVAUvvu32L4P4D91K+vLAImrdlx4VGPh+uokuQfMHMKwNLqs5R0Yp13C0/X09U2
         TFfmG7m7BoLhA4O6kH0X6jHrxtOZIolQgRXhZqyxVHL2bkak/jdwyQA9vC/PIfYHMI4Q
         Iu/Xygs/VQtHxDHblawJW5Ybi7P8EwdvCO/mfzKPGUh1tI7sTrrMmLDn5YO1JvXhGSIf
         GURKiix0hGbcd/nupb1fwzRqVQk+EZse8091p0Hyfa+8sOzAGgFkTWrHmsKowcSGw1QV
         QJVA==
X-Forwarded-Encrypted: i=1; AKwUvBz5xn8NOajVrlqzoLivNbuNLN7sCKvCEFqvfGLPiIB/7lRrMV8OQtaG0PHe5uH9ADMh81I=@vger.kernel.org
X-Gm-Message-State: AFq9FYKXuo33O19QDImfJ7YGIi3ChLFwilUpKN7dMUeqsK+UJdVa8xr9
	myMHhd1zLAfXVQS/mCszqbFTPDTy+VOzEWRHiVeE+dUY2wwpE9B12d9L/+DnOyT4SuzWHpj4AuR
	+0Nek+G1Rvw==
X-Received: from dlbut14.prod.google.com ([2002:a05:7022:7e0e:b0:197:4f80:9b9a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4388:b0:185:fd0c:4585
 with SMTP id a92af1059eb24-195c7b7c1cemr5635614c88.33.1792782369901; Fri, 23
 Oct 2026 12:06:09 -0700 (PDT)
Date: Fri, 23 Oct 2026 12:05:51 -0700
In-Reply-To: <20261023190558.3050796-1-irogers@google.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022203003.1779152-1-irogers@google.com> <20261023190558.3050796-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261023190558.3050796-5-irogers@google.com>
Subject: [PATCH v7 04/11] perf lock contention: Extend get_lock_owner() for
 rt_mutex and mutex handoff
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ddhariwal@google.com, eranian@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Extend get_lock_owner() in tools/perf/util/bpf_skel/lock_data.h to:
- Support rt_mutex locks (LCB_F_RT) and CONFIG_PREEMPT_RT mutexes via
  struct rt_mutex_base and struct rt_mutex___old, masking out the low
  waiter bit (0x1UL).
- Return NULL when a mutex has MUTEX_FLAG_HANDOFF (0x4UL) set on
  owner.counter and is in the middle of being handed off rather than
  actively held.

Also add rw_semaphore.count and struct rt_mutex_base to the fallback
tools/perf/util/bpf_skel/vmlinux/vmlinux.h.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_skel/lock_data.h       | 62 ++++++++++++++++++----
 tools/perf/util/bpf_skel/vmlinux/vmlinux.h |  5 ++
 2 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_skel/lock_data.h
index 91d464ac18bd..43d8f5030bc1 100644
--- a/tools/perf/util/bpf_skel/lock_data.h
+++ b/tools/perf/util/bpf_skel/lock_data.h
@@ -104,11 +104,24 @@ extern struct rq runqueues __ksym __weak;
 # define __has_builtin(x) 0
 #endif
 
+struct mutex___non_rt {
+	atomic_long_t owner;
+} __attribute__((preserve_access_index));
+
+struct rt_mutex_base___new {
+	struct task_struct *owner;
+} __attribute__((preserve_access_index));
+
+struct rt_mutex___old {
+	struct task_struct *owner;
+} __attribute__((preserve_access_index));
+
 struct rw_semaphore___old {
 	struct task_struct *owner;
 } __attribute__((preserve_access_index));
 
 struct rw_semaphore___new {
+	atomic_long_t count;
 	atomic_long_t owner;
 } __attribute__((preserve_access_index));
 
@@ -146,9 +159,25 @@ static __always_inline struct task_struct *get_lock_owner(__u64 lock, __u32 flag
 	__u64 owner = 0;
 
 	if (flags & LCB_F_MUTEX) {
-		struct mutex *mutex = (void *)lock;
-
-		owner = BPF_CORE_READ(mutex, owner.counter);
+		struct mutex___non_rt *mutex = (void *)lock;
+
+		if (bpf_core_field_exists(mutex->owner.counter)) {
+			owner = BPF_CORE_READ(mutex, owner.counter);
+			if (owner & 0x4UL)
+				return NULL;
+		} else if (bpf_core_type_exists(struct rt_mutex_base___new)) {
+			struct rt_mutex_base___new *rtm = (void *)lock;
+
+			owner = (__u64)BPF_CORE_READ(rtm, owner);
+			return (void *)(owner & ~1UL);
+		} else {
+			struct rt_mutex___old *rtm = (void *)lock;
+
+			if (bpf_core_field_exists(rtm->owner)) {
+				owner = (__u64)BPF_CORE_READ(rtm, owner);
+				return (void *)(owner & ~1UL);
+			}
+		}
 	} else if (flags == LCB_F_READ || flags == LCB_F_WRITE) {
 	/*
 	 * Support for the BPF_TYPE_MATCHES argument to the
@@ -158,20 +187,35 @@ static __always_inline struct task_struct *get_lock_owner(__u64 lock, __u32 flag
 	 */
 #if __has_builtin(__builtin_preserve_type_info) && __clang_major__ >= 15
 		if (bpf_core_type_matches(struct rw_semaphore___old)) {
-			struct rw_semaphore___old *rwsem = (void *)lock;
+			struct rw_semaphore___old *old = (void *)lock;
 
-			owner = (unsigned long)BPF_CORE_READ(rwsem, owner);
+			owner = (unsigned long)BPF_CORE_READ(old, owner);
 		} else if (bpf_core_type_matches(struct rw_semaphore___new)) {
-			struct rw_semaphore___new *rwsem = (void *)lock;
+			struct rw_semaphore___new *new = (void *)lock;
 
-			owner = BPF_CORE_READ(rwsem, owner.counter);
+			owner = BPF_CORE_READ(new, owner.counter);
 		}
 #else
 		/* assume new struct */
-		struct rw_semaphore *rwsem = (void *)lock;
+		struct rw_semaphore___new *new = (void *)lock;
 
-		owner = BPF_CORE_READ(rwsem, owner.counter);
+		if (bpf_core_field_exists(new->owner.counter))
+			owner = BPF_CORE_READ(new, owner.counter);
 #endif
+	} else if (flags == LCB_F_RT) {
+		if (bpf_core_type_exists(struct rt_mutex_base___new)) {
+			struct rt_mutex_base___new *rtm = (void *)lock;
+
+			owner = (__u64)BPF_CORE_READ(rtm, owner);
+			return (void *)(owner & ~1UL);
+		} else {
+			struct rt_mutex___old *rtm = (void *)lock;
+
+			if (bpf_core_field_exists(rtm->owner)) {
+				owner = (__u64)BPF_CORE_READ(rtm, owner);
+				return (void *)(owner & ~1UL);
+			}
+		}
 	}
 
 	if (!owner)
diff --git a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
index 94e42b022ab1..b75ddc6846bb 100644
--- a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
+++ b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
@@ -76,6 +76,7 @@ struct signal_struct {
 } __attribute__((preserve_access_index));
 
 struct rw_semaphore {
+	atomic_long_t count;
 	atomic_long_t owner;
 } __attribute__((preserve_access_index));
 
@@ -83,6 +84,10 @@ struct mutex {
 	atomic_long_t owner;
 } __attribute__((preserve_access_index));
 
+struct rt_mutex_base {
+	struct task_struct *owner;
+} __attribute__((preserve_access_index));
+
 struct kernfs_node {
 	u64 id;
 } __attribute__((preserve_access_index));
-- 
2.56.0.307.g5fe7bd680c-goog

