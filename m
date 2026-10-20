Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792529957;
	b=XUP/GqEfTBVYIkiQ1jaq6wEhk6Jw4bfV77496+03Znc019ROYglLsGulzmW4ZkuQ1Z62
	 0LsaNVdDTCaujHqr6TP9chsItHTBz7zJs8ZZ3UreDGV3XNdeLwghYBNx3Hm3Mgi6RDNJh
	 Th1+SRczAPHa4GVZuHbB1osqxYGrBwu6XuH1XaYTWEnMC6f0qMjQUhEEBeqCH2ukrupTK
	 C2Kf35rTJOyQpyUUa7LOGaTjT0/H0SPIDZnbGxtQpoAHfdY8mcgAyL4pclKaOJwCeN+/k
	 JNw1ofE+O07FTHrlweMkB9yLDG4mpNYw5AXFeSMoT9wIq+ds1vOa1Z1xFYgPbmrNUPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792529957;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=N2qanCyCB4wF+VeUcB92quptg8ph71hHc9UNhycwS8A=;
	b=heR7hpsCwxsDdgj+Y3LHrpoPF+Nek4IQ11Qq0AnBCe4Ac3crVzw3FBEhLhOB57DMuFfr
	 qicwv6kSJaXjChuNmnaZijQ8KChdc5ZKViQQ1ihwiyjeNQNcSA7i8nvrN9hM+MzAkwYFR
	 FCP/FEFUhw4dUVSbAGYJ3CXIU8HcCKL2gHtKKl5bVH79j+EIF64VJmaeQVYQM6eosOgIV
	 /e0hyKMDt1N4MZ/L2xBkPIs2kN2fyr90RUp0++ptvTl4UDUjRVWvhfhErikqBsiFBfCBX
	 4DvSQVM2QuUfeV0ExWkB+BfTN4SDkPmleLZMHMXV/Had9kWH/rAugffevV/vrwAqrvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=AY8qpXwL;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E400D606A31E
	for <rcu@vger.kernel.org>; Tue, 20 Oct 2026 20:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E400D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=AY8qpXwL
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-18b5ee75447so112683c88.1
        for <rcu@vger.kernel.org>; Tue, 20 Oct 2026 13:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792529956; x=1793134756; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N2qanCyCB4wF+VeUcB92quptg8ph71hHc9UNhycwS8A=;
        b=AY8qpXwL36PexW/e1AxUNktCFLv+opVByRmFWFpezDMwVrRGpBgJBa+rIGtOd9A3Kx
         +zmL+3J15aWqZIhlurvVna4Fq6NND4E90sAS3GRsUp0siz38WXWvw2WGm/kcwR3ZOIJR
         wgNdf2ZRhVKmzS3jqmwwhyUgsxVztsd/ORNULc68Nasu9ZoAlYRITuxZRafk/mN4mc0X
         9L7c65wxcNF/yKIM2kmVTq7a1ksE4D+IU1lyCFAEW3qzZXWW/M4ENdn4ukXImqz9tQ33
         wSO1tuYsV/J1IimK1MWPRYxvtYjZGvmevlJ+hHDaOgO5sJBJAUUzdF7uifVebdf5Vd4u
         Qf7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792529956; x=1793134756;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N2qanCyCB4wF+VeUcB92quptg8ph71hHc9UNhycwS8A=;
        b=k5okDTSzxdmcsgTvkqCNPfDo2sbQphwPqyo6QZk7XhUX+/sO3iqjkJGTfLAnsXiXGq
         6K3ntVvcTXVqFrH01SbaW2GMlnjK74CHuN1bURrYUfZnI6tlcDslHIyhr/EAZ7vdxlbM
         BQEyGqHK4PeD4ZMr2O4pK5Bl6UOGdmil3nFPJG1vKv6k7LxUSc5Gjas40sCGCJFeDeN9
         wLA1TC2FHHZU3gkb3nuj3KLmA8WMfPRYo5w9lGdgFhorjsGFkAe6q3pQs3N63gEMKu6M
         89shfB+o3YXISJDvgDiJsz+hTaAdYUh2st/F9rzgFBH53DZ3i9dCx4Pqym6Jj+iu87ZB
         2GAA==
X-Forwarded-Encrypted: i=1; AKwUvBwM6TNQhItIVrhEzOdTk0Ex/NpUwv+UV1yjeku7380EjVDrA1g3zzN+MGffqaurcEjc5xM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIocvzzXqRqYpbPnh2WA8n28UJ7Tx/k5btd5IKjyQYDASUriVM+
	rtCOetulUQ8Yb1Fs5Izuz8x0YbydlDCuefqSog9lH9EpL32YRya3GW/N06yW2ehR9n4UWzwG6vA
	PDPlFhzt7+w==
X-Received: from dlbvs4.prod.google.com ([2002:a05:7022:3f04:b0:17e:6ff3:49a4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:eb45:10b0:16b:fdbf:4a9c
 with SMTP id a92af1059eb24-190a599a3c5mr19499c88.23.1792529955721; Tue, 20
 Oct 2026 13:59:15 -0700 (PDT)
Date: Tue, 20 Oct 2026 13:58:51 -0700
In-Reply-To: <20261020205859.1080743-1-irogers@google.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261019220915.3943592-1-irogers@google.com> <20261020205859.1080743-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261020205859.1080743-2-irogers@google.com>
Subject: [PATCH v5 1/8] perf lock contention: Filter events before creating lock_stat
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ddhariwal@google.com, eranian@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In report_lock_contention_begin_event(), lock_stat_findnew() was
called before checking filters.nr_types (-Y), filters.nr_addrs (-L),
and match_callstack_filter() (-S).

When a filtered-out lock event (such as a mutex contention when
running with -Y spinlock) shared the same aggregation key as a
subsequent matching event (for example, contention on the mutex's
internal wait_lock spinlock from the same caller), the first event
created the lock_stat entry with the filtered-out lock's flags and the
second event reused that entry, causing non-spinlock entries to appear
in -Y spinlock output.

Check the type, address, and callstack filters before looking up or
creating the lock_stat entry.

Fixes: b4a7eff93c39 ("perf lock contention: Add -Y/--type-filter option")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-lock.c | 61 +++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index d5c0d55cb82d..778923c92f42 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -975,6 +975,7 @@ static int report_lock_contention_begin_event(struct perf_sample *sample)
 	struct machine *machine = &session->machines.host;
 	struct map *kmap;
 	struct symbol *sym;
+	u64 *callstack = NULL;
 
 	ret = get_key_by_aggr_mode(&key, addr, sample);
 	if (ret < 0)
@@ -1010,33 +1011,6 @@ static int report_lock_contention_begin_event(struct perf_sample *sample)
 		}
 	}
 
-	ls = lock_stat_find(key);
-	if (!ls) {
-		char buf[128];
-		const char *name = "";
-
-		switch (aggr_mode) {
-		case LOCK_AGGR_ADDR:
-			sym = machine__find_kernel_symbol(machine, key, &kmap);
-			if (sym)
-				name = sym->name;
-			break;
-		case LOCK_AGGR_CALLER:
-			name = buf;
-			if (lock_contention_caller(sample, buf, sizeof(buf)) < 0)
-				name = "Unknown";
-			break;
-		case LOCK_AGGR_CGROUP:
-		case LOCK_AGGR_TASK:
-		default:
-			break;
-		}
-
-		ls = lock_stat_findnew(key, name, flags);
-		if (!ls)
-			return -ENOMEM;
-	}
-
 	if (filters.nr_types) {
 		bool found = false;
 
@@ -1066,7 +1040,7 @@ static int report_lock_contention_begin_event(struct perf_sample *sample)
 	}
 
 	if (needs_callstack()) {
-		u64 *callstack = get_callstack(sample, max_stack_depth);
+		callstack = get_callstack(sample, max_stack_depth);
 		if (callstack == NULL)
 			return 0;
 
@@ -1074,7 +1048,38 @@ static int report_lock_contention_begin_event(struct perf_sample *sample)
 			free(callstack);
 			return 0;
 		}
+	}
+
+	ls = lock_stat_find(key);
+	if (!ls) {
+		char buf[128];
+		const char *name = "";
+
+		switch (aggr_mode) {
+		case LOCK_AGGR_ADDR:
+			sym = machine__find_kernel_symbol(machine, key, &kmap);
+			if (sym)
+				name = sym->name;
+			break;
+		case LOCK_AGGR_CALLER:
+			name = buf;
+			if (lock_contention_caller(sample, buf, sizeof(buf)) < 0)
+				name = "Unknown";
+			break;
+		case LOCK_AGGR_CGROUP:
+		case LOCK_AGGR_TASK:
+		default:
+			break;
+		}
+
+		ls = lock_stat_findnew(key, name, flags);
+		if (!ls) {
+			free(callstack);
+			return -ENOMEM;
+		}
+	}
 
+	if (callstack) {
 		if (ls->callstack == NULL)
 			ls->callstack = callstack;
 		else
-- 
2.56.0.212.g129ede20d9-goog

