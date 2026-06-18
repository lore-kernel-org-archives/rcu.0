Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B6D3B5839;
	Thu, 18 Jun 2026 10:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781776872; cv=none; b=AatjWQ0tNw1cDDXIWt1j3ZVqAgjBOUrnQNGCOd+/OCLUo2WRPF1kM00wpzFwq9yMmv2R+4tqf7v4PT4MqzeuJe9Nz+80fF67qRwWkoXT8vzrw+EKWPG+DQvjRHy43UKEtn2qZoHiNnQ0WQRhB3MBGT79cu1r77veTdOU7lQqNHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781776872; c=relaxed/simple;
	bh=VNeO7poUfFWbgQNDHO5CryZUV/RBMwP4z6Tx4OUWfD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GvuACl3Yj1NiewpHFyO0ODAJsNIW4J6Ua1oKLGcVg6tKLBuKaoDVYPnCkIDHa7Jv9HwpI1ebEJ+ZvModWZkNBqvG/r0Sdjg2Hx6VlCwIjVDWspqAwPJHhSGkP/pvT6ABnpx8HE+TPEpQcCA6OzyA2NsoXaj8VED9autE156Ef6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+Sxb16l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+Sxb16l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA591F00A3D;
	Thu, 18 Jun 2026 10:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781776871;
	bh=fp5BohUdxSO9dl+7Lasz2DT7C7uvOPkwGRxzZG9K/+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W+Sxb16lXDKTX2T8oGTmiLdSPevJ8lOadUjBo6vDB95vugveSAJd6lTUF42EnrUzn
	 Elg1iRfMp4frZQA3ovZ716CtG13QpDthHgRJzmshFY2QuSVmrpbzk5PsdBn2F9PJfX
	 Qc1IGONMss3qUL3+CRmo3nSvUO3Q6ouCVHt5oMNBCD5O4B//k+Ncl7VJXP5cenqOrT
	 pEGl3E6yTI9apTu3eNFv1u5v9D9pjdyuiJa1qifHRSbtVzkXOBTtRv5V9tmSwPwbW1
	 tzcd1LoTsJw6A+8sVeVCR8GY1VFworPXZjxKBrZ+pCJ/LjofwjeswjelNrVi+LqZz1
	 CMYnFFLNOZxaQ==
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
	Philipp Stanner <phasta@kernel.org>,
	Christian Schrefl <chrisi.schrefl@gmail.com>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: [PATCH 1/3] rust: sync: Add abstraction for synchronize_rcu()
Date: Thu, 18 Jun 2026 11:59:50 +0200
Message-ID: <20260618095952.3687099-2-phasta@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618095952.3687099-1-phasta@kernel.org>
References: <20260618095952.3687099-1-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

synchronize_rcu() is a frequently used C function which is always safe
to be called.

Add a safe abstraction for synchronize_rcu().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 rust/kernel/sync/rcu.rs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
index a32bef6e490b..9b9addf8fedf 100644
--- a/rust/kernel/sync/rcu.rs
+++ b/rust/kernel/sync/rcu.rs
@@ -50,3 +50,11 @@ fn drop(&mut self) {
 pub fn read_lock() -> Guard {
     Guard::new()
 }
+
+/// Wait for one RCU grace period.
+///
+/// You typically do this to wait for everyone holding a [`Guard`].
+pub fn synchronize_rcu() {
+    // SAFETY: `synchronize_rcu()` is always safe to be called. It just waits for a grace period.
+    unsafe { bindings::synchronize_rcu() };
+}
-- 
2.54.0

