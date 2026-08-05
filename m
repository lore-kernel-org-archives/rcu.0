Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4072D46CE;
	Wed,  5 Aug 2026 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785942124; cv=none; b=uKddV9d2nl2gkAEa3vHdrB4xH3HxYolcqCAitJbgkZHaEcvozUU3HZcqyPj+L/B0L16LAknoM//jtcdVdbcszfFBSAwOK44WbhyIQvcznwOTUt10zmAdc429YbeWiE8WVw/JMIR29VrJVTOQfqJ+j/1Lv1FOcjXLFhql4Fsm7js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785942124; c=relaxed/simple;
	bh=YOlv3o40GyVVy99CqrmV5kA8RFAg585fD7edIGWhAR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fXZ/LfTF8cHiC5QEgNfbXjSwwOz56DtsXj3kCzKt4ubpdhUwSY1wVGm8bvkwr2cvy9mt7lw5et99p98xkli86Zchgm76J+8zOCuKkKZl+yhheFd9mx00iErlHqW/O1M7xLFUC0l7vp0QClt7L4OQ3akGG5JO3YzQu3SCq+v6F5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GiPWknGk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GiPWknGk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272791F00A3A;
	Wed,  5 Aug 2026 15:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785942123;
	bh=ES4LoSb21zgaO4ykRP24VmWuxpdtjPaJPxGZBbKvNvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GiPWknGkRCtuMRgROKHnONNIBdarVWNcK71u2CbBh0K0HUWT3SqWuQ6mpA8CpNzhH
	 /9PHlVnh6piykDZOXABoZb9J+iVuNw8eOwRDV+DdMuN+Y3KATX9qHyBCc3stng8WfI
	 KJMPb04A4EL0OyFWEiGZVvOUe15PBIZ58cA6iwnVQm0KluzPZwBGoOZoNDT9J1cVDe
	 rR1wZJk0yIb8B+aP1hX7aCpTo5KYIa06cZKlC4onZG0SKN49qh9w2tLZ+ADSTrPn6k
	 B4uqxf4ggiBqoPcCxDdeS2bVq9EShUOqCyyGVFBga7U5EtnQoG6gC+BE/iW8yU5+Bx
	 BEuVzQv/me1Xw==
From: Philipp Stanner <phasta@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>,
	Lyude Paul <lyude@redhat.com>,
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Asahi Lina <lina+kernel@asahilina.net>,
	Burak Emir <bqe@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Eliot Courtney <ecourtney@nvidia.com>,
	Mirko Adzic <adzicmirko97@gmail.com>,
	Timur Tabi <ttabi@nvidia.com>,
	Daniel del Castillo <delcastillodelarosadaniel@gmail.com>,
	Boris Brezillon <boris.brezillon@collabora.com>
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	rcu@vger.kernel.org
Subject: [PATCH v9 3/5] rust: sync: Add abstraction for rcu_barrier()
Date: Wed,  5 Aug 2026 16:59:45 +0200
Message-ID: <20260805145949.938505-5-phasta@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805145949.938505-2-phasta@kernel.org>
References: <20260805145949.938505-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rcu_barrier() is a frequently used C function which is always safe to be
called.

Add a safe abstraction for rcu_barrier().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/sync/rcu.rs | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
index a32bef6e490b..7031ca5d2473 100644
--- a/rust/kernel/sync/rcu.rs
+++ b/rust/kernel/sync/rcu.rs
@@ -50,3 +50,23 @@ fn drop(&mut self) {
 pub fn read_lock() -> Guard {
     Guard::new()
 }
+
+/// Wait until all in-flight call_rcu() callbacks complete.
+///
+/// Note that this primitive does not necessarily wait for an RCU grace period
+/// to complete.  For example, if there are no RCU callbacks queued anywhere
+/// in the system, then rcu_barrier() is within its rights to return
+/// immediately, without waiting for anything, much less an RCU grace period.
+/// In fact, rcu_barrier() will normally not result in any RCU grace periods
+/// beyond those that were already destined to be executed.
+///
+/// In kernels built with CONFIG_RCU_LAZY=y, this function also hurries all
+/// pending lazy RCU callbacks.
+///
+/// Note that this is one of the RCU primitives which must not be called in
+/// atomic context.
+#[inline]
+pub fn rcu_barrier() {
+    // SAFETY: `rcu_barrier()` is always safe to be called. It just might wait for a grace period.
+    unsafe { bindings::rcu_barrier() };
+}
-- 
2.55.0

