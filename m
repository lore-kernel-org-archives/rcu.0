Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20D31A680E;
	Mon, 22 Jun 2026 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782149611; cv=none; b=sik7YMWMalSabxuLxnsvJKA1xwxUXIwgiAPK/8TnYcyZt3cWMj9RwTj1ZOlWN/+UxL/lngxbxwEToBwKKDqpCynBbZZ4LT1HBkfPsMqwD3vJMH9WoNLvFxDdPSOHGCL/bKwWXyF69D2QNHNT0UCmQTXSJ/VNWBWAkB9BsaRFjgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782149611; c=relaxed/simple;
	bh=uKSc6qrx7IuatnJmOjo8996xDEFbNY5Q9ErD7q8awVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+tjepOJ6rDWpK3+shh0AgqDlOV2e6w15tiX2KLHN6aocp2XCZEGb4cEYZoPqonNHfCgkGqRTwbc0fTK7mlUgMYmrXoJGV/V23koMGB2OYoaInXd9INBcLY8s5OqpNvtzA31/5VZrPn5Sw8m1D4eA023ZlsusDgOgEr34N7uOOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkC4Lqn4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkC4Lqn4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27AAC1F00A3A;
	Mon, 22 Jun 2026 17:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782149610;
	bh=m49MKTSc1P/p1L29za4J/TD61X+wV5tL/oQX4CgdDdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PkC4Lqn4fR8S/mq4IYUohNFpBYX23pLJ5UZF7j+rD8AU1i08fJFSv9sNso03Krz98
	 RCM8Js22sqhi6VyinI8zIKQNEvBjKy1vjiQ8OUStcdrN8NLGzpSDH0FN79nGFXVBT4
	 Ud2YVi6aOsPG7Pn66MkFFW1IxHl6ETOMUiF88QjgKQxLCMHSbElxUtxFsSL/RhVltC
	 fY4xmitmN9pRFkyUuO9Q/tc3adusCwiJ0I6ThLsY6P8nx0JhOTHv07tYq5sf58yq+g
	 KqI/GFtyizw5/lwqLhGSB/zNf5Jv31ygLC89H+VGB3VSrcQ6snZVBijpB1/repoz7R
	 9K0Yc2SNV4DEw==
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
Subject: [PATCH v2 3/3] rust: sync: Use safe synchronize_rcu() abstraction in poll
Date: Mon, 22 Jun 2026 19:32:51 +0200
Message-ID: <20260622173250.411377-5-phasta@kernel.org>
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

We now have a safe wrapper for the foreign function synchronize_rcu().

Use it in poll.rs.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
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

