Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AFF43E48D
	for <rcu@vger.kernel.org>; Tue, 20 Jan 2026 14:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768917926; cv=none; b=PjhPi3h3SHKv5nN5hmfWnp0pyC6xVAun8rHIocef8YWmYJhQ7qauPcHK7Deyul9In8GxKreVsoSbSAxIiufS1U1aRk19cLl83ESNSiowsi41gUtKZXfa/vv0A9T90zOvmTzR5t8RhcVkiZnQERCbMU0AIhVMukkK7kTitJOL5SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768917926; c=relaxed/simple;
	bh=lKY1eJ8/q2YuwAvqzjqDdSke3x4ANRWo9Ml+P+k2QDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJ+4NyPh1UMFHwmnmhJgUq3TzEpJ+of4UWwBX/+9CaDknJSpQrnyBEdz+jiQcq8JFF/+J9R01WoAdBz99y3QGNlok5ZtiObE0ushvgsVuA0mleYOEnfa5s0/O6N0oY+FL8MQ70imd+8IYLGKyciWlA+gNI4czZDWZ3n9HjgAzGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FioJT63G; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FioJT63G"
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8b2f0f9e4cbso443422885a.0
        for <rcu@vger.kernel.org>; Tue, 20 Jan 2026 06:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768917923; x=1769522723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oGl+JawNZxbkW6YBThH+A9Q3ruFvPDTeQ6pPsaxwQ2U=;
        b=FioJT63GjGrH9PRXnpoZyRnZbXhQfbjyCSpUbHUNJzlLVjyk8jHr1jCJKLLswLmzso
         zbbaJNgAmKfKej283dhIgyxm13kwlJjl4wLXcqI0A0weOqg3mj0rB8fhqpzSSLorump3
         AB9ovQfNf8Zbz3i86xqx5l6kWWWPf0gSao+1n+nPpDbnV5f7mRpiPjR9FqUcJ+5wOLaM
         uJx/WFr/ubI/Ts7mLvYOa7oGw9Z2zEsoSw52kMcm/zln8ShYrTPEsmheukA9rnaNNWBQ
         wxH/4KyQinZOeRJ3Mj2VQv66lhZOryl1Cl3p0hQeHjathrxmr8f1lLXNNc2qxx7s+BI9
         3Czw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768917923; x=1769522723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oGl+JawNZxbkW6YBThH+A9Q3ruFvPDTeQ6pPsaxwQ2U=;
        b=ncY/7vaVt3KdvWLrluhDJAcbKEKrBEmMU//3UmCy/or7J/kxVspSn1KHXy7gJRmEi3
         xW5xGGPdqULhKv9WeKjMouMjcYCw7YWAvN9P07a2qWB3GJ3XhcwJne32gvhKcrLz113W
         7gFkQdnQwol3kingnKp7XpamH/tn5aw1s9MH4KkTml5Ls4w4xt7botJw4BFGE5JimzxJ
         qFH14Bbgbka+PDdV5CkydM8f335g+40suu1lcre/c7Tn1XeDWCoqaQ3BGlHTDTetn5SL
         j6dvP4DRejNz6Vl37cRdmfottUfh5i1lyA+7Av4D7pcQFS/I9yEmvHcsUsa0D6k14SZW
         dxsw==
X-Forwarded-Encrypted: i=1; AJvYcCVJr0AzioPe5Z+pCxJG0lw4KWoWhoNwCl7HNTuHBtp41YCgBNzKJIToIr5xFxRvDuhfX2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc26F9+4f/cXfVL8RLpJFj4hu3a2m9p0SdDv/aZQ7A/FzoYAyf
	v37+kiCZ6Wmyc5qSosrk6/KOM5bwlv3f8MjVaWnFVs4NwO/d9BuyT9Rz
X-Gm-Gg: AY/fxX55dRysk6eRiX2J39F9f8iuTH6AtEjtqU7c1V0P6bpX01/OS3lkLidFlxKbWKd
	LUBaXdPrLyytINJT5TYmd/nBwt5SoBRrVECicXdI/xPk3SLpx0s/nHbk2T6EmBPt5MBrRCmKH6/
	ZJ9U63DKUARcTaf31QvUuE6KUtJGmWYJlYzO1bHIit+OAXC46jw2H3jVFA/wzNFydku4BXjwLQr
	HFIN/SGBh1kYjcKHDNrU9su1380snuUvqn2zNZI2fqug9FvKixEP7O5RgyPyN2W5NJ+daG/10HS
	KFsaV9XeBqWFIxkxuY9W3Mf7JqzV8Q/A2n91SOCVqCq9cbrymKbEjC8JCZI3qD2zcpFcTIBQXDB
	j0xSzhJmyl4I1NAw8Jm2t4BGCBQ1jfvkKXCDtubCr7HWfEK7BrhH+XqvrAcxQtI2Kuy/SerR+kF
	oDvu7iRnViVPW/91J8oBttZHcYtdBgg9Y8HPUBtyoFu98aVXXoKWkXvqwdwjp+UDowKfy03eaPO
	7QEC4UErh7MA4Q=
X-Received: by 2002:a05:620a:199e:b0:8b2:eb79:d37d with SMTP id af79cd13be357-8c6a645ca97mr1691655185a.4.1768917919581;
        Tue, 20 Jan 2026 06:05:19 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6af506829sm813177485a.37.2026.01.20.06.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 06:05:18 -0800 (PST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4BD42F40068;
	Tue, 20 Jan 2026 09:05:17 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 20 Jan 2026 09:05:17 -0500
X-ME-Sender: <xms:nYtvaYGZT8ZnGNrt029Cf6ZpUkJrw1mYsl_m6c_7guVIDmG-cVRKhg>
    <xme:nYtvaY2ZsQywMYPp31JsTD-pkJEG7kZAa9Y9rXSW7L6kU-RolIkL00eA06hjCQHfk
    g7RfICxqq6x8xTg5izgnxUoXi_GN3tv9oc0x9O22_fmGaI8_MyrkA>
X-ME-Received: <xmr:nYtvaYMlM1XIAM4rbYs3OqVPtzBQZEw-phsS6BVV6KkVw3t7J9Qkv8cd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueehgeeg
    gfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepvdekpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghoqhhunhdrfhgvnhhg
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpd
    hrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghp
    thhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrdhhihhnug
    gsohhrgheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:nYtvaYK077jMROLjaUWFYeMxGbaiC-32xOvSgb6GOtrkGz1g6GrgkA>
    <xmx:nYtvaZaIwjvj60VvrrLjZWXqzj_3Bh_suRmNI4rybVo5GjkX1oQIAQ>
    <xmx:nYtvaRk_9nNuXpXRAhkXUPh40qZ4S0kxowcPvR_jVJKzv37KLxMOcw>
    <xmx:nYtvacY9UFp9_3KExj93t5QQS4c1_uUepMo77own-x1FAwD61YnKZg>
    <xmx:nYtvaRC1fa7uOfKAL-RlzmUHS3pLc5gERuB5_QG_mK_4QPp-C984hpbp>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 09:05:16 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,	Will Deacon <will@kernel.org>,
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
	Lai Jiangshan <jiangshanlai@gmail.com>,	Zqiang <qiang.zhang@linux.dev>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Dirk Behme <dirk.behme@de.bosch.com>,	Dirk Behme <dirk.behme@gmail.com>
Subject: [PATCH v2 1/2] rust: sync: atomic: Clarify the need of CONFIG_ARCH_SUPPORTS_ATOMIC_RMW
Date: Tue, 20 Jan 2026 22:05:02 +0800
Message-ID: <20260120140503.62804-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260120140503.62804-1-boqun.feng@gmail.com>
References: <20260120140503.62804-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, since all the architectures that support Rust all have
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW selected, the helpers of atomic
load/store on i8 and i16 relies on CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y.
It's generally fine since most of architectures support that.

The plan for CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=n architectures is adding
their (probably lock-based) atomic load/store for i8 and i16 as their
atomic_{read,set}() and atomic64_{read,set}() counterpart when they
plans to support Rust.

Hence use a statis_assert!() to check this and remind the future us the
need of the helpers. This is more clear than the #[cfg] on impl blocks
of i8 and i16.

Suggested-by: Dirk Behme <dirk.behme@gmail.com>
Suggested-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic/internal.rs | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/sync/atomic/internal.rs b/rust/kernel/sync/atomic/internal.rs
index 0dac58bca2b3..ef516bcb02ee 100644
--- a/rust/kernel/sync/atomic/internal.rs
+++ b/rust/kernel/sync/atomic/internal.rs
@@ -37,16 +37,23 @@ pub trait AtomicImpl: Sized + Send + Copy + private::Sealed {
     type Delta;
 }
 
-// The current helpers of load/store uses `{WRITE,READ}_ONCE()` hence the atomicity is only
-// guaranteed against read-modify-write operations if the architecture supports native atomic RmW.
-#[cfg(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW)]
+// The current helpers of load/store of atomic `i8` and `i16` use `{WRITE,READ}_ONCE()` hence the
+// atomicity is only guaranteed against read-modify-write operations if the architecture supports
+// native atomic RmW.
+//
+// In the future when a CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=n architecture plans to support Rust, the
+// load/store helpers that guarantee atomicity against RmW operations (usually via a lock) need to
+// be added.
+crate::static_assert!(
+    cfg!(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW),
+    "The current implementation of atomic i8/i16/ptr relies on the architecure being \
+    ARCH_SUPPORTS_ATOMIC_RMW"
+);
+
 impl AtomicImpl for i8 {
     type Delta = Self;
 }
 
-// The current helpers of load/store uses `{WRITE,READ}_ONCE()` hence the atomicity is only
-// guaranteed against read-modify-write operations if the architecture supports native atomic RmW.
-#[cfg(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW)]
 impl AtomicImpl for i16 {
     type Delta = Self;
 }
-- 
2.51.0

