Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D840B2D780A
	for <rcu@vger.kernel.org>; Sat, 17 Jan 2026 12:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768652576; cv=none; b=b0LvhlVVept3Hpj90OCScIumr35BdOOmJKE4608nK1E/V08Y0yi0vKo+BhNZWWZIxCFIn55/+dSv9XSPzzCUdkk6LfwsBMQSzmwiRqxyu/Yg3uIUntfNC7S16/spZQqkT/FYg9I5ftIZbojBssXawjsg+h66xdksjVcHdKrFjOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768652576; c=relaxed/simple;
	bh=HHdfMtrK+bmGVYj7ahqR9WU8B1Kz4HjTRa7EEgx6X3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zo1ceHCJ9T3M3/a9yNopctP+HpNHOL+R/T5tLf2iJ3D2xKGVrJq2dTJ7anLLTQNXBbszXF8c1VGo+/mWvtsDmrMVYkLeUEGv0MyP1Hg524M7ixbajhiMDri2O4tjPlFHLd98SM42Rd3UDLF9ki9m5vtFdwh9Oc60l+gGRTxvJPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nu45kaKO; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nu45kaKO"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-88a367a1dbbso48111196d6.0
        for <rcu@vger.kernel.org>; Sat, 17 Jan 2026 04:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768652574; x=1769257374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=12jZWVyIBthP0eK9MRhtgrjqCiALPkPet5YpqzILAWA=;
        b=Nu45kaKOUcSanpEbRhBikMlJZcAUJwGkErvJHv24q+lrjfIQVnilQ/+Mw6r8/xSV3F
         vgyJnNWwCNxtvTIE44LV0QABtJwQO6yiTvqGaKs4Mk/UOetYkS1YFA+uohmIeBYG0K/I
         i0kKGjbkgnvgjlGP8XiBmuwll5RwsMVi2TSZPPjdQa9JODYk+w24wDEmb329myY36vCF
         BUkEPF1h85kgx3Iw0qGOsBKS1bMoLJhQIkErZCbgVEZMTSE56NbXoevO5AZqKTX3VRMb
         vzICeeyPi/bgSY+/il1tupZkUXPa2cL7NmzPsf5dFGQh+lX2WZIerG8kmztAJpuIOF07
         kp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768652574; x=1769257374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=12jZWVyIBthP0eK9MRhtgrjqCiALPkPet5YpqzILAWA=;
        b=OmiMej4iuC57sv4QNWxZUgfhw76o1yG3rz5BGBjxhMz/wzUZ+CUdYwUy9aNBgK29b4
         K8T/yO3MdRiJdTMMls2SQIMewFDFO/LNQgwpIMO4Lggy+P3J6grQ73q60rfTeiUIJ8sU
         JlpOxJqlGzDItaS3imPih4PlqyTg3iRIpZWawtaRLEyk+hQgNA3bCPdjgl4j4rn/PnXf
         I5O9cT4nKD2FbBSF4nAx/Kc8p0snGkcMlOYOPCoLnNn7n3hjdXVZkDNGzXSGwWvqqMqU
         mVWJo/JSYZdhPNRLsyvE9zRbQLaL8Cd5I0TzneYuUJtOR926HhOn/f/4QrhiA/xbu1ow
         6nWA==
X-Forwarded-Encrypted: i=1; AJvYcCUkFz5ophQrDKzX1PMGZqjYaWa2je39O0KTfJbdSGkAZ2zrrZTYuSp5JlI46i7xe2ACTDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz14OE676Z5KxyxoMr8mB5KCLq+u76q/EWa1WrQ49ZHEiHoBAD7
	46Z0gR+mbhIaUKOivYmHywlLcjWK1qV13/u8EXG5gnZ+Uah+0zLLTx21B5wv0pwxzyw=
X-Gm-Gg: AY/fxX4uUh2w6xOfcLxzESEg8Odlp5lIpMOEbmkXN3lWgZ2GX5v4UuRrOFBZdV++fep
	l3Arcp/9FW9MfiYJVBqxGymlZSmmEDEX5q74IHFb2HdU6lQOWWiimOzLLOrdK7MZmZeaiYCJUyy
	gkaKKSkTQryRv46gDHG+J+yy/Wi+5CbRfC8dX6uCqnNFWwdionvMa7D9ygMjtKdvI58mv0qfveK
	fSOHmRx41M/KFP0Q8ZlocLVEV9W7KuYMMYl7V8Swpu9DI9kSe1AkA9n29ZwsprswNgfxnh8aOVy
	Qbk+riJ5DGA9yc93mQSHMdSvbGUQD6srKEkNXeJWCpHIrQVaRr6Oe5OPYqcU/gV/Y1zhOFGSGvK
	Be5Cs6mwXWQRK9IwyPO4aKjFTIcV/34aNCl/Mag9o+xKwsDpAX43f0DseAv1UgrAQb/K+5sMHsI
	LtpChW5iadY4Ki5bBZ6E5b1xf3OjtCjvco3o81Tl+ZcXzeBFP87lDtf3eACjAqui4Hvg/Xkpzzp
	blLWlrfGFFYUSA=
X-Received: by 2002:ad4:5cc1:0:b0:890:6f67:4127 with SMTP id 6a1803df08f44-8942e421af2mr74248266d6.4.1768652573750;
        Sat, 17 Jan 2026 04:22:53 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6d886esm44612926d6.57.2026.01.17.04.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 04:22:53 -0800 (PST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9F6B0F4007E;
	Sat, 17 Jan 2026 07:22:52 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sat, 17 Jan 2026 07:22:52 -0500
X-ME-Sender: <xms:HH9raSJ_NAn3eaG_VMEya6B7ptt2CF1QvDLW61-Y0LPy_aQHYerUow>
    <xme:HH9raX8KV8ktsVnbT3GEa6M2r89RHCBpjC-C1HlnbTeAO4snZuS0KSZyfDy5Qc2Sr
    zAJuvp6EshuFk_u_zNyUkug4PJhAdNW1Ue2HyxHvwAhra6CuMsK>
X-ME-Received: <xmr:HH9raTkRdN01w2NCmyFsQQne38dpzJCQi6jC3heV0DfY1BvrKurqigD1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufedukedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpeeggeeukeeghfevudektdevjeehhfekffevueefudeivdelteeltdekheejgfeiveen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhs
    ohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnh
    hgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedv
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuh
    igsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgtuhesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhope
    hgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehp
    rhhothhonhhmrghilhdrtghomhdprhgtphhtthhopehlohhsshhinheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:HH9raSWSSDf3wsU2e8IVoxRcHJSC0DF4dNylnQanLUxMgdCmmiSSRw>
    <xmx:HH9rafouAHV88UOJR4wgVlXQlNFr7gJ7yp2MwRlTVPHW1PKYpJ2edw>
    <xmx:HH9raZVxSEyiIf4nK3rQgBlrWdr2oKrCli7ZPiZDNusD1kOWuzr7qQ>
    <xmx:HH9raXCAGs-O8mBWW4n4X7RcPZqfdqYsrefQ5m3weou28n6NGPtvVA>
    <xmx:HH9raVULPqNB88DXtv6YpGvGd_SbracEI1ddJGHHg9Okqa0L-w-s1hCT>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Jan 2026 07:22:51 -0500 (EST)
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
Subject: [PATCH 0/5] rust: sync: Atomic pointer and RCU
Date: Sat, 17 Jan 2026 20:22:38 +0800
Message-ID: <20260117122243.24404-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is a respin of my previous RCU pointer patch [1]. RCU protected
pointers maps to a "struct foo __rcu *" on the C side, which although
RCU has its own API, but fundamentally it's a pointer that are operated
atomically, hence using Rust's atomic (pointer) API provides the
necessary atomic + ordering.

Although asynchronous reclaim is not in the current implementation, but
it should be easy to extend.

[1]: https://lore.kernel.org/rust-for-linux/20250421164221.1121805-13-boqun.feng@gmail.com/

Regards,
Boqun

Boqun Feng (5):
  rust: helpers: Generify the definitions of rust_helper_*_{read,set}*
  rust: helpers: Generify the definitions of rust_helper_*_xchg*
  rust: helpers: Generify the definitions of rust_helper_*_cmpxchg*
  rust: sync: atomic: Add Atomic<*mut T> support
  rust: sync: rcu: Add RCU protected pointer

 rust/helpers/atomic_ext.c            | 158 +++++--------
 rust/kernel/sync/atomic.rs           |  12 +-
 rust/kernel/sync/atomic/internal.rs  |  21 +-
 rust/kernel/sync/atomic/predefine.rs |  23 ++
 rust/kernel/sync/rcu.rs              | 326 ++++++++++++++++++++++++++-
 5 files changed, 427 insertions(+), 113 deletions(-)

-- 
2.51.0

