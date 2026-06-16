Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA847411664;
	Tue, 16 Jun 2026 08:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781598558; cv=none; b=f8MPT+yBoj2NlQAyCyYU1uWMRhpvHSM9lv22v0rXOqzL+n/X3oIde0SzWtjfKVeKrpHFcIWVCAJb4ljfQqTjyILQvFW1WPm/o57LZNG5uLbNELf2u5I5bKex+szepFUf9Co5Wa1aGFU1sWMH+P8cSQ+ybhcU7DRg9glbIKkC/1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781598558; c=relaxed/simple;
	bh=86bBO8Ak0FXwxnzFY6WMMdnO28JETZTD9dGDreZM0H0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahT3cNiNYEPU4Mc8wvxNkMB3UQZZ9jd55ykRDuH/XDAHEkcqvpxxOy3dFtK42LejYBJC/lbTugpzpFCZ+NjdXLQu6S5qNHSm/JdvJXugWcEEf8XQaBtY0RbKTCxDY5Uwg0p/AfXYMdDn5ei3KtKZ5whT3zJIoUCABQfruCmqm+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RD20b727; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RD20b727"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBB71F00A3D;
	Tue, 16 Jun 2026 08:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781598557;
	bh=BeDFsg/78jza6BxYbsL8y7J1iZTkaCdIxTax0jYm0Q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RD20b727fukXgh3OpGE4FuJmJqG9s2V6+ZBoxiCrcGmCQncbcEyVDbuIrdTCRuszZ
	 Qy8IC44FTSzS9fBl3TPa0AsnkxUsCrQH59cc3he00BZNew2w6mf+t5oarx+t/4bo5T
	 MmjW6iM9qCM4OOGPDag9ONk0L3Lru98atRZOAWmOoZQqZMkFUWWyG9BniZ2Z0wtkbv
	 XntfOcbHTaPiroXZZbPb7xTka9xPiJyHKWJ9gtemOYnPVkUvmh7x8thelics3Ss6R9
	 eR/jSHzFKHB7+LFqJ7GHzzGY5sK2WWLaDpdwv+02QCHScJwn4V6OXNEmztcfD+lJ5t
	 mD51MxvN6uMNQ==
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
Subject: [PATCH v2 4/6] rust: error: Add ECANCELED error code
Date: Tue, 16 Jun 2026 10:28:16 +0200
Message-ID: <20260616082819.2943886-6-phasta@kernel.org>
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

The Rust dma_fence abstractions need the ECANCELED error code.

Add ECANCELED error code.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 rust/kernel/error.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 05cf869ac090..dda15db7cddf 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -88,6 +88,7 @@ macro_rules! declare_err {
     declare_err!(EIOCBQUEUED, "iocb queued, will get completion event.");
     declare_err!(ERECALLCONFLICT, "Conflict with recalled state.");
     declare_err!(ENOGRACE, "NFS file lock reclaim refused.");
+    declare_err!(ECANCELED, "Request has been canceled.");
 }
 
 /// Generic integer kernel error.
-- 
2.54.0

