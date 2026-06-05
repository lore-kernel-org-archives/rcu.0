Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ED130F803
	for <rcu@vger.kernel.org>; Fri,  5 Jun 2026 13:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780666558; cv=none; b=nLyWeA7sOdy5+M0fWImm3ZiRF0PTNnPjRWIl0AKvs8stiiguwBb85cKaCDP6iK+dAsEhZGdxtqxBdAyelQb0hLdO/9fKA6d63AdlTMylXOYxWfIo9bD938Y4o3P9bL8iVyoiA2h8MKu2/KCetqN9ak1/c1b/EjC9Yz/b7UJB3yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780666558; c=relaxed/simple;
	bh=7oEWBugMDCTnwu6G8nNrOIl6WlQQUXQtkAdp3xI/oZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqp5Tf4OKIS3sOR/iYZIVa33iv2wVlfNB4+kYd8mzua4zuzKjepwoc6o/zECZ0IvJp+xXB1CAP5UncWiXYbdye0mMaok+w9WhkAvBTnzjcNIhq1VtRIUPjX9mZ0h3j4+de0azYOD85J0Z26+Fz8zERGaT6t19fYsflVJQyRTjFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M22+aP1y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M22+aP1y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C931F0089A;
	Fri,  5 Jun 2026 13:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780666554;
	bh=EWiBixMYQYNU31zDIl5csE1S/wX47DtIBhxQyh/JIig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M22+aP1y/jBD8OI5tHbQb+G2ZmQLForEPqc8/xH8JjcqEWhSYdBqcMX2eUNgcolDK
	 BX4eT/N0oL5sRuy/Dy6y6tFs3iAecWaSVA6KV3bqGQ5/GAnvhE0E9YB/gKqBEYzVNp
	 DXmLrBoFP9j1tbG62n+D3s1xn0si+3SYaeo6lZ1vKj8d9t+4/vgXkROalELTyawkwE
	 NPd3R/54fWQefHdGc7tdjntLAHK5X4dOrA6+K0qyn9+hIImneB7hsn2IAEFAwY4WMv
	 0Hk6TeWkWRrzuqd0gU/H9LF6I2z9w1YWL6thZnUdvP/8dLMFYTmQxK4m8mqjAyWB2v
	 7EEPwryQ/5Gaw==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id B4019F4006F;
	Fri,  5 Jun 2026 09:35:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 05 Jun 2026 09:35:52 -0400
X-ME-Sender: <xms:uNAiaphYCKN32jPvpIchw2Jkxc3dmAHJwtUyupNl17vsDGLMn1SbJg>
    <xme:uNAiaqfJ1UkBQ4tu_y9utnZsZ0X7rVXMboUAYM7eWQChFBLp3YNRk9BdNhBpFMYlT
    J7CKrxZFUL9bSurDVlY0izjx8I0PgvlcqL5aUd3gd1GvfKesP3IMQ>
X-ME-Received: <xmr:uNAiagUxBUZ2gwSGY6Fu0Vunpr8gX1Kkyjb8bGfvhNda02ZFRPLXTqjDDL4>
X-ME-Proxy-Cause: dmFkZTEiXmK80I+r4b+5zY/r99GUAlO/A1JeBVvrzdPJND7AxnXROcGIdrV5+IW/GIICbk
    HTeSUzo2jG7T3ubuXDYawvMsJmw7SeRzXaVjmYhKpesaWDi/jHlBwDSw7cUJtOL4Zml+HR
    MdH91GjghnCvkbpZdNzjjo1bSZDmeAE+i20ut4ugSeq7SenIcQ9DZOfghRt4xUUc5uh5PM
    SgAN181ZxF1oco7PoJ9ho3wb1kPOXsEzQT5UZv0CFFx1JIqpGEiANmmsdwoALURinC3es0
    +e8I9nc2247wfagtNBtbgyVV8BvBRc03DGsTzzDlNTrxNmxxQ9+IH7k1Xg1Flh6mzaY9ZF
    D5JI/kUrl5038ewH2/yRBGMWygreujWb7iMUHrlowYIRmldbRWWDCC9SW9qFe9HhzwOP5R
    ANLHL8xhWBwyW6Z4xw3ZMLR+S85zuSDhz5Ie5yDVfNvn81u9jPFArGesQGDKJbpUGEj4Xn
    2dwkkQHzSA3mlt/Y/sVSUjgZi0drAp7nl7QMcSQqMTIa7ue0D4oe8kxDOnuOJ+sVzxQuul
    cf4anHpwCUK2rfRE87LFm+P0SY/bv3hsIRCFwuYbxFAx+MvwufNYnz9hkdJg9SKg8oEnyD
    /YwRPqQACwTSX771arNNzrzPgtmXD21/gBVN4f/8UHX/Rt7jIkyJ5iaDOeog
X-ME-Proxy: <xmx:uNAiakx5Mb6WpDDOKWMDRDBK1G8aZ4QY_bU0VjAA-K012rBHWTRefw>
    <xmx:uNAianBS_nsHWhWuYwchXoxscoFdnkTU0n7p2FIbjXqGjIPRDKD5Hw>
    <xmx:uNAiaq6wGb9_Mf26xE3PfnRIsXi-84ef7CZqeTU4rAY5F2TgaDUogg>
    <xmx:uNAiaumC9gtw67P6Wvpl8pNT_lVW9W7U25yKEnaAOJM95rRWSaKkkA>
    <xmx:uNAiateVKfCCEVgB4cunLqUXmgKg6AGUR6AkkYciuU4DCI2gNdZ6eBLQ>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 09:35:52 -0400 (EDT)
From: Boqun Feng <boqun@kernel.org>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Andrew Ballance <andrewjballance@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
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
	maple-tree@lists.infradead.org,	linux-mm@kvack.org,
	linux-media@vger.kernel.org,	dri-devel@lists.freedesktop.org,
	Philipp Stanner <phasta@kernel.org>,	Lyude Paul <lyude@redhat.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH 2/3] rust: maple_tree: add load_rcu()
Date: Fri,  5 Jun 2026 06:35:39 -0700
Message-ID: <20260605133541.22569-4-boqun@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260605133541.22569-1-boqun@kernel.org>
References: <20260605133541.22569-1-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alice Ryhl <aliceryhl@google.com>

Now that we have a concept of rcu-safe containers, we may add a
load_rcu() method to MapleTree that does not take the spinlock.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/maple_tree.rs | 52 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/rust/kernel/maple_tree.rs b/rust/kernel/maple_tree.rs
index 265d6396a78a..1499191b8935 100644
--- a/rust/kernel/maple_tree.rs
+++ b/rust/kernel/maple_tree.rs
@@ -16,6 +16,10 @@
     alloc::Flags,
     error::to_result,
     prelude::*,
+    sync::rcu::{
+        self,
+        ForeignOwnableRcu, //
+    },
     types::{ForeignOwnable, Opaque},
 };
 
@@ -233,6 +237,54 @@ pub fn erase(&self, index: usize) -> Option<T> {
         unsafe { T::try_from_foreign(ret) }
     }
 
+    /// Load the value at the given index with rcu.
+    ///
+    /// # Examples
+    ///
+    /// Read the value under an rcu read lock. Even if the value is removed, it remains accessible
+    /// for one rcu grace period.
+    ///
+    /// ```ignore
+    /// use kernel::{
+    ///     maple_tree::MapleTree,
+    ///     sync::rcu::{self, RcuBox},
+    /// };
+    ///
+    /// let tree = KBox::pin_init(MapleTree::<RcuBox<i32>>::new(), GFP_KERNEL)?;
+    ///
+    /// let ten = RcuBox::new(10, GFP_KERNEL)?;
+    /// tree.insert(100, ten, GFP_KERNEL)?;
+    ///
+    /// let rcu_read_lock = rcu::Guard::new();
+    /// let ten = tree.load_rcu(100, &rcu_read_lock);
+    /// assert_eq!(ten, Some(&10));
+    ///
+    /// // Even if the value gets removed, we may continue to access it for one rcu grace period.
+    /// tree.erase(100);
+    /// assert_eq!(ten, Some(&10));
+    /// # Ok::<_, Error>(())
+    /// ```
+    #[inline]
+    pub fn load_rcu<'rcu>(
+        &self,
+        index: usize,
+        _rcu: &'rcu rcu::Guard,
+    ) -> Option<T::RcuBorrowed<'rcu>>
+    where
+        T: ForeignOwnableRcu,
+    {
+        // SAFETY: `self.tree` contains a valid maple tree.
+        let ret = unsafe { bindings::mtree_load(self.tree.get(), index) };
+        if ret.is_null() {
+            return None;
+        }
+
+        // SAFETY: If the pointer is not null, then it references a valid instance of `T`. It is
+        // safe to borrow the instance for 'rcu because the signature of this function enforces that
+        // the borrow does not outlive an rcu grace period.
+        Some(unsafe { T::rcu_borrow(ret) })
+    }
+
     /// Lock the internal spinlock.
     #[inline]
     pub fn lock(&self) -> MapleGuard<'_, T> {
-- 
2.51.0

