Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F047D31619B
	for <rcu@vger.kernel.org>; Sat, 17 Jan 2026 12:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768652579; cv=none; b=nqXEunC58qeabeQbR6S7EPXYmJNrlsWd6g5DKk33vBFoHiGdWOx+7NuGuZjIpdiyYnIWK9ppFTGBw/gclMJtRi6rao2A/Yj6PjpR0bQUbPMOZzQOOA8g94eUoEAfsjvkaqKkO5l28IsQJZsUhaR2oALLSMvSDa57Gncjj6dCItg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768652579; c=relaxed/simple;
	bh=2YTixGagJGjbYi4msm0geEt/p3KMC7b9ZbPR/aUA/5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKHxRPXvxswgUNxkDsO+PA7EV4csT7okOTdDLUUHRuOHMdhju9E4XK4dRZzg+h9b9x1Bd/NE9tP00xyv5BgefwoXkyodJ0fZQCc5rNpqMxVL2BtOCEaYs92kp2SBrvMB5kYgE42i/QXHXqEqnd60Iimg9Fmt3++H/STuNSuCvdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTSqMZD8; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTSqMZD8"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-502b698e510so1514561cf.0
        for <rcu@vger.kernel.org>; Sat, 17 Jan 2026 04:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768652577; x=1769257377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1OIo1B4Gq4+lB/pLEgP5IRCzf+1y4S/6CWlM+DSz+/I=;
        b=CTSqMZD866clmiwcO15+ZD9vuljYVGBw5UK041+vRaHkf579UaPfSzEHxMXiyp5Cwe
         sE+1c976iOBMuMPwNrqBXCl/wpsiOpvjpG6UzQZo3O3DSs51SX4JZiVvemdFHgQDxuoh
         jUaQW6jef56OJ2zJNth5sf7Nw82EWMJnlywKHxbdHf5N8DEiPV1YU2XSSlDrKjyrlzt8
         0udP0ppQn65ujTKUi4LaXvbyurFYZb9Ret0Jjp7skATUgpyUsHE4gWDwmnUpTGIg7RHh
         aRnbLClDEpd5rTN2DjSXH31FrECG/gy41ICnboK9hLR/4OyND52z/UuwFkIwHy3upeRP
         xKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768652577; x=1769257377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1OIo1B4Gq4+lB/pLEgP5IRCzf+1y4S/6CWlM+DSz+/I=;
        b=M8WIhQmZPAM7UPpjEpSJACQrnMkG6zXZFIcL68ssULCEZZnkYRm3N2/Ja06eHVxoMe
         Lfr6UpnU2cb8x8gZ4OtLXkYHMxNOg47aVfS4CdWWh3+X06hl8KdJtTnTaXK5CwCtXc1R
         sxlQ4zem/94AgvVvg2Wx5bzedC1I7xsFfs5bF1rie2JtifvZVr3ba7zMvoUWRiV9y8fi
         3W/5TnqaP9SJGlu/n927f71IkJgx/hDl+P8kqFekqNIPGr9vm3aMx9gXfAkhMl0M9T27
         NWhcIWuzTok8HWfQ/xKYhRu4ipqCU1166yXTbTXQ5Q64ikVW9kkm+gJnnQAX4CUsh56H
         853g==
X-Forwarded-Encrypted: i=1; AJvYcCXKvPQVDRURSX2GgS1dGHRBp7bak96MoAvNHbamXGG75ObL2hF5jS5PC9MlRUiAtz4LtLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiRIehtgBk4Y0G4+01MTwBKoCL2HOTSyNhJkqHLOJLp0lgq2/8
	mEckRv0XOrwKp5txqVHykjbtsxC8W6lX88Y48D9+yYsSwI+eCuHYJWp6
X-Gm-Gg: AY/fxX6rCBzVFFWS9/oqVe+mN1xHqP5y44icj8/RdU3sj0+qAOSepCp8BAEPtePJV4a
	A5k30iEnawgcZ3FOii5YlcWZRqSCLiG07UpfqisREwOPmnDbQakRN8MOkTUE7fIR2Fx+sGzqQx2
	TTKZVtXANuNQOoQERS3E8TQeWRfrY8f73XcHlXWaWziHU7qglpG7BKiUWdPGxRI/QkjnL1Qz2jz
	P14JzfbSA/lojwoT3igpeMde3TaD7B/EmjW7puYSdNfUC6H4cNyyTEfbzk7pM4RV8zprN4anzth
	CmLJ8C+4WRy8etsWWbyMpIgmR05nEK8uNsTPzWyOXyAeDPcov4IEkHR0fBKUlqMruI40gm75Zl4
	Lzx5TWP1mI3M49m7alUXhtzyMjKuvEe11Nka3KZVB8IrOdOyXybOKrED4Una8nBOhfwrhnynV/m
	COyci2nc2P0upZqs5cP7Ce+HRig08RhaOp6HWKRE2YSavq4bkyjWA/LdQa1j3ZpwTK7XeDDkqAB
	V9K5jETuOxBoq0oagXAsGwxWQ==
X-Received: by 2002:a05:622a:199c:b0:4ed:dec2:301a with SMTP id d75a77b69052e-502a1e1da21mr95361171cf.16.1768652576843;
        Sat, 17 Jan 2026 04:22:56 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1ed3256sm38240091cf.16.2026.01.17.04.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 04:22:56 -0800 (PST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7F02DF4007E;
	Sat, 17 Jan 2026 07:22:55 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Sat, 17 Jan 2026 07:22:55 -0500
X-ME-Sender: <xms:H39raWh29fbgIZSMqiPD1avfKnDs47xE7l1KXC3t3FDNfBLRFEzvVA>
    <xme:H39raQHQM2DyOd0gkR1KPYkvF70I_3BFIgFDkJ1u1piwrSdpoAj0VB-iHsMEMkvo1
    Sukmx9d0Fk1n2Iuudiw5E2Br1vLVfl_LzmKJeewx4EtW_vL8ltEc1g>
X-ME-Received: <xmr:H39raXLTSCbsnMhe4kRVgZCGzKPJUmz-LZF8Kyu6AzAQh9Uyof5EHbKp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufedujeelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:H39rabDy9KSsyq_7yBietNVX_eGFBjGDHs8bMWleoXkRXTOgSGWJEA>
    <xmx:H39radB7bf_sFxUxbZfwGL5U8yn-LjT7FER6I_6VEMO6lbTCrHVnug>
    <xmx:H39raclOS4pqsmaUxtUPLDUXFcN81rh0SjTo03sX9NwC6HiVq-p0Rg>
    <xmx:H39rabj2rLD4wqif2W1SfS_hauYDRbCQJdsOUgE6YvMhCKNs4RgahQ>
    <xmx:H39raVeiyPM0jM5BuaX-4p7tnkyFiNgNgp4_2bUpj13v5hMhECMNtHrK>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Jan 2026 07:22:54 -0500 (EST)
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
Subject: [PATCH 1/5] rust: helpers: Generify the definitions of rust_helper_*_{read,set}*
Date: Sat, 17 Jan 2026 20:22:39 +0800
Message-ID: <20260117122243.24404-2-boqun.feng@gmail.com>
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

To support atomic pointers, more {read,set} helpers will be introduced,
hence define macros to generate these helpers to ease the introduction
of the future helpers.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/helpers/atomic_ext.c | 53 +++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 30 deletions(-)

diff --git a/rust/helpers/atomic_ext.c b/rust/helpers/atomic_ext.c
index 7d0c2bd340da..f471c1ff123d 100644
--- a/rust/helpers/atomic_ext.c
+++ b/rust/helpers/atomic_ext.c
@@ -4,45 +4,38 @@
 #include <asm/rwonce.h>
 #include <linux/atomic.h>
 
-__rust_helper s8 rust_helper_atomic_i8_read(s8 *ptr)
-{
-	return READ_ONCE(*ptr);
-}
-
-__rust_helper s8 rust_helper_atomic_i8_read_acquire(s8 *ptr)
-{
-	return smp_load_acquire(ptr);
-}
-
-__rust_helper s16 rust_helper_atomic_i16_read(s16 *ptr)
-{
-	return READ_ONCE(*ptr);
+#define GEN_READ_HELPER(tname, type)						\
+__rust_helper type rust_helper_atomic_##tname##_read(type *ptr)			\
+{										\
+	return READ_ONCE(*ptr);							\
 }
 
-__rust_helper s16 rust_helper_atomic_i16_read_acquire(s16 *ptr)
-{
-	return smp_load_acquire(ptr);
+#define GEN_SET_HELPER(tname, type)						\
+__rust_helper void rust_helper_atomic_##tname##_set(type *ptr, type val)	\
+{										\
+	WRITE_ONCE(*ptr, val);							\
 }
 
-__rust_helper void rust_helper_atomic_i8_set(s8 *ptr, s8 val)
-{
-	WRITE_ONCE(*ptr, val);
+#define GEN_READ_ACQUIRE_HELPER(tname, type)					\
+__rust_helper type rust_helper_atomic_##tname##_read_acquire(type *ptr)		\
+{										\
+	return smp_load_acquire(ptr);						\
 }
 
-__rust_helper void rust_helper_atomic_i8_set_release(s8 *ptr, s8 val)
-{
-	smp_store_release(ptr, val);
+#define GEN_SET_RELEASE_HELPER(tname, type)					\
+__rust_helper void rust_helper_atomic_##tname##_set_release(type *ptr, type val)\
+{										\
+	smp_store_release(ptr, val);						\
 }
 
-__rust_helper void rust_helper_atomic_i16_set(s16 *ptr, s16 val)
-{
-	WRITE_ONCE(*ptr, val);
-}
+#define GEN_READ_SET_HELPERS(tname, type)					\
+	GEN_READ_HELPER(tname, type)						\
+	GEN_SET_HELPER(tname, type)						\
+	GEN_READ_ACQUIRE_HELPER(tname, type)					\
+	GEN_SET_RELEASE_HELPER(tname, type)					\
 
-__rust_helper void rust_helper_atomic_i16_set_release(s16 *ptr, s16 val)
-{
-	smp_store_release(ptr, val);
-}
+GEN_READ_SET_HELPERS(i8, s8)
+GEN_READ_SET_HELPERS(i16, s16)
 
 /*
  * xchg helpers depend on ARCH_SUPPORTS_ATOMIC_RMW and on the
-- 
2.51.0

