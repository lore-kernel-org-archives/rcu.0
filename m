Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB843264FC;
	Tue, 16 Jun 2026 08:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781598545; cv=none; b=mk5llPOtopbZ4CnDBB3HpG5WKHxmyAeMI8QoABEaBMYWr9vk/TSPn86oNwQY5ulO0nJreLfmiyUiA24q8Fr/oYZTHsc4gGMHUU2mNl6QKi3uziK9iRszi0sJaU24FQt6w3DQ5w9sfDty23TA3l32Jsm/wHM1E0r2eaIzfl9q+ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781598545; c=relaxed/simple;
	bh=uXXhcbssVJPY3FgKTpSNnGk0LDr3IofydGVrBbqGdKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABM9gV8tlEz1v7vzXu6uFzx8N1mAP4OIr65uv1bY7+L5XrE8VMBk+K1zOOhQ0xMc+FcWgvj+g7nfNKTVcaIcsoiDT9BiU19nWSNbzXvyDXyugtJNltwnfo6EB0vgZtUmmC8d7pAsVwTpdsXMxLkCUArAstKogm05Dn+RrOGPa7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZUqxcth; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZUqxcth"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973EE1F000E9;
	Tue, 16 Jun 2026 08:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781598543;
	bh=nwjdFbfnfPzy5MFpaG+40dlKcUPGMH1BdGJi8LOKcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DZUqxcthi5ZMT1K1S3XI9wRabvel3Rk34VN4y1cGuJpKhgUEt9qkBJp2YoTCV5nW5
	 Nhavv2LhokxnXKwIN5+vYoxJtzBC5HlzY51gVojmO5EeUuw2guHEAcV97QGzhzY0v3
	 UnZKLzoSV55HBCewq6DGf4Eu6LOQ58D7hg6RFPoMr0sYXsMjA04BMaODDCE0OUiHwn
	 71kbgXUIlsM255O0ZLeQ+il2Q2u+8V2p6mZ47PdTQVenjayLKr01DponxBHQVMyUA5
	 gvK3Uzu+oOX0CBicye+o0kZXODRk/y/qt8GJaUAu93j1jlrNVL5t2iz+kwyt3V+Wmh
	 gNLQc9dY20flg==
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
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>,
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
	Daniel Almeida <daniel.almeida@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Igor Korotin <igor.korotin@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Krishna Ketan Rai <prafulrai522@gmail.com>,
	Shankari Anand <shankari.ak0208@gmail.com>,
	manos@pitsidianak.is,
	Boris Brezillon <boris.brezillon@collabora.com>
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	rcu@vger.kernel.org
Subject: [PATCH v2 2/6] rust: sync: Add abstraction for rcu_barrier()
Date: Tue, 16 Jun 2026 10:28:14 +0200
Message-ID: <20260616082819.2943886-4-phasta@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616082819.2943886-2-phasta@kernel.org>
References: <20260616082819.2943886-2-phasta@kernel.org>
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
---
 rust/kernel/sync/rcu.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
index a32bef6e490b..eef34bf86259 100644
--- a/rust/kernel/sync/rcu.rs
+++ b/rust/kernel/sync/rcu.rs
@@ -50,3 +50,9 @@ fn drop(&mut self) {
 pub fn read_lock() -> Guard {
     Guard::new()
 }
+
+/// Wait for all pending call_rcu() callbacks, if there are any.
+pub fn rcu_barrier() {
+    // SAFETY: `rcu_barrier()` is always safe to be called. It just might wait for a grace period.
+    unsafe { bindings::rcu_barrier() };
+}
-- 
2.54.0

