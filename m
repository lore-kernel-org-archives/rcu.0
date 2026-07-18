Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C982F7AC1;
	Sat, 18 Jul 2026 05:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784352786; cv=none; b=eosuWWLhCBkHCa9Ta1FrNGmaIf/8I2RIfaQJrheNzBdxQ7sfHqwwFTAnGi5ymBlSs6vurKDxHpFqR+1ZlMnLSsKHZCFyMsjVpYAbee8/xe9yEjANWHaPO2dYla15ZjGIubv+vv/qlq+jhwbxYhQfTW6DPYJ2cYeuVXWNz/rQARs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784352786; c=relaxed/simple;
	bh=RropZ+T/dGINlBe84vu+qQwX7oVepWLhj2IWwnrpf9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M1cp/ECpSN8PPVuA2zH44gzu/oCoB76e14ONQxTgOW+BHoGe6GhnP18rmEmxAlnYnQUK+z86AbtV6JoHXha++72P2xFpZuAAlIB/Mt+f4HhGT5fFtEYlpVtth5JY2uM2GJN1Mnt018rrpX1WkGbVMZFPSy1HAZ9rB/X1uaCkry4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S74oZ+Kf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S74oZ+Kf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5221E1F00A3A;
	Sat, 18 Jul 2026 05:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784352782;
	bh=ANkivdWz9zJi28Ji5ZKsqedVfMZZkLTBuL3A5HXMgG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S74oZ+Kf+W9DaTE/adZxHs/zT3jTY86uvo9csra4zk1fxvcoz87SLmi1zDEP3fW6b
	 Rw/M7sccrpOA8NtpIc08mzE2JKpo/HJ4QhVOGiKUiqL7rZMilH6rjPXcZK2h72INHZ
	 eaByKrAaXmSI0JgJqSEX9epJnXZTLTMWo3l3sXweHIaVeqBOpc4mFqgP8nefQV9KgW
	 KQUhG8FlOnBNUuY9F94SLEDqTQEb6EfXuXpW0KDIhyvDL9fTwbeUKIMsoNCIcfo+rf
	 ZxjDumuq+1trxbnnafqMpPzyLbP7QQQGWmyQrw6BKmcrSta+myUC9UXGq18JeLPJD8
	 03/0Bnn2jrosg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 82E0EF40067;
	Sat, 18 Jul 2026 01:33:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sat, 18 Jul 2026 01:33:00 -0400
X-ME-Sender: <xms:DBBbaluAZj9Yce9pLoE_LRjk_efZ1hR0mJD57-VZlbSCvfRs98xrEw>
    <xme:DBBbaoRDKqLpgvAkfpASS3Hl7m8NGRgXO-X0TmUaa5faD8xpDGXO8am0uSYGE2Cwv
    lUsoU1kJT6uxcHP3JW6zqD6H4c3s3H0GXLxYYvVRBAYzCozcjyf>
X-ME-Received: <xmr:DBBbakNUGo6TBnGq-Jz__XgawBNtXDUcsktMkQ8bWySXZoCxhdj3bJT04zWxaLL6ZKjZfqm4110Mrh9ReRYWia2-YIwZpZAq>
X-ME-Proxy-Cause: dmFkZTEgEAJxx43zj+N2HexbcXxXpr8iZewHIC+wBoUe/3kHvIsxmf0uovnwyzmQf22fh5
    PbBpjLE4M1x+gkTl4x5OuQgzkddFgVOLc7SPm8OVC3wj6PmDWqpG/wyzm0HbMF//9RDtvM
    cqERhXH8fRAethPTEdiPCDM2biIjvo2duSrcDNiRwIZ4PJTMN9f05eRQvmRRsxcI1+ZGXR
    GIOp0pU8kR4mYsSetTdmMF1Q09Qod6lgNc4Vx07svlwAfyl7KUdd5xFGJoXDRG1kaoRL4T
    /VNW+87mn/mN1dMvhE363j1dLxUYIFMMuhRaBTcK4fjHHNruAjFs082R/vn5pb6pwik6pX
    3SHkN1ACEiezX0mrwyw4KfdbjmcRDjPvFlZoRAWQNQEQ3EJoP/wDviNR1nZpBknlDVOTAm
    5dYtVMhKPL3ejT4Z+9iLU6DN6wRmWI4z6RdrjcnbevPeUXCNjW/MmqIagNfqcNHcvysGxf
    F03b3aVMnfh3U5HgzIMSYBanXCwMagUxvz5GKBlhVYIyKFcLfT6NwEhyGaJIOzCGE3faVH
    ZMdtpcaeMbwqM2mvR0yLwIk6IcpchHNeCuWKsiYXXPQcx8PqDKoFg2G0cPq0x543bCm8PT
    Sy+F7A9BzGFg985bJyfOkZcS3quFI+ZuDrrtYiKBfrcVpYvLCLmguRzokYZg
X-ME-Proxy: <xmx:DBBbaomdYw0UP8bSn2z4A7a-fPqId_zJgcEK_zldJ82wUvOvBZK2FA>
    <xmx:DBBbag3vtZK8XLxuR5YjdXZaMEGlCeSWRNPdqdyiPKBTLjb-39cI0A>
    <xmx:DBBbagWKFUlLfjGzeHNJjBT0pQRehhxOAZtL6eftj7hiqgH3XNIqMQ>
    <xmx:DBBbariRFC90MNV7Sn3SPFwAQwKSRlzKlAhJocM2_wRKQWCwWCS5sA>
    <xmx:DBBbaph3FC4sAJH4m5OlNsrqFhY2jeoEyebt7FZ4puPMZDf0FucgM2an>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Jul 2026 01:32:59 -0400 (EDT)
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
Subject: [RFC PATCH v2 2/4] rust: maple_tree: Add load_rcu()
Date: Fri, 17 Jul 2026 22:32:45 -0700
Message-ID: <20260718053247.25154-3-boqun@kernel.org>
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
2.50.1 (Apple Git-155)

