Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A01434DB59
	for <rcu@vger.kernel.org>; Fri, 19 Dec 2025 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766159236; cv=none; b=AOYg9g92BzVdcRxz0NVRyFn6LOgCN8KCZRsg+Vl60U6oV9myGX9mcB0Gd6ECxQ35QhniHc7P1k8PRczen0PRFdQWjBxwEQ95OV3Li8EvTuEyn8uQMSK/r6rq4l3IRtem4ymQIOmBMHBBZep4AeDWqBUvzBJ/9V9iXsIm23uH72E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766159236; c=relaxed/simple;
	bh=3+1d1G/TatPrxyV3VzGXDrwt3WtPBe3HR66XpxkDFKg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=coqZVZako9qzh2P/iYFdHi3ClroO35PHxGueOsrT69i6X1s2FNE9KGc5UB6YAoZFulrw7LVselCLyODnOQVo7IfSDp5djfmX1Y03Orj4kQeRyiKmqlu4S+IvWZazXQapVERa8MCcwSDeecweSXuwwn+EJh4nPQY1Vfmcd/otKLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0m/GHlY3; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0m/GHlY3"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47a97b785bdso13262645e9.3
        for <rcu@vger.kernel.org>; Fri, 19 Dec 2025 07:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766159231; x=1766764031; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J3sgEnhMWMLOYj1/OofGWKavVFtW6YP1ndiLQ0rOu/8=;
        b=0m/GHlY36oQ/kxG6wRubIwqc/3eUWJZficSwTqC0bg4HFyCqiW6viqoE95js/ug+jP
         3We+VQnUdVAX7dTqMPzQ0LMQPJI5JmANiOIUfrfPUze7nbxdZjPnNk6O9t0fTRQsZMj8
         tluic8MJxkthfvo4J/+xbU/VyF8oCB+O2BhQN8FZhmEMIs+fpREbPnJ3M4RPRayn2wFR
         100KTfBeWKV0YI98oO5FEvutHu8IfLetEitJSSxN4sV7byVWDiIEiPYjF+bJcew9xzIX
         wt/uAXP9dqXYJrCtlFywSIIa5dQHn8n0V2JU2pDvHL2TL6y7OiJ7oyy2gWj03EJhXWE3
         +DqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766159231; x=1766764031;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J3sgEnhMWMLOYj1/OofGWKavVFtW6YP1ndiLQ0rOu/8=;
        b=CdQztKucbOs+TaUuGNJFP/q9NgxNax8BMLcAGr0g7yYDhUm/tCQUW7hMt5sI3P0CyI
         Hg3SVIiI7OGO7YDvB6lWRJo7psaOYiwLlUEYld1aTrajLUU/47wGNMbJb2+MPYZ7I7zH
         8Gq2HrLJE/KdCl9EDDp0kkawbk+N5kypS1ER38vSqHQFhM8frzX5tCSZnKHiIeZZPGgO
         YLFleMtj7YLAy9xnJ5YVSVUo70/iqCbDZozVjwbEsX8o27iiY6puTIuz6ZEwN0AhLma7
         L8XjdK0LcBmlzrPcBkEzYRREjjfO1Tvm1QBMr2UU41rWZ73CsJMaZ031p2FfTV60axgk
         1c+A==
X-Forwarded-Encrypted: i=1; AJvYcCX26NeTsfE97eUPGxN9od/A+hkt1VFH5FqtwKL+rZ5hchxaS0JeycLiLRqkToDOR9cFdoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh/QZuzN5a7mMJG2Px7m91ie4ZsBwP4TbiRVw8dbxfsKlBNJLC
	2wz16PQbgV8qzaizgqebhuZtDIfOxbO+cxQZRwsOc9uE8yt7PpKZGL34ZF/5jsoPRMsx2Qte42S
	7HA==
X-Google-Smtp-Source: AGHT+IG6Z5Tj65gpnRG9ZfygNEOWxPYymEwwgB1rgfvjvus65EDRt+hfREOXwzDTtwSRis3WLEZWS8/1FQ==
X-Received: from wmcq18.prod.google.com ([2002:a05:600c:c112:b0:47b:e2a9:2bd3])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:46d1:b0:47a:8088:439c
 with SMTP id 5b1f17b1804b1-47d1959d6a0mr26330495e9.35.1766159230294; Fri, 19
 Dec 2025 07:47:10 -0800 (PST)
Date: Fri, 19 Dec 2025 16:40:15 +0100
In-Reply-To: <20251219154418.3592607-1-elver@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251219154418.3592607-1-elver@google.com>
X-Mailer: git-send-email 2.52.0.322.g1dd061c0dc-goog
Message-ID: <20251219154418.3592607-27-elver@google.com>
Subject: [PATCH v5 26/36] compiler: Let data_race() imply disabled context analysis
From: Marco Elver <elver@google.com>
To: elver@google.com, Peter Zijlstra <peterz@infradead.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Chris Li <sparse@chrisli.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, Bart Van Assche <bvanassche@acm.org>, 
	Christoph Hellwig <hch@lst.de>, Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ian Rogers <irogers@google.com>, 
	Jann Horn <jannh@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Johannes Berg <johannes.berg@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Triplett <josh@joshtriplett.org>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <kees@kernel.org>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Thomas Graf <tgraf@suug.ch>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org, 
	linux-wireless@vger.kernel.org, llvm@lists.linux.dev, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Many patterns that involve data-racy accesses often deliberately ignore
normal synchronization rules to avoid taking a lock.

If we have a lock-guarded variable on which we do a lock-less data-racy
access, rather than having to write context_unsafe(data_race(..)),
simply make the data_race(..) macro imply context-unsafety. The
data_race() macro already denotes the intent that something subtly
unsafe is about to happen, so it should be clear enough as-is.

Signed-off-by: Marco Elver <elver@google.com>
---
v4:
* Rename capability -> context analysis.

v2:
* New patch.
---
 include/linux/compiler.h    | 2 ++
 lib/test_context-analysis.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 04487c9bd751..110b28dfd1d1 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -190,7 +190,9 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #define data_race(expr)							\
 ({									\
 	__kcsan_disable_current();					\
+	disable_context_analysis();					\
 	auto __v = (expr);						\
+	enable_context_analysis();					\
 	__kcsan_enable_current();					\
 	__v;								\
 })
diff --git a/lib/test_context-analysis.c b/lib/test_context-analysis.c
index 2dc404456497..1c5a381461fc 100644
--- a/lib/test_context-analysis.c
+++ b/lib/test_context-analysis.c
@@ -92,6 +92,8 @@ static void __used test_raw_spinlock_trylock_extra(struct test_raw_spinlock_data
 {
 	unsigned long flags;
 
+	data_race(d->counter++); /* no warning */
+
 	if (raw_spin_trylock_irq(&d->lock)) {
 		d->counter++;
 		raw_spin_unlock_irq(&d->lock);
-- 
2.52.0.322.g1dd061c0dc-goog

