Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDF62D7DF3
	for <rcu@vger.kernel.org>; Wed, 28 Jan 2026 23:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769644123; cv=none; b=YoYtK8Mc8UZZsnJGivSIS445ponTucvh9+DOGewpA/k7GAkPgXzEUGJRBOR7g7zaUIjCXQy+i4irLxMkRxviz4WMYVCvrM9yK2i5O4OFLZ+9gsE12IRsROdaMiHpDyAux5GaxIJX+PnG+mgfnruJscMaE37uVLQ3Vos2wOZ/EUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769644123; c=relaxed/simple;
	bh=/hRPwTjZmIfPfF6SXM76s/bDbQMZnDCoJvb+xB1fsC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VKVV2l6w8xAyzUPYAONO2oSyQE3y81KDdlU/ncf5myMcuoMvcfd8jS2TMGb40C7w2N5A/58dUWLSqH0Q4UD/GFTMVv4LN4gGbpJW+IUTxwbTk+QXUvF52sRjB/OCSsM7nJKMbaZ6cN/xujeHTe/5v/JcLqKa9EqDF0CXCNcD2d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayN14l9o; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayN14l9o"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-662f482180aso236591eaf.2
        for <rcu@vger.kernel.org>; Wed, 28 Jan 2026 15:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769644121; x=1770248921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NNS0YAOwbVOFsEM5UfR8k15PlxPXeRQf3X2TS9uzn6I=;
        b=ayN14l9ox/5rmjUsFxZ6wpxj9LndJxMuHkWud27/T19xCwuvSNA4Kr4TFNw9+Q7uD8
         9qllfu1Cx4aiS2/3ii7poBOkibq4vJdEXbWOKRVULgei8rh78AlnvoXBJqUxBwL83zgY
         LxwE7TG+tVSkp8PTg6pl+Ci5p87ywH7B+0bxvg3JY0g1LyA08sXM3zkHk3AdXjM4AjO5
         D/Kwpg3Ntwb5Hr2IkiJFA6V12a58PFh197eaGoUCjh+4pFp1mWkKQkOR0BnIK6x3ctCg
         9X7szBjUBTy88xGGWr46b+Cr+cGvHOM4G5sMhjLW9KZNODCkmqixaIdEFhycSIvBWYed
         Wuaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769644121; x=1770248921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NNS0YAOwbVOFsEM5UfR8k15PlxPXeRQf3X2TS9uzn6I=;
        b=lrAmpPSBTGhaG+mkC1N1D4VWZwNcisrBLXjkrSW0g00HN/GjKPOYSQq7kij4PMm6mi
         LTq5yAUr4OY9v08L7FLxMcl0zh59iVRb5tUbTYdYWRNb1EGSw74z4eaxf00Z7elgxOey
         /uU1S1ck82P+Npp9DhugGyg88VOVVrz3JNrNmKG4k2U0lr1LgrdN6S4K2vbvcI66Z0Hl
         6gB+kPP2MyRmEB5/XcvsQ4ithZQxmlPslgaOETg043I6tVX/YyEhj4U0gD018EE+axMF
         AD0w453hJ1SRuBq/n6HdmZENBkKdkRqjNnstHSGCWaWAdyjbEe8RFUQUgjxlvuHEvyJK
         DnGA==
X-Forwarded-Encrypted: i=1; AJvYcCWuo8dIv31Dpls5QrqOJvya60FejVAT9TZwrXjAO/mpVrCNm5TJ2id4oHem96gFGxkM0CQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaTz8QLPL/o2xjd3qLrueG3Tq/TRY/dvh/yBCPHv4+OU6KysQw
	Ag9jlsJYebORQjs+iTqFfFYUTUJnwcH+YZqg0NF18903cNcxruHUIfSS359K8w==
X-Gm-Gg: AZuq6aK8268WKfhnSSYh7FF7iiOlMI1BYF6wymrR4UwZInLSxGliiYesn8ySg5PHVIh
	xN4nYKAVj64tPo9Lvs2m4g/3GwJpeIJoJE5C2mgucti/nMYHHIcqXpKdR8wly1sW2xVWJzT8cAS
	RW41mWgamQBHud0kvYHvbUJXgiDsPmkz6EyeW7DDp7JytHHN6LEw319rbJD3oaQG7f8uTnxpYZF
	xOakQrqwnIMJGHrnXyQFhpMoB20vJZiiIx4P6Ox+AGccECblFYTWl1VYDaWYjJkOOaqeLbdrOqZ
	ThdQjwJGCTnAiOQy41CvRMR8N6g7XiNuCG9EUKmf5SkXKwJVARA7WR5/pAjVOCy2qw/kKreUcD9
	pHzX1puX8vaXOvPnDP3s80GTNH8/FChFWm947UkVE71B6MkVrhVh2MGAaYW3JjkauM9LoBJxSLO
	VVyao6hT/PC/enWAiayLkrbS4a/qbgfjAIdi2J3wtlj1cpNQ5pN+z1gw9k3fs8zUhVAzmKpC++g
	KDhyZZi2Jz2deA=
X-Received: by 2002:ad4:5de1:0:b0:894:6e23:3c3f with SMTP id 6a1803df08f44-894cc81e09amr106899066d6.20.1769637215910;
        Wed, 28 Jan 2026 13:53:35 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d3740f6dsm25243756d6.37.2026.01.28.13.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 13:53:35 -0800 (PST)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id A8058F4006D;
	Wed, 28 Jan 2026 16:53:34 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 28 Jan 2026 16:53:34 -0500
X-ME-Sender: <xms:XoV6ac3g9JzHLUNNmTj2yMvm-MRCyaYCLkJRsDdYj5rE5TkEB8VQEw>
    <xme:XoV6ach60KkUCWaJxMqLjVM8pUiEvhiZ138esZjQfCzSTl9Snh5lDvXJcXJmo3y0u
    F9ITqN1erJvRe35oK-DyLGW1ofQcvApVHfA_UHxOThaQ37DZuZO634>
X-ME-Received: <xmr:XoV6aZoWew_74M3eZCOX84aDR9FYOmg9VlIvH5nYnBv0uku67o0KNi2E2XNMmh17u-7dl4xgsF8bjRzGHgL5B3SeUVma5724>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeggeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpefhkeetffffleefffelueduhfeufedtffdvuedtkeejhfeivdelkedvffejvdeu
    keenucffohhmrghinhepphgrthhhrdhishenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshho
    nhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngh
    eppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepgedv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhu
    giesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrtghusehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggr
    thhiohhnrdhorhhgpdhrtghpthhtoheprghrvhgvsegrnhgurhhoihgurdgtohhmpdhrtg
    hpthhtohepthhkjhhoshesrghnughrohhiugdrtghomhdprhgtphhtthhopegsrhgruhhn
    vghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtmhhllhgrmhgrshesghhoohhglh
    gvrdgtohhmpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:XoV6aWxkItRdfHtyPIt7nfN4U7qLd4rqy1yTjpDOxIaQv06kNi7bhA>
    <xmx:XoV6aclwGwdr9Wtenqdsnj8AVHyAfAPQbdpqTDxYixvQ0bgmWd2gWA>
    <xmx:XoV6af2L4jeRyBXPyPkw2egVYGFjzkyVOjnDGTTFQs8-3woI6qlcLA>
    <xmx:XoV6abQdJ5xiHW8IfQYP5akZWBNzI4AhN0-zD-JMQH5qPEpWKs8E5g>
    <xmx:XoV6aYerSrDOvB0R7IKW-t2o1O5m9Z14Rcarb4aJlySzNhqJHj9x8Nts>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jan 2026 16:53:34 -0500 (EST)
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
Subject: [RFC PATCH 1/7] rust: types: Introduce HasField trait and derive macro
Date: Wed, 28 Jan 2026 13:53:24 -0800
Message-ID: <20260128215330.58410-2-boqun.feng@gmail.com>
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

In order to unify all the `Has*` infrastrutures, a generic `HasField`
trait is added along with a derive macro `#[derive(HasField)]` which
allows generate implementation of `HasField` automatically, e.g.

    #[derive(HasField)]
    struct Base {
        a: i32;
	b: i32;
	#[field]
	f1: Field<Base, 1>,
	#[field]
	f2: Field<Base, 2>,
    }

two implementations `impl HasField<Base, Field<Base, 1>>` and `impl
HasField<Base, Field<Base, 2>>` will be generated with `&raw mut` and
`container_of!()`.

This simplifies the usage of the current `Has*` traits, namely `HasWork`
and `HasHrTimer`, and eases the introduction of more `Field` type in the
future.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/field.rs   | 73 ++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs     |  1 +
 rust/kernel/prelude.rs |  4 +-
 rust/macros/field.rs   | 85 ++++++++++++++++++++++++++++++++++++++++++
 rust/macros/lib.rs     | 11 ++++++
 5 files changed, 173 insertions(+), 1 deletion(-)
 create mode 100644 rust/kernel/field.rs
 create mode 100644 rust/macros/field.rs

diff --git a/rust/kernel/field.rs b/rust/kernel/field.rs
new file mode 100644
index 000000000000..347387731d71
--- /dev/null
+++ b/rust/kernel/field.rs
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Field types to describe a field inside a struct.
+
+/// A field.
+///
+/// The generic type `T` is usually the type that contains the field. For some field types, it
+/// needs to be generic over the type containing it, because it needs to be initialized with
+/// container-type-specific callbacks. For other types, simply implement [`Field<T>`] for all `T`
+/// to indicate there is no restriction.
+pub trait Field<T>: Sized {}
+
+/// A struct `T` that has a field `F`.
+///
+/// # Safety
+///
+/// The methods [`raw_get_field()`] and [`field_container_of()`] must return valid pointers and
+/// must be true inverses of each other; that is, they must satisfy the following invariants: -
+/// `field_container_of(raw_get_field(ptr)) == ptr` for any `ptr: *mut Self`. -
+/// `raw_get_field(field_container_of(ptr)) == ptr` for any `ptr: *mut Field<T>`.
+///
+/// Use [`macros::HasField`] to generate the impls automatically.
+///
+/// # Examples
+///
+/// ```
+/// # use core::marker::PhantomData;
+/// use kernel::{
+///     macros::HasField,
+///     field::{
+///         Field,
+///         HasField, //
+///     }, //
+/// };
+///
+/// struct Work<T, const ID: u64> {
+///     _x: isize,
+///     _inner: PhantomData<T>,
+/// }
+///
+/// // Declare that `Work` is a `Field`.
+/// impl<T, const ID: u64> Field<T> for Work<T, ID> {}
+///
+/// #[derive(HasField)]
+/// struct B {
+///     #[field]
+///     w: Work<B, 2>,
+///     a: i32,
+/// }
+///
+/// const _: () = {
+///     const fn assert_has_field<T: HasField<T, Work<T, 2>>>() { }
+///     assert_has_field::<B>();
+/// };
+/// ```
+///
+/// [`raw_get_field()`]: HasField::raw_get_field
+/// [`field_container_of()`]: HasField::field_container_of
+pub unsafe trait HasField<T, F: Field<T>> {
+    /// Returns a pointer to the [`Field<T>`] field.
+    ///
+    /// # Safety
+    ///
+    /// The provided pointer must point at a valid struct of type `Self`.
+    unsafe fn raw_get_field(ptr: *mut Self) -> *mut F;
+
+    /// Returns a pointer to the struct containing [`Field<T>`] field.
+    ///
+    /// # Safety
+    ///
+    /// The pointer must point at a [`Field<T>`] field in a struct of type `Self`.
+    unsafe fn field_container_of(ptr: *mut F) -> *mut Self;
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index f812cf120042..36259aac1843 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -93,6 +93,7 @@
 pub mod drm;
 pub mod error;
 pub mod faux;
+pub mod field;
 #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
 pub mod firmware;
 pub mod fmt;
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index 2877e3f7b6d3..3668ef42046b 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -25,10 +25,12 @@
 pub use crate::alloc::{flags::*, Box, KBox, KVBox, KVVec, KVec, VBox, VVec, Vec};
 
 #[doc(no_inline)]
-pub use macros::{export, fmt, kunit_tests, module, vtable};
+pub use macros::{export, fmt, kunit_tests, module, vtable, HasField};
 
 pub use pin_init::{init, pin_data, pin_init, pinned_drop, InPlaceWrite, Init, PinInit, Zeroable};
 
+pub use super::field::{Field, HasField};
+
 pub use super::{build_assert, build_error};
 
 // `super::std_vendor` is hidden, which makes the macro inline for some reason.
diff --git a/rust/macros/field.rs b/rust/macros/field.rs
new file mode 100644
index 000000000000..3d32e5089f27
--- /dev/null
+++ b/rust/macros/field.rs
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use proc_macro2::{Span, TokenStream};
+use quote::quote;
+use syn::{
+    spanned::Spanned, Data, DataStruct, DeriveInput, Error, Fields, Generics, Ident, Result, Type,
+};
+
+fn impl_has_field(base: &Ident, field: &Ident, ty: &Type, generics: &Generics) -> TokenStream {
+    let (impl_generics, type_generics, where_clause) = generics.split_for_impl();
+
+    quote!(
+        // SAFETY: The implementation of `raw_get_field()` only compiles if the field has the
+        // right type.
+        unsafe impl #impl_generics
+        HasField<#base #type_generics, #ty>
+        for #base #type_generics
+        #where_clause {
+            #[inline(always)]
+            unsafe fn raw_get_field(ptr: *mut Self) -> *mut #ty {
+                // SAFETY: Per function safety requirement, the pointer is valid.
+                unsafe { &raw mut (*ptr).#field }
+            }
+
+            #[inline(always)]
+            unsafe fn field_container_of(ptr: *mut #ty) -> *mut Self {
+                // SAFETY: Per function safety requirement, the pointer is valid, and it points
+                // to the right field of the struct.
+                unsafe { kernel::container_of!(ptr, Self, #field) }
+            }
+        }
+    )
+}
+fn handle_struct(
+    ident: &Ident,
+    generics: &Generics,
+    st: &DataStruct,
+    span: Span,
+) -> Result<TokenStream> {
+    let mut impls = vec![];
+
+    if let Fields::Named(fields) = &st.fields {
+        for field in &fields.named {
+            let found = field
+                .attrs
+                .iter()
+                .find(|attr| attr.path().is_ident("field"));
+
+            if found.is_some() {
+                if let Some(name) = &field.ident {
+                    impls.push(impl_has_field(ident, name, &field.ty, generics));
+                }
+            }
+        }
+
+        Ok(quote!(
+            #(#impls)*
+        ))
+    } else {
+        Err(Error::new(
+            span,
+            "`#[derive(HasField)]` only supports structs with named fields",
+        ))
+    }
+}
+
+pub(crate) fn has_field(input: DeriveInput) -> Result<TokenStream> {
+    let span = input.span();
+    let data = &input.data;
+    let ident = &input.ident;
+    let generics = &input.generics;
+
+    if let Data::Struct(st) = data {
+        let impls = handle_struct(ident, generics, st, span)?;
+
+        Ok(quote!(
+            #impls
+        ))
+    } else {
+        Err(Error::new_spanned(
+            input,
+            "`#[derive(HasField)]` only supports structs",
+        ))
+    }
+}
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 85b7938c08e5..4fccca0e11af 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -13,6 +13,7 @@
 
 mod concat_idents;
 mod export;
+mod field;
 mod fmt;
 mod helpers;
 mod kunit;
@@ -486,3 +487,13 @@ pub fn kunit_tests(attr: TokenStream, input: TokenStream) -> TokenStream {
         .unwrap_or_else(|e| e.into_compile_error())
         .into()
 }
+
+/// Derives the implementation for `HasField`.
+///
+/// See the documentation of `HasField` for more information.
+#[proc_macro_derive(HasField, attributes(field))]
+pub fn has_field(input: TokenStream) -> TokenStream {
+    field::has_field(parse_macro_input!(input))
+        .unwrap_or_else(|e| e.into_compile_error())
+        .into()
+}
-- 
2.50.1 (Apple Git-155)

