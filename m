Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B92175A85;
	Mon, 22 Jun 2026 17:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782149605; cv=none; b=PPnEE8WTzEe1OLZxFd5m9Q2i8bUuiapvwTGPDywhYSS8g/fzsneuCvmcgsua4ObWl+aBvD/AcCGwZXrXZkI3v6CSHRDJXsNVM2mgmlbgHfgag69OjOeA+Ij89DK9LA5V2hcZKxzyXixERI1B4fLbWQxz0woRbEc4Zy8qyrQ5DPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782149605; c=relaxed/simple;
	bh=WPrJVzJV1qVMV6EA1bvwukUKLGMlywGIfC7thG6fw7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPUZG9/K8DmSaj0qxCJj5GbKz3qQZQfHZhY1sDEd/PTvJIF6T3hPPtKyOjGohxIHuSllYGftne5VECOl3A+i3Oj9LOPX/1WVnBMovIb7f+P5SQhfQnwhGgYFXPf+hgH+p4i/jMkfdl9J0nfmB3qgf9lw3un4+PWPUkT5qSRi0ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GL8ZXotb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GL8ZXotb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535D01F000E9;
	Mon, 22 Jun 2026 17:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782149603;
	bh=j0AqZHIVlNW8eG7pSltNIt0e97h0jSsmKwE7BD8uenk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GL8ZXotbZKQ5ATWdlppMsiGHtpgJlHZ+qTLSml0uY0gFknaqFILiWiMosl42KGRxq
	 kzi5E2cvrkQ72Uwy3+4vL7H1e3CtBPo0d+pN3Fa9lCsaLFp9GIh2N85I0Lyoat8WFv
	 lBbRGabj94nPQR7VZFH6cKAnI4ny4HgQG8aMGqlgqZMIb0Gk1r8+V6CBpxmsZw1XL/
	 2sPv1v3fK7l4Xu8YUr8jD35IcJCmTa076TIwt6IGFg/oYwjxwetif87GxPhs5SdIMK
	 dh5l7YrLITJEt68nMt90ft6K+wj6JvWD9r3bb+9fq4oeLBp6O+tnr7Mn4bPrxMvtBB
	 0HBiiXiC67HqQ==
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
Subject: [PATCH v2 2/3] rust: revocable: Use safe synchronize_rcu() abstraction
Date: Mon, 22 Jun 2026 19:32:50 +0200
Message-ID: <20260622173250.411377-4-phasta@kernel.org>
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

Use it in revocable.rs.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 rust/kernel/revocable.rs | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
index 0f4ae673256d..f539603349f1 100644
--- a/rust/kernel/revocable.rs
+++ b/rust/kernel/revocable.rs
@@ -7,7 +7,11 @@
 
 use pin_init::Wrapper;
 
-use crate::{bindings, prelude::*, sync::rcu, types::Opaque};
+use crate::{
+    prelude::*,
+    sync::rcu,
+    types::Opaque, //
+};
 use core::{
     marker::PhantomData,
     ops::Deref,
@@ -161,8 +165,7 @@ unsafe fn revoke_internal<const SYNC: bool>(&self) -> bool {
 
         if revoke {
             if SYNC {
-                // SAFETY: Just an FFI call, there are no further requirements.
-                unsafe { bindings::synchronize_rcu() };
+                rcu::synchronize_rcu();
             }
 
             // SAFETY: We know `self.data` is valid because only one CPU can succeed the
-- 
2.54.0

