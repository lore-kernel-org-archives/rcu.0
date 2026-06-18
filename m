Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8385E3DD529;
	Thu, 18 Jun 2026 10:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781776880; cv=none; b=Zu/TGOwHadZ1woT960tuEGj8VTjzPzb4SCppR1r/r/g9515xh/s75GPW/KuA6ALr8oF2fv74MsIvBuRfe80806LKUWS2NA93wI7S1Xrv1S0H5BN806/s/2BYsOhM+3qIjKiyyTxk+ggD2KF4nXoOG1h+h6DVccNbZJvxJPWNEg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781776880; c=relaxed/simple;
	bh=UQeWOeeISozzBbLkPlIIdJ3M3iLBOvvaurqH1Ny9i2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jXwvHb+Yevi7zg/xc1qEn9F0YxqNq66eIMbG83WX9QlW/DTddzYMb9QoKNJKn0f9IbqudnMCPaqxMLBCyPKiljSaGEJB4K7PNAuLOkXO3eI8VGvNhf7TgsYkdEQ+YWNkSsEFOYAR3diCD7l82+P/pwtPuxwLCyO96EMGjrruYds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H38arIuE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H38arIuE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F6B1F000E9;
	Thu, 18 Jun 2026 10:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781776879;
	bh=j+iLLdUeSfRLT5BvjkUONmocvI3rlTHmwrGh4d8H/sE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H38arIuEW5PzKQ7pd6KftFtqEyNZvAnK3dk9DOxxqvf1pjtBefebUOWrf04slInJR
	 yW3sGsxAbBFG37J0pvifGkU+JMxl0qcCvryB6mK1s/W41TdJPWjWXIBzp3+fDUvCF6
	 C1xLCztPO3jWaL1EVbNtHPOvMrD8NwAdTCaExKQFe9m6Nj+W6PXNbdTcpGY3fat/tB
	 xohA6y1F5ZQrXfilGaA5yqP2fJHT9jRbx9O/83Yhbmxx53X9qU4+n2IW0S9TrNUR/D
	 S+UlGETTjCwOPVQJhkWzG26lcoe+UaJ2wr0aHsqAruWvtVpv/wb0jdohX2iEcbwYiT
	 32AaSRWtfMOWA==
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
Subject: [PATCH 2/3] rust: revocable: Use safe synchronize_rcu() abstraction
Date: Thu, 18 Jun 2026 11:59:51 +0200
Message-ID: <20260618095952.3687099-3-phasta@kernel.org>
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

Use it in revocable.rs.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 rust/kernel/revocable.rs | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
index 0f4ae673256d..66d4ee38754c 100644
--- a/rust/kernel/revocable.rs
+++ b/rust/kernel/revocable.rs
@@ -7,7 +7,7 @@
 
 use pin_init::Wrapper;
 
-use crate::{bindings, prelude::*, sync::rcu, types::Opaque};
+use crate::{prelude::*, sync::rcu, types::Opaque};
 use core::{
     marker::PhantomData,
     ops::Deref,
@@ -161,8 +161,7 @@ unsafe fn revoke_internal<const SYNC: bool>(&self) -> bool {
 
         if revoke {
             if SYNC {
-                // SAFETY: Just an FFI call, there are no further requirements.
-                unsafe { bindings::synchronize_rcu() };
+                rcu::synchronize_rcu();
             }
 
             // SAFETY: We know `self.data` is valid because only one CPU can succeed the
-- 
2.54.0

