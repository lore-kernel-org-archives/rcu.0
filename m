Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DB1314D34
	for <rcu@vger.kernel.org>; Sat, 17 Jan 2026 12:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768652584; cv=none; b=ElBzo/5owOgvZWcCAt8bWZfsSNuwAJj7/dBAh3md169oCdv/L8S+Y42vOqr+mbBNxVXdJQ34o5BW4u7f7AIuIbQ5geCuDQG2mmwJlWTntpah5JSNWM0+XpC3bSBydKX1FQltQUAfK96owVLVGHu6ksseyNAbTVV+b/5SQBmPb4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768652584; c=relaxed/simple;
	bh=4NIKpxlbSunL+Z4N22NpquT4aJ22jfPSx7k1kPWckZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p86XtUo0B2rE129dGQwRo976lfU+3F83/rlDlZyxrUXydgBSVtKeZYR14uSuWJnxV9bFQT9NjMRYe+jei+0NlhmXnocsh1KtfPhCJqE2oKn8MA4TgwISIRyCnu99OjxHQasfibul0VOmPXD7ZDit0vr84kHmn2/CURbH4TxaGp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TODDNEXj; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TODDNEXj"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8c6a508a595so231162685a.2
        for <rcu@vger.kernel.org>; Sat, 17 Jan 2026 04:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768652582; x=1769257382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gkWeTN6oy/OKIhfGiOTDWYHCdlEF4RUeCy+vRBjzbJU=;
        b=TODDNEXjJHh+4tOP4Xyod0JUm4eSjO2uxblJkZRvubat8/MWLRFQiHSBfaOuwEYMse
         BoOgdo5a0nbQI9ud88+JNAy2fqXofzJmg+iMpODvxhYrTnTWQXZ4C1ZRzSUCO7thVlGd
         1jp3pHB4Mkidmv4fxQyHzTb8gX3cRf+8KyjVDkKqNYQBNNhvIKMeYEt7lSiMB/puOZwy
         J5T+4b+zh9g27AWlR+GLiaTk7eF1wPiEMFigy999LPoJhO468TfJLx7TCM9PwFyBeg5F
         6AAb36c+eJMAFcvxgB/I6OBOPSNqQieyVwZuJUh5d9pW5njVROgtLuvkO/rcG5rdoB43
         l2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768652582; x=1769257382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gkWeTN6oy/OKIhfGiOTDWYHCdlEF4RUeCy+vRBjzbJU=;
        b=AohqhvVMj9MDCb6/cYP3tLmxjJ2usPZni8nghIJM4qn7TLCLNs61DdQ5cCTGv4bzFe
         leku8wPli3x/fLviKn7FafzAJw8a5biKjq1Shb9ea+TZx09m9QsCWxJmFBgQlQ6Bv9N6
         QkKZM+ulZnLruq2OuA69Q4Ap1hgWWkfhxe6IZNZ6FQ4h8MdbIEBasoDMJJtVkVlH8esP
         nVEOEGjbpaCUbFl3EqSMFmzz8MvHbm+ST5niW7Qaqq1gQzyCMIb9yIpCU+6dq26IgsVD
         n5W2Vr/JX57FbNe6c18zqGLy1zcTeURmOkfB8VKlTPVLsRyEd9cRto4L3gvyAE77OAUG
         wfWA==
X-Forwarded-Encrypted: i=1; AJvYcCVZZGG2a2Tmq2sSGZn9mxGjb+u5qQztze7ZBDGo7JZYWjHNYGtc7TNta7PI8nbimdGneLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHjED6b/A98N50RT0uDTlWckFpNLVtBCZmIyEOQY+iSHE2PJyy
	MmfAToDDP2OFvKsaRdLQlE4oF98s+7afICQIuFecoNqrRc8Lnzg1qVgl
X-Gm-Gg: AY/fxX42kAGZZa5SmUGg21FtMlu+uqTMT5WqOctCFXja18OjvaMJKVKnr63I+Eb8lHt
	Z+Xq8AwmYRUXfP98scCNaxQL9TU8o9799fQ5aYimqWjPJbWj2ZqbWQNQFdvvKm8lIoUTvauv9iS
	zEwSEXku3YHNHK/gNwoMvVAeTCXZ/Dhi+92+7i2iaL6MlmPEdvX72/Uhqpl29kdClJvXy1MHBv8
	NCdGRQlnWLDqXqOpppZI7mtiStUIrl4wkKbP0W9KCnoIGsO+SBhDnTDUrcw7v4yweEWoLeE510u
	bJxrqp6Nj5clRv3/tw9V6CVqVYUz6zZYqr2QLlBDy2pgFCgSexJp5tXkJXWY2P2llKvbNARSnYW
	ByqPh/GbK67Gzj4Qn/FpbYohevOVYevG5QkTOzc+SXyXPCUQhjMzFlBjo+1EjCkA7eO6FMN15RE
	412egrkPhg3i1nRRdQDQZTRtUqlRw3MGduCyR8jKJwAuiGbAkO9agpXX6zYA3BMuNYBIEktARQz
	Tue8xRYDW/0yo2Th1s9C7+zRg==
X-Received: by 2002:a05:620a:7009:b0:8b2:dd0a:8809 with SMTP id af79cd13be357-8c6b1628dabmr318598085a.89.1768652582099;
        Sat, 17 Jan 2026 04:23:02 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71c0469sm422247385a.13.2026.01.17.04.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 04:23:01 -0800 (PST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 02268F4007E;
	Sat, 17 Jan 2026 07:23:01 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sat, 17 Jan 2026 07:23:01 -0500
X-ME-Sender: <xms:JH9rac7-_VVs8248fKebhYyrWDkWL8iVI6W0Ukqrtkz33wnOJGFbFA>
    <xme:JH9raW-HabOpBPfdB3-K0iKv8jVZBlLvaGrnLzClzXZY5NnXOAjWd5EpENPR7Dj7s
    QofvdGsNjFAFTlj5jq8dyGUNq4QgItlrdfs3nDCnDeto6PWMj4Q>
X-ME-Received: <xmr:JH9raUjBXFRpArbbPLSRMVP9OdxzXmiMyqksW_ezftqDXRlkbLdVq5oG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufedukedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueehgeeg
    gfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepvdeipdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghoqhhunhdrfhgvnhhg
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpd
    hrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghp
    thhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrdhhihhnug
    gsohhrgheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:JH9rac56ZwBTkpHwXvSofNjXAuC06ZEmfB4Zado2uzUKGvL7s4sWHA>
    <xmx:JH9raZZkJFUGIhx24O4BcR0sZpuBAVysyUHJoSdnT3AKc3y60r_ELA>
    <xmx:JH9raRdP1qiccP5fAWoEZRxh-x91JF1e-_9CnQcoxBCcwKrRgu_5Ig>
    <xmx:JH9rae4rCoDGl_uMNomP74U3f2BV3XShgA3mZROI-SIXragJC0Vyzw>
    <xmx:JX9raVXODt5yJwHqcYwOuqIXKB7RxYa68n0mT33ptfNJeqcT2z_qLInq>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Jan 2026 07:23:00 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Subject: [PATCH 3/5] rust: helpers: Generify the definitions of rust_helper_*_cmpxchg*
Date: Sat, 17 Jan 2026 20:22:41 +0800
Message-ID: <20260117122243.24404-4-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260117122243.24404-1-boqun.feng@gmail.com>
References: <20260117122243.24404-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To support atomic pointers, more cmpxchg helpers will be introduced,
hence define macros to generate these helpers to ease the introduction
of the future helpers.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/helpers/atomic_ext.c | 48 ++++++++++-----------------------------
 1 file changed, 12 insertions(+), 36 deletions(-)

diff --git a/rust/helpers/atomic_ext.c b/rust/helpers/atomic_ext.c
index c5f665bbe785..240218e2e708 100644
--- a/rust/helpers/atomic_ext.c
+++ b/rust/helpers/atomic_ext.c
@@ -67,42 +67,18 @@ GEN_XCHG_HELPERS(i16, s16)
  * The architectures that currently support Rust (x86_64, armv7,
  * arm64, riscv, and loongarch) satisfy these requirements.
  */
-__rust_helper bool rust_helper_atomic_i8_try_cmpxchg(s8 *ptr, s8 *old, s8 new)
-{
-	return try_cmpxchg(ptr, old, new);
-}
-
-__rust_helper bool rust_helper_atomic_i16_try_cmpxchg(s16 *ptr, s16 *old, s16 new)
-{
-	return try_cmpxchg(ptr, old, new);
-}
-
-__rust_helper bool rust_helper_atomic_i8_try_cmpxchg_acquire(s8 *ptr, s8 *old, s8 new)
-{
-	return try_cmpxchg_acquire(ptr, old, new);
-}
-
-__rust_helper bool rust_helper_atomic_i16_try_cmpxchg_acquire(s16 *ptr, s16 *old, s16 new)
-{
-	return try_cmpxchg_acquire(ptr, old, new);
-}
-
-__rust_helper bool rust_helper_atomic_i8_try_cmpxchg_release(s8 *ptr, s8 *old, s8 new)
-{
-	return try_cmpxchg_release(ptr, old, new);
-}
-
-__rust_helper bool rust_helper_atomic_i16_try_cmpxchg_release(s16 *ptr, s16 *old, s16 new)
-{
-	return try_cmpxchg_release(ptr, old, new);
+#define GEN_TRY_CMPXCHG_HELPER(tname, type, suffix)				\
+__rust_helper bool								\
+rust_helper_atomic_##tname##_try_cmpxchg##suffix(type *ptr, type *old, type new)\
+{										\
+	return try_cmpxchg##suffix(ptr, old, new);				\
 }
 
-__rust_helper bool rust_helper_atomic_i8_try_cmpxchg_relaxed(s8 *ptr, s8 *old, s8 new)
-{
-	return try_cmpxchg_relaxed(ptr, old, new);
-}
+#define GEN_TRY_CMPXCHG_HELPERS(tname, type)					\
+	GEN_TRY_CMPXCHG_HELPER(tname, type, )					\
+	GEN_TRY_CMPXCHG_HELPER(tname, type, _acquire)				\
+	GEN_TRY_CMPXCHG_HELPER(tname, type, _release)				\
+	GEN_TRY_CMPXCHG_HELPER(tname, type, _relaxed)				\
 
-__rust_helper bool rust_helper_atomic_i16_try_cmpxchg_relaxed(s16 *ptr, s16 *old, s16 new)
-{
-	return try_cmpxchg_relaxed(ptr, old, new);
-}
+GEN_TRY_CMPXCHG_HELPERS(i8, s8)
+GEN_TRY_CMPXCHG_HELPERS(i16, s16)
-- 
2.51.0

