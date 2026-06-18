Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B6E3B95EB;
	Thu, 18 Jun 2026 10:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781776887; cv=none; b=bBMfCyXMjhPwb4+bgbfhbklhVJkMqFg60nopLUUokHteMTNXBKp+iINTkQpIwGsn8we5TitFgN4GUYAho8DMkpl2iwe7nnhXscUt313YzP8+lSJYsqmZJ0J7GExJjNbfVwlskMm1ZtoNMVM3b7KMn3JSwoDCNUEJqf3m1hlYjqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781776887; c=relaxed/simple;
	bh=G86LS/3WWxBnj2jeQ5Dv+hm4OYuivRxGfT53OFr2i7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qsynWfyNeI75WJCMi9Lc6S5Wson9dbY64RQ76q9yZY2cX4/U16sJuB4pBL2bqkcn97/nNOzY3SUMve8i8WcarAMrSLP0yBrE0CUVu8TVCJ4Z/p2wMCwZYtGqL61Yt5sxVOm+7NIsfM2MG/lh28PyJPeYbbbE+nCwolYu7aqyuyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8wR5A3C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8wR5A3C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1E01F00A3A;
	Thu, 18 Jun 2026 10:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781776886;
	bh=PTRGT4sUPvIVF0m5lxyc+4VxE2uHkimr8CsYPihxlqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b8wR5A3CQWH1T2RFPk+/5DvO7BC24mmfdo7DpzvdP/g8cWoP6rd2KHndACIvTfqjJ
	 EcjTJ50SQTPFGIuGoWxXiI3jtQ7tvXYBq1IFWF8OXFrcL0In+VdbY2A+4OBxdQxtlB
	 Gv6lkpuXTRRuoION/xXDmEgopFoimCodJWbvv4yxRJK9n4gJfzwGkLM4ilsOAev1an
	 GHWlh6N9M94dfkZteRiwzRMLfuRbs4OrpV09bIBHwtv9h57j1bdqReDsxYphny9ReK
	 wgLKWohgZ5UUlY99bL1KZslmU/xGpaI6AGaGIyk4Lcnso9aleAW6n1HR4LCL2+cMaM
	 TzIlRT5rmEWgQ==
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
Subject: [PATCH 3/3] rust: sync: Use safe synchronize_rcu() abstraction in poll
Date: Thu, 18 Jun 2026 11:59:52 +0200
Message-ID: <20260618095952.3687099-4-phasta@kernel.org>
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

We now have a safe wrapper for the foreign function synchronize_rcu().

Use it in poll.rs.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 rust/kernel/sync/poll.rs | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/sync/poll.rs b/rust/kernel/sync/poll.rs
index 0ec985d560c8..401cf4d3f35f 100644
--- a/rust/kernel/sync/poll.rs
+++ b/rust/kernel/sync/poll.rs
@@ -8,7 +8,7 @@
     bindings,
     fs::File,
     prelude::*,
-    sync::{CondVar, LockClassKey},
+    sync::{rcu::synchronize_rcu, CondVar, LockClassKey},
 };
 use core::{marker::PhantomData, ops::Deref};
 
@@ -99,8 +99,6 @@ fn drop(self: Pin<&mut Self>) {
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

