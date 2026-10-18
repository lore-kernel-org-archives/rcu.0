Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24A93815DF
	for <rcu@vger.kernel.org>; Sun, 18 Oct 2026 05:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792301848; cv=none; b=JXtSxYg82GGSC4c4W0Lsb+6+WXXDWAIS/zXvHNEeIfYcY7h3oYxAmSZ1MULku25etsmgHxklSWvJrZvTueFxu8olFRF3nNRkN4Vxhs0h9wRb8gConDSmvFe5facUwBIq2tFAgX9Fr1q+JcSjaFQDpwrbW00FKV+/e66Lsb5MiY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792301848; c=relaxed/simple;
	bh=uokLC2qlLF+9ChVHKEpQopcIETaLyPNftkNvpg1ZlTw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DEhjIAY55mmn7vr+RePQIO5HvxntiCajtalkg/v6VtXEndFdN4rJiRhup673hEYvgRUX/L9XDRm2qZkt44ZbNcxfZSnN0Q9vBdMdtLQfy87YCjz2W/Kk6zPHJ5+OeeKRi7xNZHGlPvTBQlK6oJGfH8W2LY/Y6l4gksuAdrS00Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rdgV+yaQ; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rdgV+yaQ"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30c0d568830so2214691eec.1
        for <rcu@vger.kernel.org>; Sat, 17 Oct 2026 22:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792301846; x=1792906646; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k6rbYgJtpogYS2iBX/OmTFqvNw2SHl7qSWa7Dowcz9k=;
        b=rdgV+yaQFm6GYHHmJ4wOrMnq+ct04qMkb8tiPS1Oabu0g7cV9s4VPifnt8dOOvxlv/
         6YsiB3GSaNsx4enetTSQ8NM9nWlsG86XjdGf9BHaBXtQbWLuXMxVTm22dgNfhw3oPXNB
         EnQRXlVpOeFzQxfrTi/RWCN+sM9wSrmSRh5Ab1jsAkxPJ2/jdyQEJxHBl6nAZIMbV9RO
         FJ2byZDS4foVZdumSPfg1DLimp13IIqDaiS542YVCh8dWL9iRwYLBjOkHv0++Kj5sM/A
         8Sloxidpter2wmR6kNha9aXnYMXiMGHqafwQuG95hD5FMhU6Xh0+QBAQj2LDwAQ6VbBv
         axPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792301846; x=1792906646;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k6rbYgJtpogYS2iBX/OmTFqvNw2SHl7qSWa7Dowcz9k=;
        b=uoW7U3EKZGJFfS5zAUNHpvvdagbWmxL5ESJMP/zFkqJgfo1sJ1nRfNBe+b+7h5FldA
         EL8YjdzsESo0rJoORq/ske/CNPsrurt20Pcpxz4hDz5JD9EL77w2B+q+Q5qEIBpRuEKN
         jXJO94lF+kQzP1EU5vLWoZjgk8xVYeVWN9oG9hyWvY6Bfh9RjM92pxd+h9u8YUw6kPqd
         QKcZoK2+DQnYMmgJOTQj69rSQniYfr5arDuMyLgwWLVmNDFEkQ/gfxfad5wqXyLYjrbq
         mD1gO799mN0fNGXMMaBQ0RRWdm8JGY8qr3xaeKK+Sjtjq5J0iNA+E5ffZt5qUtrEL5H0
         WAKg==
X-Forwarded-Encrypted: i=1; AKwUvBxYmI2+4XieRBEwnjX9iFnXBKWidat7fKMMvIYE8eefZoolSonW1MKNFYmiDKuPhN9YAJY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIHBXwG2sAqrI7dHzScOGcbhzQHWJ7A/LWAhDD3yOtGqsN8/wti
	xkswUxRjQ1cEOmJ6XByIAd8brxuf3T/8PwhjxvS05BVF5vAFcVIvbIrMivbgEekez3n/zjNFtC+
	T2uC8HYBL+w==
X-Received: from dykf4.prod.google.com ([2002:a05:7300:6904:b0:33e:5767:2163])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:6197:20b0:34e:f948:d7da
 with SMTP id 5a478bee46e88-361a196124amr6936271eec.21.1792301845657; Sat, 17
 Oct 2026 22:37:25 -0700 (PDT)
Date: Sat, 17 Oct 2026 22:37:10 -0700
In-Reply-To: <20261018053710.2572636-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261017171437.2066343-1-irogers@google.com> <20261018053710.2572636-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261018053710.2572636-7-irogers@google.com>
Subject: [PATCH v3 6/6] perf lock contention: Filter events before creating lock_stat
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, rcu@vger.kernel.org
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
index feaf1cfd08cf..a031709a2cc2 100644
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

