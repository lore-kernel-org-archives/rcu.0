Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C89933CE8F
	for <rcu@vger.kernel.org>; Wed, 28 Jan 2026 21:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769637231; cv=none; b=e/HfcZ2DWGkYUt0+qSDf2DuPdG+nSJWbKrRDwJwjSO8WLJVLeMVBIosluugLbH6Katf//YE7+FLWKJwpz9jXqUYUQ46lpJWzwavOrU1K1DkWC5ghWA5n7GHjY2wpUaiCTKXMmxmam+2D98wk2O3hPGKsvDhoQWZ2ZSwb4kBdMCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769637231; c=relaxed/simple;
	bh=VS2vDVTbhryM2iG2RFEe63s3RzGceDZw2ywU6GaaAO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sac5GAMt1tKTAb3oVewEWpntNjGpBDCUW2PLghqLIBCBMJuCr8z4uiFUcXsyCuFDh5Q5jYUvUuklLAIed2GoIiueGZmcHXY+LiaDO6Z+yBGB/iOjc6IS+u8gTW1+BvSNCM6/Mp2XUb7YlG4RVllWOCV3QVyt4XQ9pj5gRFbSu8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWP2xgle; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWP2xgle"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c6a822068eso48514285a.3
        for <rcu@vger.kernel.org>; Wed, 28 Jan 2026 13:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769637225; x=1770242025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NJefVb7bf1Dw+gUw0ZVM3yqaOt6rhoTdHQFIKu4uZfc=;
        b=UWP2xglezd+cyTnP70i7txqJuIktFy1MIxQeWsY/RIamcg0lhDKpL462kDCtgm6234
         G3KembYWEBOoCiBQ/7+NP5InQ7Wsf8BmcnA7f+Vb3Tti1TIoFUu9xBNOELTnk+o8xVI1
         92d/o900HVXi6GQRz1M+UPNhov8j3rcoBJsUlV0/uvHej1JIGnSXKY0FrfcQ6ilqefsq
         aaKtxY5PEEtwSs/YaNuxvf48nyG7mfRLk37I5j1bfbvU1Y3kxqvPjR4gC54ryd93J9uN
         6ckHCCN/gVfOYyuNpFs/P5LD09r+9j6b4CAqTVGUB7KtIBFPMT8nd1lJheeeEQs6XN+x
         s4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769637225; x=1770242025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NJefVb7bf1Dw+gUw0ZVM3yqaOt6rhoTdHQFIKu4uZfc=;
        b=j0yDh3Btw8oRGsE9BBioDadDo727Ov6UBAA4brNOurDy19p2uxvMPbl39QDbEaqgVK
         Op+PviPONcXWjIqCVP4JXPK1gSi+h31AMDUSmXQWr/ZolgLXOA1rtpVeb7+mqOsp7x5A
         C5e3eVIB3bNk537mwT1xYXqCOUsoUGSn4SWwdw5umyo20CCe9UZ2ayIa/L444xusDMPb
         +zgvdlKhPLmalQjoQ5O33tuhgBPBDnCnUsQQudFgaQ/odX2sD+DWRclBYdpHFAVK/ua2
         xl2o/xKcnkQfBmggS0INSdiPnq88KbaZJdiC5xoqgW9jxezE2h5GC1CBUevChLO7oIQP
         cNVw==
X-Forwarded-Encrypted: i=1; AJvYcCUlWPIltMXkOcwOl7vp3GjKddvEFPcSpd6jS4OmhUTo27rYwXfzZzeeoIsIY8Tb35906vM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP6T7qb9Nbdr8Zvhs/BSo/qHT8ElG+qIwQkkoDy5f+Mxp4uA0/
	W4KHDeKQ3zArH2KbxKxYsFcHcy9Eo9vWlun3C8u48q1VkHO3OtThqDn9
X-Gm-Gg: AZuq6aICeoLcRrNe0HWg4W4/m60V3nnB9p7/B4QSE/ehP41VnegeWqQuR0JV0xl3K+a
	6LjyEQPsyJoFtRiQGcPZROAJEMFxlMYRmDKs3bHyJn6ttR1c/IqkweKV9twBIW2xg8ysLMxb+ZN
	xHnpVVbIOwyLECntI4Nc6tJfeuN3gKs5ikSUk/3DCJMqFL8/b6A0hTgA+C0fxwZSH0w1zKBa1i3
	VDAEJcdcr6dXJNr0G5cL4XAzsCMuFtq6cLkR9NbAWHIr8bgxoh4Gqt5NmPcL5csJqBVI3vfheSL
	aRQQ69896YPXpTuM55Qr2aqdyHdKyc0DQtaf2H76ZZhrxCKiq49b2zGd2XAzSPithwOC8boNFCd
	X5oq2vztTk/0wmnFQ3o/tGshimJQBbFVy5uCGQhICKBv+Xzl+lruFc5ZRlY4wrVvRi4iM4LUmHh
	lK+knDsROB/r3j4DKCuFmKnimrOqz9Ok4lPzq+KTiJaUbWApotFTNHGN02QOxvR5mVQFtJf5/kW
	RWpylpppEtq2Ms=
X-Received: by 2002:a05:620a:1988:b0:8c1:6018:b186 with SMTP id af79cd13be357-8c70b927a0dmr857145285a.87.1769637225168;
        Wed, 28 Jan 2026 13:53:45 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711b96fbdsm261644985a.14.2026.01.28.13.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 13:53:44 -0800 (PST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id EE44BF4006D;
	Wed, 28 Jan 2026 16:53:43 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 28 Jan 2026 16:53:43 -0500
X-ME-Sender: <xms:Z4V6aXdz8cRDm_tXieHr7Oh9aaspEpgLS5vE7365MNmX3jhUjb534A>
    <xme:Z4V6aR0zRj-XjoQeMplYNrOXg1OK_bm5MX38oBfU6ltmGTjwBc1gav3_eaFZBkVaD
    GjBxAmIoTTVRadffy88Xd90MZP7XBvDNZlFA7CiBsWfe0rJkD-RIA>
X-ME-Received: <xmr:Z4V6aTM6_4uSuJrv-sDQbmFNn-tAmcqaq80Dz7CSXgyi7BqBbUyzjeqUDICIjwqlQqpJHmooR3vwA5B6pd97AO3KqcwrhQSB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeggeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueehgeeg
    gfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepgedvpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohep
    rghrvhgvsegrnhgurhhoihgurdgtohhmpdhrtghpthhtohepthhkjhhoshesrghnughroh
    hiugdrtghomhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegtmhhllhgrmhgrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprghlih
    gtvghrhihhlhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:Z4V6aYRAp11D9kA6qgwYhTm9VqUIXtiYizrlzCk9-pDIxAMY8nkKbQ>
    <xmx:Z4V6aZwAcFiAXuDH9lyiz_ofRJHPV_ofS_moTroDNBVrvFWywH8ZXA>
    <xmx:Z4V6aWefvPOGpFfGLUsVgdIR4z3G5zFaVy_kB2-qXmuPTaWnLfnITA>
    <xmx:Z4V6ab62fRhqp-I7kxvuBzZBgIdN7mXiPhl4qsvQZFZWuiMtF5xbCw>
    <xmx:Z4V6abIgGVW-UWYzuf6USJEVBaJouxsY2gKlUzEeHeKwKd4u2eKZslpt>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jan 2026 16:53:43 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,	Danilo Krummrich <dakr@kernel.org>,
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
	Lyude Paul <lyude@redhat.com>,	Thomas Gleixner <tglx@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,	Stephen Boyd <sboyd@kernel.org>,
	"Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Vitaly Wool <vitaly.wool@konsulko.se>,
	Tamir Duberstein <tamird@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Mitchell Levy <levymitchell0@gmail.com>,	David Gow <davidgow@google.com>,
	Peter Novak <seimun018r@gmail.com>,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [RFC PATCH 7/7] rust: sync: rcu: Introduce RcuHead
Date: Wed, 28 Jan 2026 13:53:30 -0800
Message-ID: <20260128215330.58410-8-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260128215330.58410-1-boqun.feng@gmail.com>
References: <20260128215330.58410-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to support RCU delay free (call_rcu() and kfree_rcu()), the
abstraction of the `rcu_head` is introduced. Types that want to support
RCU delay free can specify a `RcuHead<T>` in it, e.g.

    #[derive(HasField)]
    struct Foo {
        a: i32,
	b: i32,
	#[field]
        rcu_head: RcuHead,
    }

A wrapper `WithRcuHead<T>` is also provided for users that want to
specify a generic `T` with a rcu_head.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/rcu.rs | 69 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
index a32bef6e490b..694ca2f54953 100644
--- a/rust/kernel/sync/rcu.rs
+++ b/rust/kernel/sync/rcu.rs
@@ -4,7 +4,14 @@
 //!
 //! C header: [`include/linux/rcupdate.h`](srctree/include/linux/rcupdate.h)
 
-use crate::{bindings, types::NotThreadSafe};
+use crate::{
+    bindings,
+    field::{Field, HasField},
+    macros::HasField,
+    types::{NotThreadSafe, Opaque},
+};
+
+use core::ops::Deref;
 
 /// Evidence that the RCU read side lock is held on the current thread/CPU.
 ///
@@ -50,3 +57,63 @@ fn drop(&mut self) {
 pub fn read_lock() -> Guard {
     Guard::new()
 }
+
+/// RCU head for call backs.
+///
+/// # Examples
+///
+/// Use `#[derive(HasField)]` macro to specify a struct has a RCU head.
+///
+/// ```
+/// use kernel::sync::rcu::RcuHead;
+///
+/// #[derive(HasField)]
+/// struct Foo {
+///     a: i32,
+///     #[field]
+///     rcu_head: RcuHead,
+///     b: i32,
+/// }
+///
+/// const _: () = {
+///     const fn assert_has_field<T: HasField<T, RcuHead>>() { }
+///     assert_has_field::<Foo>();
+/// };
+/// ```
+#[repr(transparent)]
+pub struct RcuHead(Opaque<bindings::callback_head>);
+
+impl<T> Field<T> for RcuHead {}
+
+// SAFETY: `callback_head` doesn't hold anything local to the current execution context, so it's
+// safe to transfer to another execution context.
+unsafe impl Send for RcuHead {}
+// SAFETY: `callback_head` should only be used when it's in the destructor, and accesses to it are
+// already unsafe, hence make it `Sync`.
+unsafe impl Sync for RcuHead {}
+
+/// A wrapper that adds an `RcuHead` on `T`.
+#[derive(HasField)]
+pub struct WithRcuHead<T> {
+    #[field]
+    head: RcuHead,
+    data: T,
+}
+
+impl<T> WithRcuHead<T> {
+    /// Creates a new wrapper on `T` with `RcuHead`.
+    pub fn new(data: T) -> Self {
+        Self {
+            head: RcuHead(Opaque::zeroed()),
+            data,
+        }
+    }
+}
+
+impl<T> Deref for WithRcuHead<T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        &self.data
+    }
+}
-- 
2.50.1 (Apple Git-155)

