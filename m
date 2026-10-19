Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792447767;
	b=aT4+CNjZQrWWEn0nUT3uJDz00OAYvmIKjfKywEx9n6TVhcGTMFtYHim7BnV6F3yw7zTe
	 mjF9Xzy0Vmn9aPTPecv7oqQYRwO4CVYdlnQyeVT+ZIh80zMfAP86jUmuajU1+ek1GsGIi
	 uczu4FeifR0Fo8PfRLUjhnkxfA44DQHxScFhlvUFH4Dy833vP7TDyqbk/oNK7uykmdE5R
	 YnXJ14RlhI1f2Y4Dup58SW20Y9/2nc/PB0jsv5MX+OuLJf85/hSZRkEEmHG9TIsLbzMVX
	 M0JvqhI/zfSaL0bgRquxXoVQ9weyIgcCXerHygPtz08KPGLF056koqGyunUuSjgY4nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792447767;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=N2qanCyCB4wF+VeUcB92quptg8ph71hHc9UNhycwS8A=;
	b=Ajh17U1I1zlN19Zmnv31Q0PzNKO4IdvLEY/G1GJaUrw8fbfKALABDzetsNCSvYSx7nKS
	 HosdNUfIas2Fz9t+8uK/ulofgYfEGDcbG/v4A1MYDhtJiL1f5zMhhyF/dLx0yWE/pLQCw
	 cyvQqn/KYtlSIwce0gku+1GccT+dEKbodnhFlNFT+aDBUzwmLn/GCxmCZCt00wqHul4AL
	 QKMHjnDbAPOj0wHh5dKsNkCdnHwtN/ZzJp1KKHQotnrT/ejGWEZbvmc2YeIkkON2yUowb
	 lGwxEkNAgI+2RSgNUsLPQ3Itzj9haQ4TQzeKd2p8smyI8+KqoXdyJys+N6+S8qu/ogg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=rcQJLAh4;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A326A606A331
	for <rcu@vger.kernel.org>; Mon, 19 Oct 2026 22:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A326A606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=rcQJLAh4
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-151ba226e1bso4224423c88.0
        for <rcu@vger.kernel.org>; Mon, 19 Oct 2026 15:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792447766; x=1793052566; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N2qanCyCB4wF+VeUcB92quptg8ph71hHc9UNhycwS8A=;
        b=rcQJLAh4hS0F68nRiE4luxc/Yiz5cSRCBcQVnBajuzQLAffpfIoUJKLjft/y4sDELn
         P77MAc82f2J/CC44aetKrqqebF4XCFkHmT5HJoBlvGktzPSFnmbKYgFnTfR4JOP728lI
         MKCYHmJw7V82PoXc4X3xuKbRgLu8/37OrXl8dC3OEl4m1/bhG+GawQRmTpS6+Z70so5O
         au2/sNLV6fojKeZqEFUEukQB3fafOi1jvpb2OAvugKt3R67JJWqksnbyMV3rUIdNPr+h
         SfvhOP6o74tsv5rsuVzvZdpvQRa1vFMnaYr46jNORpujOlau6dK+K7jiysP6yfZPiKPN
         6kEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792447766; x=1793052566;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N2qanCyCB4wF+VeUcB92quptg8ph71hHc9UNhycwS8A=;
        b=cdkVT8VqEswmLe8P7GLX9oEWdfKeJN/cF17t925uXDn+iAZlrnklkZkoDD8CMgOiMT
         ZGnFuIm9IK43KO5Zt5CraG+ylR1B+jDLftNJEn9ZwlOqzFaNDdx51PbBFR7f9JYFi8Ic
         MktiWH5RGs49A+nEdCejhDIp/tiNsbr1/c0jx8FleCPlhOr5aktG7wqqw77Z5gV5I3WK
         VxnY16HZFFNwgyzCCRp4Vi2p9MyQFJAAK5Cf8OX6eenRQ0znXyhOi/ksjbgThb8wnoIq
         Dl8j67mEefXJiuXsVDxOBqhEsrgbuDvuLTNxWSJruAiNxrYWT0akw3egDv0VBuBZIVH3
         paYg==
X-Forwarded-Encrypted: i=1; AKwUvBzoyPrv2GVPi0JP7sTd/39QXKrbiM44tM/O1iOfju+ciXJcmbPrQf0+HC0IgEMzXRGfSSU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKjurVRHxuyG6/UtIrl2ea15Xz9n8/wAqt/WIH5T2dlGT8DgL62
	+F/uLJHz5GUior9/eIVSREPFtHuaVSZYJ5EY9maV0mr6K/hmOFxqYXNUxi8Gleox9QMMazaYbI0
	/BeAHtQKL+g==
X-Received: from dlbut6.prod.google.com ([2002:a05:7022:7e06:b0:15a:d2bd:6a16])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f90e:b0:151:2e62:fe6e
 with SMTP id a92af1059eb24-185136cd2ffmr11801307c88.19.1792447764591; Mon, 19
 Oct 2026 15:09:24 -0700 (PDT)
Date: Mon, 19 Oct 2026 15:09:09 -0700
In-Reply-To: <20261019220915.3943592-1-irogers@google.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261018053710.2572636-1-irogers@google.com> <20261019220915.3943592-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261019220915.3943592-2-irogers@google.com>
Subject: [PATCH v4 1/7] perf lock contention: Filter events before creating lock_stat
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, eranian@google.com, 
	ddhariwal@google.com, rcu@vger.kernel.org
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

