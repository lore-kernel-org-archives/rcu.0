Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EF640F73C;
	Wed, 22 Jul 2026 14:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784731852; cv=none; b=Rsb+gBszuemI+oxnZ0+kF8kLoTzjvIpcdRu+4c96gB8XElHcqJDZEIS0VmHALv0AihtKXvusDll9fR5U+yoHOUym+6cwh+CKX9Ij8i/392PrPmG/V3ytbALm1gmJM4S82gBNgFy88IZVtAt1Kdfg8heivPGm4nXKCeBxqMIfzfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784731852; c=relaxed/simple;
	bh=qqCRQvhVH42yNHmiFbVEtFeDDBt7lPvhjqlxqtQQK+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XucpdaHWgF9i1lF+4J60GBybpL4KhitoaL4PyDDytN6LpI9l0AMSSOkRomlmzCKDVDwiCvkxvLg8QJ9YRIiqEIzgXcifMPIJ7uO79BI0e7SCxffJ5CjwJvmL5nYsniIoUU2k+Y/8rHYF41zDBuzRbN36+49n4ztHMMwS8RKOmXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xvgdbxnb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xvgdbxnb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E20E1F000E9;
	Wed, 22 Jul 2026 14:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784731851;
	bh=fb3KwzqW2X+XJDIN9Q4LM2WNavmSoabSD1bIH2UFAQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XvgdbxnbthVpPVWwYzLXKcoKXAB2cU0AuqZ0xF6VD+EDUspJ9nXxYMdxdrJgv4i4H
	 qRODWJQ+wBL7D71ZvpvbzRGFBAtdBpW5UWdgVSFWHMyQbGBe3xFVB36kgaRUASABKo
	 wetA0iX35N0v6G+oqeV7oiuyLJOuHrdarSR+YQC6zbnNU2ktvYcM38LSDieJKBYt2e
	 FbJb34si8Jtjk8eZffouDqe7USTWvTfL3I4go5VNqb9wq4oYzgfcdJBMNrm+39y7WE
	 W+DMV3d7TJEhVGNBWCXsQ0EPT0WjOFnej+64PSrMxCWSdwWzxaTt1oA+DnWJWzqDQL
	 Va5MYNekDdw6w==
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
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>,
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Asahi Lina <lina+kernel@asahilina.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Eliot Courtney <ecourtney@nvidia.com>,
	Mirko Adzic <adzicmirko97@gmail.com>,
	Daniel del Castillo <delcastillodelarosadaniel@gmail.com>,
	Alistair Francis <alistair.francis@wdc.com>
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	rcu@vger.kernel.org
Subject: [PATCH v6 4/6] rust: xarray: Add support for index reservations
Date: Wed, 22 Jul 2026 16:49:28 +0200
Message-ID: <20260722144931.1070312-6-phasta@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722144931.1070312-2-phasta@kernel.org>
References: <20260722144931.1070312-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One often cannot allocate in the kernel with the desired flags, most
notably in atomic context. Pre-allocating the memory is the preferred
solution in such situations.

Add support for xa_reserve() in the Rust abstractions of xarray. Create
a Reservation object similar to a lock-guard, that can be dropped once
the reservation is no longer needed or once the index was stored to.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
Please regard this more as an RFC.

I need pre-allocating in XArray for DmaFence. How exactly we achieve
this is open for discussion.


P.
---
 rust/helpers/xarray.c | 10 ++++++++++
 rust/kernel/xarray.rs | 45 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/rust/helpers/xarray.c b/rust/helpers/xarray.c
index 08979b304341..1504ab242949 100644
--- a/rust/helpers/xarray.c
+++ b/rust/helpers/xarray.c
@@ -26,3 +26,13 @@ __rust_helper void rust_helper_xa_unlock(struct xarray *xa)
 {
 	return xa_unlock(xa);
 }
+
+__rust_helper int rust_helper_xa_reserve(struct xarray *xa, unsigned long index, gfp_t flags)
+{
+	return xa_reserve(xa, index, flags);
+}
+
+__rust_helper void rust_helper_xa_release(struct xarray *xa, unsigned long index)
+{
+	xa_release(xa, index);
+}
diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
index 987c9c0c2198..fa5d47935f0a 100644
--- a/rust/kernel/xarray.rs
+++ b/rust/kernel/xarray.rs
@@ -8,7 +8,10 @@
     alloc,
     bindings,
     build_assert::build_assert,
-    error::{Error, Result},
+    error::{
+        Error,
+        Result, //
+    },
     ffi::c_void,
     types::{
         ForeignOwnable,
@@ -147,6 +150,46 @@ pub fn lock(&self) -> Guard<'_, T> {
             _not_send: NotThreadSafe,
         }
     }
+
+    /// Reserve memory in the XArray at the appropriate index. If this call
+    /// succeeds, later storing at the index will not require an allocation.
+    ///
+    /// Loading from reserved entries will return `None`.
+    pub fn reserve(&self, index: usize, gfp: alloc::Flags) -> Result<Reservation<'_, T>> {
+        // SAFETY:
+        // - `self.xa.xa` is always valid by the type invariant.
+        // - The caller holds the lock.
+        //
+        // INVARIANT: `new` came from `T::into_foreign`.
+        let ret = unsafe { bindings::xa_reserve(self.xa.get(), index, gfp.as_raw()) };
+        match ret {
+            0 => Ok(Reservation { xa: self, index }),
+            _ => Err(Error::from_errno(ret)),
+        }
+    }
+}
+
+/// An index reservation object.
+///
+/// As long as you keep this object alive, your reservation will stay valid. If
+/// someone has stored to this index in the meantime, dropping your reservation
+/// does nothing, which is why you can always drop this reservation object once
+/// you performed your store operation.
+///
+/// Refer to the main C xarray documentation for more details.
+pub struct Reservation<'a, T: ForeignOwnable> {
+    xa: &'a XArray<T>,
+    index: usize,
+}
+
+impl<T: ForeignOwnable> Drop for Reservation<'_, T> {
+    fn drop(&mut self) {
+        // SAFETY:
+        // - `self.xa` is always valid by the type invariant.
+        // - If `self.id` is not used or has been stored to by a racing party,
+        //   `xa_release()` will do nothing.
+        unsafe { bindings::xa_release(self.xa.xa.get(), self.index) };
+    }
 }
 
 /// A lock guard.
-- 
2.55.0

