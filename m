Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25CC3B7B7B;
	Wed, 24 Jun 2026 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782313710; cv=none; b=QEYUsYkfdApGAZgMp7zHPpQHA+KXtq6Xv4T6Lr3AG+Za0D6vnCRPMupSDOjwSDlBfjMCwW3ezWmJPTmbx03GFHNhYk63x3/ywWUZIkmlAu41ix/etIYVT5Dk5T0i+VDLoVGrD+XfGhcdyXEvgYBMS5K2k0zGgr9csg7rskzwNzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782313710; c=relaxed/simple;
	bh=ixVdxvzg6b2oe5t1Ktlqhs3s4ctGCsiiUG/ywZD/2uE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z3OiIqP1YsgROnDxQpcRnsvK44QTdys+RiYikq+mWymrKixeQDH6Ve9Xk7RSQ5w1QYOKmvqJWdPeO1LwHgMALSre+n6QQ79OgyUf8+U4BItBy9MavuU4gBerUFgBTYCMYJKOoyGfrYuuZAn4y2anwwKSBEOzjO1oyPJG8oldGyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCnYnMgw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCnYnMgw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2411F00A3A;
	Wed, 24 Jun 2026 15:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782313709;
	bh=oWpBZhQgcDVYolqCDxpBe+hQAWtESLlt2fqRA3juz7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NCnYnMgwEKsbkKCsK08f/yJRsIMm1TdlKRdnXFv9vqKwo87lZJFmI1YWhF5b19NbM
	 Z2t9lbrq9ifc3wH3kTktb1EajWjY5mBwEoWeOjyBGFL5Jd2a7zizsCL2ccrNd5a/i2
	 yhxZZeMAqMMmlToTb92YODEvfXXes5tbgsCquy0GCe2Dy3ybDLibWOwERsHxxNVQwy
	 HvgbVYYou3srMwx7ybDZL33O2jBYYnO8lV1gp7aM4q2Qs4s4WiIm3IFcG8ImawDvYE
	 51BvwYuDg0GAI2nTb4XN/a7go3P2P3wrtG352pwQ0nOKyznltlkwp6fp03BlvRHKJB
	 LZkVwUAIxpU4w==
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
Subject: [PATCH v3 3/3] rust: sync: Use safe synchronize_rcu() abstraction in poll
Date: Wed, 24 Jun 2026 17:07:04 +0200
Message-ID: <20260624150704.1504001-5-phasta@kernel.org>
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

We now have a safe wrapper for the foreign function synchronize_rcu().

Use it in poll.rs.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Onur Özkan <work@onurozkan.dev>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/sync/poll.rs | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/sync/poll.rs b/rust/kernel/sync/poll.rs
index 0ec985d560c8..30ebeea1702f 100644
--- a/rust/kernel/sync/poll.rs
+++ b/rust/kernel/sync/poll.rs
@@ -8,7 +8,11 @@
     bindings,
     fs::File,
     prelude::*,
-    sync::{CondVar, LockClassKey},
+    sync::{
+        CondVar,
+        LockClassKey,
+        rcu::synchronize_rcu, //
+    }, //
 };
 use core::{marker::PhantomData, ops::Deref};
 
@@ -99,8 +103,6 @@ fn drop(self: Pin<&mut Self>) {
         unsafe { bindings::__wake_up_pollfree(self.inner.wait_queue_head.get()) };
 
         // Wait for epoll items to be properly removed.
-        //
-        // SAFETY: Just an FFI call.
-        unsafe { bindings::synchronize_rcu() };
+        synchronize_rcu();
     }
 }
-- 
2.54.0

