Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DDB3D9DCE;
	Wed, 24 Jun 2026 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782313704; cv=none; b=JWFXZMizGTs2eFsrCS0cIhN8v9vG+85bRLMCB5TtIkP+joNis3MtiJWlRE44V+0ol7avCBvtszjIj6bHBdMoKeRMjfVVNPWWuJm9Br2yJidxRyNbjQxeT8QafPmg8HfY5dU/j5IrRDyqz14neNljDFLgBiEbBDt/eecr3rRGbrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782313704; c=relaxed/simple;
	bh=yYne0D+X95Cl2x0+B31Bu36L/GB1ulKPzVKk0W7po5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A8+5Nyh1TLOcatUdcT+L/E210aejsGQFXSwYf5xMuf9njvVj3dFH1bUFTRAzTvwJBidGryMKyH3+Z2fLIwQXON4oZd9DnHX6syQYagKuooC6xPH/ddkn63nRSeQFu/uUdOpTKRI+GldjnrX4IuIm1Lwwrkp8E2TsYZRIYsKirRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AB9k+9Ib; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AB9k+9Ib"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30361F000E9;
	Wed, 24 Jun 2026 15:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782313702;
	bh=V87HSt3XX1YmkoA+Yfy8+hIojz3pOrFUFJ8qDbErYVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AB9k+9Ibv5J7HrWUQGWjJmvBwLURNW4SSnIY/mU162CTBihemON1A69r1iI+yYwwW
	 GL+wB8RVlpQGIe3H2NLok5t1skRV83lew/pZ/yZ8SChavOu4EH+8LNfzW4XfoMnMnt
	 BQKtXe0b6AhlqStBzrKlr1G23bOHtGPIssES3Y1JEEkeovr7o+HspJa0NCNRr8uXmi
	 wYokvo8isQa9OEQxYm9tm4q0gyT++7KMgMxAqjFMCAxMMgOQSdObPA4BADKyncwYvq
	 ddGgkDwpucBytz+tdb46aq1rNFFZe9UMzRoclf35cXKOPNy+Wl1fvhKFfwcFCimISG
	 TjYVfKprPShhA==
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
Subject: [PATCH v3 2/3] rust: revocable: Use safe synchronize_rcu() abstraction
Date: Wed, 24 Jun 2026 17:07:03 +0200
Message-ID: <20260624150704.1504001-4-phasta@kernel.org>
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

Use it in revocable.rs.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
Reviewed-by: Onur Özkan <work@onurozkan.dev>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
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

