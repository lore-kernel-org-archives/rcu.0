Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3803D812C;
	Wed, 24 Jun 2026 15:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782313697; cv=none; b=fna4NNeNYdb1dPhA6h4OTvrJrEC1Znr1/Q/7W81K+rytKC2JozodTGZnRGhXfXFD6yJE3472+KgP04Gvn9PSB8gSsxAuYcL2PxK00mLzNV9gubFTO9LaigXH253mkWtowfrjyUVoCEFDeboBVdo8bVSj+F0soQREYlfdboHxzOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782313697; c=relaxed/simple;
	bh=QpPEyTQPIUe7kXxwCd8ITZ3Gqymx8ZfKuqP7cAJqGw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CEXQ7d0Lhagrbya+uDzkiWGwpENuaEn61oqjJHknvNVHFpqSHNwbKnWk/Ivl2mEba3j7uxWD9r8741560Gu+QYEImhny8uQ7Cj00rhjCoLOjdh1Wpxy+goKeKWVy/WpO/TlyogBplHSuxa6HruR/sZB50NOAX9f7vF+R5eO/QUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsnX0mcl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsnX0mcl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739EB1F00A3A;
	Wed, 24 Jun 2026 15:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782313696;
	bh=/15rZp5J+5hhi/NEwgwmgmvlufjRxUwfqhBNq2kTY9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PsnX0mclkmLqtUByWOrKGoNfZVXxvEeAy1s8iRdmXUzo7iMr6ejJwNofEOY1V92WV
	 ADWFnRvF26jTJEftqevm/iYK01/9cdGM1iq3sfpCfLC6428nQLO5PCgz38t622muW9
	 /FYsApT6D2LreVDvSQ0oEhFooI48TFEJGlCcFSEGkdg9s7r+T3ovtWv5Xri53JbRwu
	 zOi//iuQiJdvsU/pwqjVGixpFq7I0LS8bSftFdaXD1CXyQSJtbGhl35IaQNEDp3m++
	 iTi9V5Bw7cSRjXMPnl3TswzaIWpj6i7111FOYCIwv9zzgccm0GxXSR4rMAECiVZoGB
	 KR+p3A9n8H0Ag==
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
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
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
	Christian Schrefl <chrisi.schrefl@gmail.com>,
	Philipp Stanner <phasta@kernel.org>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: [PATCH v3 1/3] rust: sync: Add abstraction for synchronize_rcu()
Date: Wed, 24 Jun 2026 17:07:02 +0200
Message-ID: <20260624150704.1504001-3-phasta@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624150704.1504001-2-phasta@kernel.org>
References: <20260624150704.1504001-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

synchronize_rcu() is a frequently used C function which is always safe
to be called.

Add a safe abstraction for synchronize_rcu().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
Reviewed-by: Onur Özkan <work@onurozkan.dev>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/sync/rcu.rs | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
index a32bef6e490b..2bae76d229f0 100644
--- a/rust/kernel/sync/rcu.rs
+++ b/rust/kernel/sync/rcu.rs
@@ -50,3 +50,19 @@ fn drop(&mut self) {
 pub fn read_lock() -> Guard {
     Guard::new()
 }
+
+/// Wait for one RCU grace period.
+///
+/// Waits for all RCU read-side critical sections (such as those established by
+/// a [`rcu::Guard`]) at the moment of the function call to finish.
+///
+/// Does not prevent new read-side critical sections from starting, which may
+/// begin and run while this call is blocking.
+///
+/// Note that this is one of the RCU primitives which must not be called in
+/// atomic context.
+#[inline]
+pub fn synchronize_rcu() {
+    // SAFETY: `synchronize_rcu()` is always safe to be called from process context.
+    unsafe { bindings::synchronize_rcu() };
+}
-- 
2.54.0

