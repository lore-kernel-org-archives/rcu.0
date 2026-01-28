Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3A02D7DF3
	for <rcu@vger.kernel.org>; Wed, 28 Jan 2026 23:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769644158; cv=none; b=Jgi13zo49WIc17i1PJLc1DDP5p1cQgXFTdPWtejs6aMNzOktPhZcXL3G6WtWjJTHSYmL7AhBHbh2W/VjpAwu89zP0cyDbhzwI9Fk6HS7Tz+7V/ptUnhjH7+tbHh95Ck6LUyd2DlblmIo1FhNM1vxOiB01bkneXicUkgnHhVVN1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769644158; c=relaxed/simple;
	bh=OUnhhLpw0G4jfOUrV0sIe5rYFeDBYm/rgYAQew5ALOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t7LYTX/Fy9+zRPnoz7E5KW4gTwPtwL1NqfC4A7YMqoEb68mJKjRjxhV7vRbZnY7HR3iw318zVUKXpLGg9zKfrpgv9qSmSkmDVNhzuYD3uJ52T7qZyR3LSBQ0cNEVwq2RQg8ZNVqLoxG4HrrJjmW1vAV2nJr9YcZPC9qbk5EBazk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7FECQRh; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7FECQRh"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so2977355ad.2
        for <rcu@vger.kernel.org>; Wed, 28 Jan 2026 15:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769644156; x=1770248956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZwleCKT0WC1y4r31KovKxSZY4leqC3/LnghDg5OFIfc=;
        b=N7FECQRh46bErJOXlAZZD2bnHBQFd0eW7WDUiR6Fg9RKG5wbL1HG09T1lKOSf0sPcF
         MOvF9KAUZoG0wX5F9YOanp9I1BPGoqIDPeCcBz1G8s53+96PycAZTFs4yGhKFm/WZ7yr
         lRZDnc1nDY6qIggViNJdxpB+l1GXN2FIyTOM4nB1Tx0NvGGV4XjymVIWjwIS7E99KtmM
         TTixKcro7JVnG0j4Zz1eTMh0fOhsbbMry4uBxnXMLDOtgdMTgSTvNZV8YZTDZIjZUJOy
         Mg4O80Mz3tyEQIsh+noDe1IQMhs3tksSVuoWMfxYHz9W2hEevWLu6kSaVI6oRkFsAef6
         4RfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769644156; x=1770248956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwleCKT0WC1y4r31KovKxSZY4leqC3/LnghDg5OFIfc=;
        b=OKT7kySQlIrX2TCacdKAUHlKQM8yqeZhBd4h3ZSDgtwrx0VHrVtL0NK8EoqNpj/zyb
         0Uy6chIYyS9LgLBkEluOOWFQgYYS9Lc+bAvYeD5HQRM4qWcw5nZUuVgdVUlRzYIHBhc8
         yUo2LvWcwh/werx66RBk+iWoYLQxNrTmcdEPbeGJcrbZYEfggGt+iou2HdlrzVaKcSRf
         Hk3nbVarPr12Ey6+qy3wjbcS/7eROfLoaBg0tHxPuT+TdT9H+xPRbRrdQsp0M9s7yYkR
         8LF8Vrgr1ZGL5x7Ac737MR4bmz1hgetxNnNUXbOVxWDmRyJSl9cY4GWAT8cee4+yTMwS
         vR+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWysLZwXnSDupPyGaJH8wsjNef6Jz0ii/giRi1h+byF5Q7DE99Wi4h2ob25Nn6i0pB3Luo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ1JQxwUzcNg+/A/5nIzNqx7pr4n54MBz2MPfI0kKs5GGPLwff
	odMwEECou2ghzg468VgDyAm6wdX6YhaDRPOsFiQO2mgKS4kYSb/esdbsoV8+Xw==
X-Gm-Gg: AZuq6aLqfpKu8i492nz9RTbtYvi6yfe+Wz29SqDJ4Mqpap5ZrAJRWbvnnZje6bJ1gov
	ZrCaxFxGbQgNiU8mNuyiki8QYw17ak63vEn6d6wGpHxF0xBGI16SslbS7FIlnWpMwiMpMLBtWbQ
	Gznj7/gEwOzsBbG7hSjWQ+x9dDSgjpRyUoEzncufAwfc8DFdGBAaO6CRpdvCAnwhanYtaRb0Z6B
	JhlShK2+iUImx0IS1AgP6z/98mSdRb/WQxjVYVkiUysPHSf5msIxBHjWSSGDyiexwgt7E02B9Pe
	3UW4dcclmw35MoVgWTRoFrGd4gK9Jl59vqFj8Uvp2GvCQtbR+/vV+HWZc7dXXYGsyacbjTkvL3Q
	EuPLUm77+dAz0wSmdm1oD3uzhRwrGB58YDi9IyNm0DC3UFGCM/b8O6BqLnRLRRI259fLAjXTij6
	tgmmYLzMaD14OhDsMN3jUaYIQSeN/7rdt9HlkqddTVQNgOpiAU070IwqQnSiWJn7BmfeWZWyfAj
	TFZOZgSgOl37BY=
X-Received: by 2002:ad4:5f0f:0:b0:888:3d1e:f95 with SMTP id 6a1803df08f44-894cc8c97dbmr102202586d6.32.1769637217348;
        Wed, 28 Jan 2026 13:53:37 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d373fe92sm25727956d6.32.2026.01.28.13.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 13:53:37 -0800 (PST)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 28E16F4006C;
	Wed, 28 Jan 2026 16:53:36 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 28 Jan 2026 16:53:36 -0500
X-ME-Sender: <xms:YIV6aaFIVqu1vzme2VW38MSlOBHLiWRQSF2V-SxUhc3r0IpLwI384A>
    <xme:YIV6aQwoAtzlJQ97cyCGHjaHsUHLIshlyuDQAsgvGa4_xaJAGJrbLp7ol10P2h2n2
    KRcJOewPjkHj7OBTEqqOPjBSe-7JG8oGRCw73AHQcYhO4F9E-AYvg>
X-ME-Received: <xmr:YIV6aY70_MKwCKmidquhUATwoM2PDGliV-3HHvE-nK3U1-DDGddTZRIj9XQj4Wm-lQ6NIehIQf7meG_WZ-_jsIbVQa-bVHC0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeggeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueehgeeg
    gfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
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
X-ME-Proxy: <xmx:YIV6aVAdxyRI7i9c75UP1OKe2Bv8wm04aNI1gBnt75x3dzu1jwBuqA>
    <xmx:YIV6ad0Bi4W7IBwGOHhDjdvikuuIKESqCxIDuYSKttGvHo5Gr__1ow>
    <xmx:YIV6aYFJK2BsysJTkEA1w5-cd_XOkGa5sdtjL_AX74OFQoIQ9LsjUA>
    <xmx:YIV6aehmFEta2df7Jvcc7N6UslnRiAKLz-OqBem8zcQcA_7lilXCtQ>
    <xmx:YIV6aauOB-9wVOKHl12R-2qAcnd3syYeCTCudza0yHA3zUH-pRv8Hcef>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jan 2026 16:53:35 -0500 (EST)
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
Subject: [RFC PATCH 2/7] rust: time: hrtimer: Make `HasField` a super-trait of `HasHrTimer`
Date: Wed, 28 Jan 2026 13:53:25 -0800
Message-ID: <20260128215330.58410-3-boqun.feng@gmail.com>
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

This decouples the hrtimer mode part from the `HasField` part of a
`HasHrTimer`, `impl_has_hr_timer` also gets removed, as we can do:

    #[has_field]
    #[pin]
    struct MyStruct {
        a: i32,
	#[field]
	timer: HrTimer<MyStruct>,
    }

    impl HasHrTimer<MyStruct> for MyStruct {
    	type TimerMode = ...;
    }

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/time/hrtimer.rs | 70 ++++++++-----------------------------
 1 file changed, 15 insertions(+), 55 deletions(-)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 856d2d929a00..eef6d60f5adb 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -98,6 +98,8 @@ unsafe impl<T> Send for HrTimer<T> {}
 // on a timer from multiple threads.
 unsafe impl<T> Sync for HrTimer<T> {}
 
+impl<T> Field<T> for HrTimer<T> {}
+
 impl<T> HrTimer<T> {
     /// Return an initializer for a new timer instance.
     pub fn new() -> impl PinInit<Self>
@@ -417,17 +419,7 @@ pub unsafe trait HrTimerHandle {
 }
 
 /// Implemented by structs that contain timer nodes.
-///
-/// Clients of the timer API would usually safely implement this trait by using
-/// the [`crate::impl_has_hr_timer`] macro.
-///
-/// # Safety
-///
-/// Implementers of this trait must ensure that the implementer has a
-/// [`HrTimer`] field and that all trait methods are implemented according to
-/// their documentation. All the methods of this trait must operate on the same
-/// field.
-pub unsafe trait HasHrTimer<T> {
+pub trait HasHrTimer<T>: HasField<T, HrTimer<T>> {
     /// The operational mode associated with this timer.
     ///
     /// This defines how the expiration value is interpreted.
@@ -441,7 +433,11 @@ pub unsafe trait HasHrTimer<T> {
     /// # Safety
     ///
     /// `this` must be a valid pointer.
-    unsafe fn raw_get_timer(this: *const Self) -> *const HrTimer<T>;
+    #[inline]
+    unsafe fn raw_get_timer(this: *const Self) -> *const HrTimer<T> {
+        // SAFETY: Per function safety requirement, `this` is a valid pointer.
+        unsafe { <Self as HasField<_, _>>::raw_get_field(this.cast_mut()) }.cast_const()
+    }
 
     /// Return a pointer to the struct that is containing the [`HrTimer`] pointed
     /// to by `ptr`.
@@ -452,9 +448,15 @@ pub unsafe trait HasHrTimer<T> {
     /// # Safety
     ///
     /// `ptr` must point to a [`HrTimer<T>`] field in a struct of type `Self`.
+    #[inline]
     unsafe fn timer_container_of(ptr: *mut HrTimer<T>) -> *mut Self
     where
-        Self: Sized;
+        Self: Sized,
+    {
+        // SAFETY: Per function safety requirement, `ptr` is a valid pointer and points to a
+        // `HrTimer` field in a struct.
+        unsafe { <Self as HasField<_, _>>::field_container_of(ptr) }
+    }
 
     /// Get pointer to the contained `bindings::hrtimer` struct.
     ///
@@ -731,48 +733,6 @@ pub fn forward_now(&mut self, duration: Delta) -> u64 {
     }
 }
 
-/// Use to implement the [`HasHrTimer<T>`] trait.
-///
-/// See [`module`] documentation for an example.
-///
-/// [`module`]: crate::time::hrtimer
-#[macro_export]
-macro_rules! impl_has_hr_timer {
-    (
-        impl$({$($generics:tt)*})?
-            HasHrTimer<$timer_type:ty>
-            for $self:ty
-        {
-            mode : $mode:ty,
-            field : self.$field:ident $(,)?
-        }
-        $($rest:tt)*
-    ) => {
-        // SAFETY: This implementation of `raw_get_timer` only compiles if the
-        // field has the right type.
-        unsafe impl$(<$($generics)*>)? $crate::time::hrtimer::HasHrTimer<$timer_type> for $self {
-            type TimerMode = $mode;
-
-            #[inline]
-            unsafe fn raw_get_timer(
-                this: *const Self,
-            ) -> *const $crate::time::hrtimer::HrTimer<$timer_type> {
-                // SAFETY: The caller promises that the pointer is not dangling.
-                unsafe { ::core::ptr::addr_of!((*this).$field) }
-            }
-
-            #[inline]
-            unsafe fn timer_container_of(
-                ptr: *mut $crate::time::hrtimer::HrTimer<$timer_type>,
-            ) -> *mut Self {
-                // SAFETY: As per the safety requirement of this function, `ptr`
-                // is pointing inside a `$timer_type`.
-                unsafe { ::kernel::container_of!(ptr, $timer_type, $field) }
-            }
-        }
-    }
-}
-
 mod arc;
 pub use arc::ArcHrTimerHandle;
 mod pin;
-- 
2.50.1 (Apple Git-155)

