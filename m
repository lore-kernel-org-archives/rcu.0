Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF05283C89;
	Sat, 18 Jul 2026 05:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784352787; cv=none; b=SK8n4NVtNqHKbxyK+7h5MtbWYeSWeKv9hr9eHW2ltzF/bl1IMYt6cL0flQorK9bJBUs8fZrBGy/Rrg+PCCKkv96wg5YYBHc9I7l4HLkr6lSECXO+BAkP6alzt1awTeDNiiPWGBzp/BkE47YBjM7LSfnnfI01UKHJ5aQ5rzaA5w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784352787; c=relaxed/simple;
	bh=uIFlwPvC9oMy6KK/16uEdJeefp5bhJkW7mFN++IULVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8+aq/kurcy87oZCMyPQAwEZLV5EFnsUBqJ5jR8VKKqB8M+Fl+n3Gw7x0X+H+uZSsCt+Xurf90hI0mouPGBCH542nAPpQV0j4WDEnUCm1z20CTgtbc5VAUrWL6ANZtYBrO6beDBLx4wBvKAN0MpB50ezPuISXxapjZjNmhNgo24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwbqhS59; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwbqhS59"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D2D1F00ADB;
	Sat, 18 Jul 2026 05:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784352786;
	bh=agZo2XMu3L0K2ubakxGylN/JFYjmY5Vh7gaRmN8isS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MwbqhS59pHFX2y1bjCbULv/pCDqqg/3CNZTpDqkOxuqIBllpv6JuP2ceX0z4ojwaC
	 hFcGSdyF26rxMWJerVgJwtbmAMxEaiNAZRCba8S6mwOIsS1xmVj0mRmaV9xuhV2YMi
	 BVgHXSxVwuvhrdOqZ1zuvlp+lIhZbP8Et1IjKpLehemcIMVQm5B82uXKWjO/8IdEhs
	 +MsHZn4wxWxhILUdNXdR8MeVp5F4MHKZjegrurQn2HatPRi4P1YswdCYvni7/ombXc
	 sVC1628sS6njMIV6WsvNjc2olUvHZlDljdFAlSQj63c1HcaWsn4q3UExFh6mwES36f
	 sYOXLcAJwL4BQ==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4D860F40067;
	Sat, 18 Jul 2026 01:33:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sat, 18 Jul 2026 01:33:04 -0400
X-ME-Sender: <xms:EBBbaj7smxn83ZTm-rtchhuFHn_J1uG8HTPM_b0Jov5Z6zMRYqTWyQ>
    <xme:EBBbaislG9lSmEzDeTSBqiG8TfuS5kddi_bFm5zdVBHXhYdBMQIumwBssIwOUFeFe
    lE_-ZeGYT8MrCdV6NWNRg6EG9_xmfLmOdCqfztalPMjTwixVeMnyg>
X-ME-Received: <xmr:EBBbal5yWjXMOycQcWfUGwfV8Nq3rTzQoN40jP1QHnBaXUGFA5fu3T9jIbY96CvBdJuMWmWcDdisCd4jpuhJLF0mFPBgw9fz>
X-ME-Proxy-Cause: dmFkZTEgEAJxx43zj+N2HexbcXxXpr8iZewHIC+wBoUe/3kHvIsxmf0uovnwyzmQf22fh5
    PbBpjLE4M1x+gkTl4x5OuQgzkddFgVOLc7SPm8OVC3wj6PmDWqpG/wyzm0HbMF//9RDtvM
    cqERhXH8fRAethPTEdiPCDM2biIjvo2duSrcDNiRwIZ4PJTMN9f05eRQvmRRsxcI1+ZGXR
    GIOp0pU8kR4mYsSetTdmMF1Q09Qod6lgNc4Vx07svlwAfyl7KUdd5xFGJoXDRG1kaoRL4T
    /VNW+87mn/mN1dMvhE363j1dLxUYIFMMuhRaBTcK4fjHHNruAjFs082R/vn5pb6pwik6oO
    i02M8fONfup6UUyVvWAj3LIiaccJx79xi00AFE7MEV3WF030lZ8xA8SpsEi6Gl4rTphLm7
    W85qiFkiPnFPEyGQsPlpzBH5SC88pTqTl7zHOgB1UizF1X8HWy0pjCGlfqlb5KhMIGeksB
    BM77F8Iz5gz4nm5AaBX89I/O5EsTxlSPFMjiVPNKun4nrYJZwlRKq2rf9JutxjHhCePeF2
    ZUczb4x89X5B2J5KgEEM0Ar+g8NYdZYNAfHEmuK+asohxaGqvLq7z5ddhcnnsaaXdjRYl3
    r6LYJ4YMNhLSLVbKF0j9W9SxoIz0cRSZGuTCLSTBHjntmeBEzvh958UnZESQ
X-ME-Proxy: <xmx:EBBbagixoAn4NfGLg6GeFhzLUwcXIZIBeXyEZeYnLz5aj0py6EDOqA>
    <xmx:EBBbaiBWT_NS0ZQPxYY6vnvl9Rhf3-nz11D2_vSMzHUGZZygCSMxig>
    <xmx:EBBbahx_hbx--ds4B21T3sC1uDxy2Dm_S4kb-yp4-EJAyXPU_4_VKw>
    <xmx:EBBbaoOWJs9BEXIaxncMVgvJVG_DSsqlsbHSTwLTaw1gRwBYX0W0zA>
    <xmx:EBBbagfkMvuzqP3RAuLyvp9Lmq2CmuaxHd0KOCBz6k58pua4BQV3yK7a>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Jul 2026 01:33:03 -0400 (EDT)
From: Boqun Feng <boqun@kernel.org>
To: rust-for-linux@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	"Liam R. Howlett" <liam@infradead.org>,
	Andrew Ballance <andrewjballance@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,	Jan Kara <jack@suse.cz>,
	Lyude Paul <lyude@redhat.com>,	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,	Zqiang <qiang.zhang@linux.dev>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Asahi Lina <lina+kernel@asahilina.net>,
	Matthew Maurer <mmaurer@google.com>,	Lorenzo Stoakes <ljs@kernel.org>,
	linux-kernel@vger.kernel.org,	maple-tree@lists.infradead.org,
	linux-mm@kvack.org,	linux-fsdevel@vger.kernel.org,
	linux-media@vger.kernel.org,	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: [NOT FOR MERGE] [RFC PATCH v2 4/4] rust: poll: use kfree_rcu() for PollCondVar
Date: Fri, 17 Jul 2026 22:32:47 -0700
Message-ID: <20260718053247.25154-5-boqun@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260718053247.25154-1-boqun@kernel.org>
References: <20260718053247.25154-1-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alice Ryhl <aliceryhl@google.com>

Rust Binder currently uses PollCondVar, but it calls synchronize_rcu()
in the destructor, which we would like to avoid. Add a variation of
PollCondVar that kfree_rcu() instead.

One could avoid the `rcu` field and allocate the rcu_head on drop using
a fallback to synchronize_rcu() on ENOMEM. However, I'd prefer to avoid
the potential for synchronize_rcu(), and Binder will only use this for a
small fraction of processes, so even if it changes which kmalloc bucket
it falls into, the extra memory is not a problem.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
[boqun: Use RcuFreeSafe]
Signed-off-by: Boqun Feng <boqun@kernel.org>
---
 rust/kernel/sync/poll.rs | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/sync/poll.rs b/rust/kernel/sync/poll.rs
index 5aa0ce9ba01b..830a4763a5c1 100644
--- a/rust/kernel/sync/poll.rs
+++ b/rust/kernel/sync/poll.rs
@@ -9,12 +9,19 @@
     fs::File,
     prelude::*,
     sync::{
-        rcu::synchronize_rcu,
+        rcu::{
+            synchronize_rcu, //
+            RcuFreeSafe,
+        },
         CondVar,
         LockClassKey, //
     }, //
 };
-use core::{marker::PhantomData, ops::Deref};
+
+use core::{
+    marker::PhantomData,
+    ops::Deref, //
+};
 
 /// Creates a [`PollCondVar`] initialiser with the given name and a newly-created lock class.
 #[macro_export]
@@ -70,6 +77,7 @@ pub fn register_wait(&self, file: &File, cv: &PollCondVar) {
 ///
 /// [`CondVar`]: crate::sync::CondVar
 #[pin_data(PinnedDrop)]
+#[repr(transparent)]
 pub struct PollCondVar {
     #[pin]
     inner: CondVar,
@@ -97,12 +105,20 @@ fn deref(&self) -> &CondVar {
 impl PinnedDrop for PollCondVar {
     #[inline]
     fn drop(self: Pin<&mut Self>) {
+        self.drop_before_gp();
+
+        // Wait for epoll items to be properly removed.
+        synchronize_rcu();
+    }
+}
+
+// SAFETY: __wake_up_pollfree() guarantees all the epoll items on the wait list will be gone after
+// one grace period.
+unsafe impl RcuFreeSafe for PollCondVar {
+    fn drop_before_gp(self: Pin<&mut Self>) {
         // Clear anything registered using `register_wait`.
         //
         // SAFETY: The pointer points at a valid `wait_queue_head`.
         unsafe { bindings::__wake_up_pollfree(self.inner.wait_queue_head.get()) };
-
-        // Wait for epoll items to be properly removed.
-        synchronize_rcu();
     }
 }
-- 
2.50.1 (Apple Git-155)

