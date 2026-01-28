Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A7C299923
	for <rcu@vger.kernel.org>; Wed, 28 Jan 2026 23:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769643958; cv=none; b=hCTmu55prK7xXEGRBQ2RhVsZETgHldsu1i4mFykGopyorBi3uom7FSz30JLZ4EdMk3du51DcpECeP6VAd/5NSwKTOT2mQxxhJBYBRWqSGI39CndIP47vRSFuiFdW3/w7cBch1D5k8pIuV4wp8Lc0YqWz5IyOkDK9uRvuoHa00Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769643958; c=relaxed/simple;
	bh=OWcfZiYWS0H6ctpWcE+xkPHvQjej9ptDYntcK8zIjcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdbejGKrsqRiDIp110dbWClrJ0w83gzcW7MP0YUKIWFY42uIgnamSFpKHXF8PF2iu8/ryy1lI6CI5NexDPDF6CwIdu0FBHlyBespVYan6FklHJUqHoG6Oco8xeP9wKdleoHMw9gcVCuTTXFzBLncAUtReCmEmqVGIew+Hvu0nGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMaf0urK; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMaf0urK"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-662f485e58aso222613eaf.0
        for <rcu@vger.kernel.org>; Wed, 28 Jan 2026 15:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769643956; x=1770248756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HK2cJpoHs1cW08tNlDAhBYjQE8db82PEiBJhgotTdb4=;
        b=gMaf0urKj94ZtsTL27O25S1X8ra2yP5iYeLz842/2StxmildJimwwrUoGlT47/2FwA
         hM5rj6MfkqAQAimsrRKyOQ//5Mded9WdAsBK1AtxhjXYbjrGXFh1JHpE3aoCFhLabQGx
         aV09auAckWeEVNUmvIn8vOrFow1KIi3MUnuYUDHH1yZmbN+6gKcEJpm57TtbH4ExBklU
         XXITQutJLTtWmfNtiGHctn9oKVFvn1mEkKPTVrQ++hmTiVrAsTXYHz0NZ76DF/4ac0uQ
         ZlA89N2zBSi5MZdxqtLD82YOlJnUCS132tJLh6X9bTlkIF971YBHG5GJaam6zHvkR3+Q
         MzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769643956; x=1770248756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HK2cJpoHs1cW08tNlDAhBYjQE8db82PEiBJhgotTdb4=;
        b=oix5b9QIs0a04dMzt6IrBstUOTll9ivp89mT3h4GXA7uFNzv3kAQgL3DUV/XCH46fT
         OeXh4cZSwujJ022Z8v/HUcCtF88RgjUV6+oMfc8MXOe45KrparFl0gSNX2hdAzXuamsR
         ScnAakQGnadZrP8g5m+nxTiIRF439xa8iyGc3o9C5KLW+gBLM9nEj2Ba5PLHKoDByd99
         ERTcp5tdeScEiOvZDlTgYDscD0bE6VG6M7EWzar0xrs5rkKnMM+3/JV7OFu+GPV/M0I9
         6lkfXQJbMIr7Wxq881OyhHx8OwBBOTPIgsjSaN56rpCaXLvlg2zuhTBi4PUSFqWJXcFY
         WkuA==
X-Forwarded-Encrypted: i=1; AJvYcCVdHwnMVXXaIDwSP7a1+KiOpgWWPp0DTmL/znKR28a2LPDHi1iDgvMouQ1bePe3XNgPJr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YziXMA0VWzxaglz+T2RPss3TYooEclCzQ49m/HZQ6Efu6QvzeXh
	kx+CZN/no+0dgJWm54jr7RRULkBNdIQyfQoq2Q8K8pqqwvs50FhzbS+vwqq13g==
X-Gm-Gg: AZuq6aJ/FeMHfRgC5casKq9nmZDrvBBjmKvVqNWV06hXafyfDk6eT6OFIui0Q+58kn/
	ZmMceksYckbn/ECbzAj0fQfNu1SnjIal42A5x5CEmte233Y/p59C7JfXoDVTqn4S/pjZDHkBfQQ
	Jt//vHphVpJjYhkR2Q5+DWdAkSUi5cXjYk+CNxilJzkG37p9b7X9AyIs5gTniIHxlTb2L96rOkW
	4x4zvqOCBEMHDLpQrf2Cwo2d4Qov7raMI1jKJuQ/klS1zJG6CptU4dv/vz6pzKtxDwawruDD4lX
	BwMNiPj5uMhA/bECkQFntSr0tACHt97VIjUZW09qrjZwbV7MbFTYhE+xVeIRgLmNSvW9/CNSlRN
	Ie8X7FPxpsrYGssjbZGdLdtsDG2ipThLqQv09WaMoclMiBfXrO9hab8RbrVXu4D7yH+uhf6c1Ko
	n1BFtdO7mAfC0rvjbJTe7JsnaF2HR7xf3/aLZDqD3dxCzl2QpSfokaK/wsjSE9RvAJJ5ixr67p6
	sQgO7uy7hcwIoQ=
X-Received: by 2002:a05:620a:4447:b0:8c7:13b8:8b55 with SMTP id af79cd13be357-8c713b8905cmr517714785a.46.1769637223840;
        Wed, 28 Jan 2026 13:53:43 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c713580985sm237855085a.8.2026.01.28.13.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 13:53:43 -0800 (PST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7918BF4006C;
	Wed, 28 Jan 2026 16:53:42 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 28 Jan 2026 16:53:42 -0500
X-ME-Sender: <xms:ZoV6aeFVYNlY6JZOeUsAI2HEcEDhbH7enQkHWg-TSjlEBT8Ol0bgXg>
    <xme:ZoV6aUxMMTUp9w1Thy-VOM9WqW0cE4EOqvpvF93TkVJFiA76zlA9Dp5I9JXqxwe_U
    hVwHlgatWJvP7cN-I9wme8VivxHvF4wo_CVMQN9iKy8OTQ3wOajHkY>
X-ME-Received: <xmr:ZoV6ac7joAFn2VhRmwc6qXOrYh1IjW0Vy2OkUJ8b4Dc6YaZPYjFn58XB6w4kh0Isb563K3D8VxLzbgcTaUX9iJrKt4GZWZL_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeggeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueehgeeg
    gfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepgedvpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohep
    rghrvhgvsegrnhgurhhoihgurdgtohhmpdhrtghpthhtohepthhkjhhoshesrghnughroh
    hiugdrtghomhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegtmhhllhgrmhgrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprghlih
    gtvghrhihhlhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:ZoV6aZB7hyhCwc1ejSFD8OKjnpoYoi1MBQu3CrjP9P_z56Nk4yOMLA>
    <xmx:ZoV6aR2jIFafD6KfaKotGIGwjiFlkrJPM-qaTv3VAogHX2QZPsjiwA>
    <xmx:ZoV6acFxwMU4l_0otaO7K8jn8XfZAR3W6IO6WjQ_JbPZ-4WlCsfTKg>
    <xmx:ZoV6aSgKwChdCbDLYtURt_RpUDJL1NpmsHz4MUs4kx2Mzd6W0BSgcA>
    <xmx:ZoV6aeuQx4Qdu4ZQsrOISY_tsoAGO88IyVyB1kOZGz7E53ymMh760lBj>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jan 2026 16:53:41 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,	Danilo Krummrich <dakr@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,	Zqiang <qiang.zhang@linux.dev>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Lyude Paul <lyude@redhat.com>,	Thomas Gleixner <tglx@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,	Stephen Boyd <sboyd@kernel.org>,
	"Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Vitaly Wool <vitaly.wool@konsulko.se>,
	Tamir Duberstein <tamird@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Mitchell Levy <levymitchell0@gmail.com>,	David Gow <davidgow@google.com>,
	Peter Novak <seimun018r@gmail.com>,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [RFC PATCH 6/7] rust: work: Remove `impl_has_work!`
Date: Wed, 28 Jan 2026 13:53:29 -0800
Message-ID: <20260128215330.58410-7-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260128215330.58410-1-boqun.feng@gmail.com>
References: <20260128215330.58410-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now all in-tree users of `impl_has_work!()` are converted to use
`#[derive(HasField)]`, hence remove it.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/workqueue.rs | 53 ++--------------------------------------
 1 file changed, 2 insertions(+), 51 deletions(-)

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 2dcfd3eace39..37fbf348c760 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -578,55 +578,6 @@ pub unsafe trait HasWork<T, const ID: u64 = 0> {
     unsafe fn work_container_of(ptr: *mut Work<T, ID>) -> *mut Self;
 }
 
-/// Used to safely implement the [`HasWork<T, ID>`] trait.
-///
-/// # Examples
-///
-/// ```
-/// use kernel::sync::Arc;
-/// use kernel::workqueue::{self, impl_has_work, Work};
-///
-/// struct MyStruct<'a, T, const N: usize> {
-///     work_field: Work<MyStruct<'a, T, N>, 17>,
-///     f: fn(&'a [T; N]),
-/// }
-///
-/// impl_has_work! {
-///     impl{'a, T, const N: usize} HasWork<MyStruct<'a, T, N>, 17>
-///     for MyStruct<'a, T, N> { self.work_field }
-/// }
-/// ```
-#[macro_export]
-macro_rules! impl_has_work {
-    ($(impl$({$($generics:tt)*})?
-       HasWork<$work_type:ty $(, $id:tt)?>
-       for $self:ty
-       { self.$field:ident }
-    )*) => {$(
-        // SAFETY: The implementation of `raw_get_work` only compiles if the field has the right
-        // type.
-        unsafe impl$(<$($generics)+>)? $crate::workqueue::HasWork<$work_type $(, $id)?> for $self {
-            #[inline]
-            unsafe fn raw_get_work(ptr: *mut Self) -> *mut $crate::workqueue::Work<$work_type $(, $id)?> {
-                // SAFETY: The caller promises that the pointer is not dangling.
-                unsafe {
-                    ::core::ptr::addr_of_mut!((*ptr).$field)
-                }
-            }
-
-            #[inline]
-            unsafe fn work_container_of(
-                ptr: *mut $crate::workqueue::Work<$work_type $(, $id)?>,
-            ) -> *mut Self {
-                // SAFETY: The caller promises that the pointer points at a field of the right type
-                // in the right kind of struct.
-                unsafe { $crate::container_of!(ptr, Self, $field) }
-            }
-        }
-    )*};
-}
-pub use impl_has_work;
-
 impl<T, const ID: u64> Field<T> for Work<T, ID> {}
 
 /// SAFETY: Per the safety requirement of `HasField`, `raw_get_field()` and `field_container_of()`
@@ -746,8 +697,8 @@ pub unsafe trait HasDelayedWork<T, const ID: u64 = 0>: HasWork<T, ID> {}
 
 /// Used to safely implement the [`HasDelayedWork<T, ID>`] trait.
 ///
-/// This macro also implements the [`HasWork`] trait, so you do not need to use [`impl_has_work!`]
-/// when using this macro.
+/// This macro also implements the [`HasWork`] trait, so you do not need to use `#[has_field]` when
+/// using this macro.
 ///
 /// # Examples
 ///
-- 
2.50.1 (Apple Git-155)

