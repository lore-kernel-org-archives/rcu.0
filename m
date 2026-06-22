Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDFD219FC;
	Mon, 22 Jun 2026 17:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782149598; cv=none; b=rJtUnTMh5koHk31giTLSdGFWhkELgQlemxZBkKYvx0oHBt9JL4mbJ9oWwbGDgzktZ4S9Gy+5fp4YO0zKBp3NCwtZ0W2vvdTcIa04X75hLujSXy9VDtR4F6x8PrKVPuLGo8jshVdxmo+p9UeXdRaiPNLmaSIjr3/lna91aq6uFSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782149598; c=relaxed/simple;
	bh=MmWmbp3psQRB8FMJKZ4kxbtGI7gjYpqYlmlK/U3VFvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7Pc+WxR1QGSbqwd8E6zuBjJaqJLZHS8H5MF9dDXZt/Ab0PNX1ossOu/Rbl3OWQWj4Rk19HOWs7haUxVD0yBg4H+Bdo0l0ovccdXbV+hYv4+Ih11GFkHeGKO1Dt2HY+fmb7WEILXQnxOIGq5cWzSLG/1WwE25rx2digqu2VCkqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKe+L7wG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKe+L7wG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C20C1F00A3A;
	Mon, 22 Jun 2026 17:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782149596;
	bh=0H9+j8xU14ojeAusiT/S9ewMb6vGU+bjLhSKb3U4MUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LKe+L7wGcyHI92Ar7eM3mESEpfiY9j6p5Wv3YMe8CpS/ftoIehIGMcByNOvK2xtbE
	 HOGPYzOY1FxJFGBAiDPeB2GeKVabdnBaKZnt8GmTJf73YTQqitJ/Bhh/GlRdY5SmNW
	 04aQUttbBPNf+ZllyPSPi/dNShohQNbfv8fVjVIDoeM/B9x6ZYdb+ZFWIc1FQ7T+Jx
	 m61S8OzA0zjrmMtTVBfX5IcIMAfcXm/rSwnQWfiIxWaUJOcVZ6/me0jqi8DWu2j0qM
	 rd0ybZitonSJA/IWl4P8chNwDf83TLt8MqPAYY1ySeWHJV9BUpu4vxClfRRSq4PJmK
	 wsKIcysjmx2YA==
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
Subject: [PATCH v2 1/3] rust: sync: Add abstraction for synchronize_rcu()
Date: Mon, 22 Jun 2026 19:32:49 +0200
Message-ID: <20260622173250.411377-3-phasta@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622173250.411377-2-phasta@kernel.org>
References: <20260622173250.411377-2-phasta@kernel.org>
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
 rust/kernel/sync/rcu.rs | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
index a32bef6e490b..0d438ef31766 100644
--- a/rust/kernel/sync/rcu.rs
+++ b/rust/kernel/sync/rcu.rs
@@ -50,3 +50,12 @@ fn drop(&mut self) {
 pub fn read_lock() -> Guard {
     Guard::new()
 }
+
+/// Wait for one RCU grace period.
+///
+/// You typically do this to wait for everyone holding a [`Guard`].
+#[inline]
+pub fn synchronize_rcu() {
+    // SAFETY: `synchronize_rcu()` is always safe to be called. It just waits for a grace period.
+    unsafe { bindings::synchronize_rcu() };
+}
-- 
2.54.0

