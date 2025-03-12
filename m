Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AB31E7C03;
	Wed, 12 Mar 2025 10:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741774657; cv=none; b=uGVFsHdG7VH8fWCe32EkMBWDAteLInMrVllUJ38Bp3PNGHPwc+kBKhU/3za5aaBDDCy3dWWSV9CKsT+CflF8BPGi4ZOqZ31v06ixL4t8uStCzDk+BqBM3Dr9Eq0dCsTMSdDghct6n5qCS3RUDZTOUZXcpLigIPxzPBZ9sb9N1tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741774657; c=relaxed/simple;
	bh=khIVvvPM63SZripAQJxgge0us1XyV4NC6idslFxchxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nMbir5pEAJ7eSf6rDi4/ec/hKBesDt66RLaiiQztcNnEngU3BN7ILTasyyEF5sRjbhn9ZRRxHg5V7CDzCPxYSceSqzJmXGiKatZX8zHYhksJPa+bvdOIjsnLG5K8b5bNKPLgcDikk8h3aeWC8/VmuBB005FSRb5io1QyRlOwWuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTIl3s0X; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTIl3s0X"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-224191d92e4so113729005ad.3;
        Wed, 12 Mar 2025 03:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741774655; x=1742379455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j8K+cYY8a18S9R6p3y1Avimn06H8Fj9HbvffhzxH0lg=;
        b=iTIl3s0XQO8eV47WJbhwVGK9iw2V6pYpz7MrMV8oMNvVxAqbDcZmErhU/A+F3wQD6M
         SDZYKQ1GMUy7alCwLwlaeZLhEtuLgTlPPFokS24T0qpciNYeSp0R71wr9wo5/BUfuzlx
         ZYOIfyQbMBcFE4Lp+NeH7zm8C2tW91ZTbxI1nj6NiVE1cw/lpUj4mYinwofzepaub81r
         1gSgMyMfzHbnp2DC+8pFQkx+O9iA6uzo5QJzxfrxFW8BFLlaflExLvd1vjuOUD0UICEp
         h8zeJXOV2jYmz5LJ54fsbuRXFv0mY7Q5OECRYrYi5AExmC5B43cKeXWxCz+4tHpolMHr
         0lrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741774655; x=1742379455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j8K+cYY8a18S9R6p3y1Avimn06H8Fj9HbvffhzxH0lg=;
        b=KnSKsk7IL9cOaO02fP7EW9W/RsY5PBjcOGrkJNlBno03lQihbFA6PCx+NPbZHqvoNj
         8eMAkSqhdUwYqw9kn58hwczkgaR8RARWi/AI9eIc79x9YgyO5BSLxQ/Myy9gBgzOpEh3
         v8oE82qxX/s0ELE2eCbVboS9KIJPj+KMIEnK3h3JhHh0mXnEbiFyylvGku/53SBWRi2w
         /LJk/vjPktMBAxQYt4441Ptz6CoqREPxtCZ8IY2S9++NjMtjME//Z1ZVfDNGOfAYpeM9
         VBk3ReAclmehnYQyw6nkdF5gDpZk6Fw90h0vGo+yZ4eH4EBIWyXomSPiE+QJHFLycycF
         IzJg==
X-Forwarded-Encrypted: i=1; AJvYcCX0yV8gdyo3YT/4M2C+zpr7xuXGGz7o0om2zMStllw+rlkyq+paUBFDY2gYt25esy+9M2yjpKyBFWLg2abTG2w=@vger.kernel.org, AJvYcCXRP1OMt61esYDSM80f2eEUmPb30ViKUlQKVM2Z1iSGVUPbWbF+ziTqn3NV+oyG1MR9SuKi@vger.kernel.org, AJvYcCXn4AOtjW1dBkMZnF749mN451CxlFVgY/dve8wdsJeNaI/J1TQpXp0Ij4y87wA1XzhVV/xGZL8iYV1iQpo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8ypbEdKj/5XIyhaSRfFCkXJsvE4o1Bypd2oY21/6tXhdUdMOH
	OHTu943B6zyPhqq1RFkQvmMdtKFKvpzBtJy5X5tfEJ8PPjUPqngP
X-Gm-Gg: ASbGncvmuh5mB0DLsx56jebndepatdgB5z2Y2XkN9ttyzqbM7yTTvDSOzS0ehT5eNCK
	jgU6LT0SwlcDOnZuPVJ9L6kWlsGeONE50R08MDK4JINIIkzvvJ57K6tW/UETxK1OOxF9V2qyZ1I
	ioC47eB1ZN/ziPBHAyNY6mwC9PI1HWrcOl3HtICL1UzkW/2M8EKjefYvTdjGbOt2rhZeB6VAzUj
	jO5vxCyXQa2XArAhy82rZygbI3E5ZTYHxtSqNynJtEEn4iyVUMzAW1ZKtBNK+ffwVBt1rrpP653
	NkAVeVmqx3hVGDG5xCSImGURVAav+C/QjfyMSp6HX913XCwT9pFlBYR1LF7GYS7YXIgL/PzVFdE
	=
X-Google-Smtp-Source: AGHT+IFpBE7U7iik0fYQ+M+FGBImQq+8odhk1PWelYdIWPjOg2tdExe6wfLmeOD159AI/ZuDSx+GUw==
X-Received: by 2002:a05:6a00:1703:b0:736:a682:deb8 with SMTP id d2e1a72fcca58-736aa9e54edmr36025132b3a.8.1741774655310;
        Wed, 12 Mar 2025 03:17:35 -0700 (PDT)
Received: from vaxr-ASUSPRO-D840MB-M840MB.. ([2001:288:7001:2703:6099:fcdd:8775:d642])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736c8e06336sm7398569b3a.58.2025.03.12.03.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 03:17:34 -0700 (PDT)
From: I Hsin Cheng <richard120310@gmail.com>
To: rostedt@goodmis.org
Cc: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org,
	josh@joshtriplett.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	rcu@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	jserv@ccns.ncku.edu.tw,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [PATCH] rust: sync: rcu: Mark Guard methods as inline
Date: Wed, 12 Mar 2025 18:17:23 +0800
Message-ID: <20250312101723.149135-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currenyly the implementation of "Guard" methods are basically wrappers
around rcu's function within kernel. Building the kernel with llvm
18.1.8 on x86_64 machine will generate the following symbols:

$ nm vmlinux | grep ' _R'.*Guard | rustfilt
ffffffff817b6c90 T <kernel::sync::rcu::Guard>::new
ffffffff817b6cb0 T <kernel::sync::rcu::Guard>::unlock
ffffffff817b6cd0 T <kernel::sync::rcu::Guard as core::ops::drop::Drop>::drop
ffffffff817b6c90 T <kernel::sync::rcu::Guard as core::default::Default>::default

These Rust symbols are basically wrappers around functions
"rcu_read_lock" and "rcu_read_unlock". Marking them as inline can
reduce the generation of these symbols, and saves the size of code
generation for 100 bytes.

$ ./scripts/bloat-o-meter vmlinux_old vmlinux_new
add/remove: 0/8 grow/shrink: 0/0 up/down: 0/-100 (-100)
Function                                     old     new   delta
_RNvXs_NtNtCsaYBeKL739Xz_6kernel4sync3rcuNtB4_5GuardNtNtCsdaXADs8PRFB_4core7default7Default7default       9       -      -9
_RNvXs0_NtNtCsaYBeKL739Xz_6kernel4sync3rcuNtB5_5GuardNtNtNtCsdaXADs8PRFB_4core3ops4drop4Drop4drop       9       -      -9
_RNvMNtNtCsaYBeKL739Xz_6kernel4sync3rcuNtB2_5Guard6unlock       9       -      -9
_RNvMNtNtCsaYBeKL739Xz_6kernel4sync3rcuNtB2_5Guard3new       9       -      -9
__pfx__RNvXs_NtNtCsaYBeKL739Xz_6kernel4sync3rcuNtB4_5GuardNtNtCsdaXADs8PRFB_4core7default7Default7default      16       -     -16
__pfx__RNvXs0_NtNtCsaYBeKL739Xz_6kernel4sync3rcuNtB5_5GuardNtNtNtCsdaXADs8PRFB_4core3ops4drop4Drop4drop      16       -     -16
__pfx__RNvMNtNtCsaYBeKL739Xz_6kernel4sync3rcuNtB2_5Guard6unlock      16       -     -16
__pfx__RNvMNtNtCsaYBeKL739Xz_6kernel4sync3rcuNtB2_5Guard3new      16       -     -16
Total: Before=23385830, After=23385730, chg -0.00%

Link: https://github.com/Rust-for-Linux/linux/issues/1145
Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
 rust/kernel/sync/rcu.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
index b51d9150ffe2..26df2a6cb09f 100644
--- a/rust/kernel/sync/rcu.rs
+++ b/rust/kernel/sync/rcu.rs
@@ -17,6 +17,7 @@
 
 impl Guard {
     /// Acquires the RCU read side lock and returns a guard.
+    #[inline]
     pub fn new() -> Self {
         // SAFETY: An FFI call with no additional requirements.
         unsafe { bindings::rcu_read_lock() };
@@ -25,16 +26,19 @@ pub fn new() -> Self {
     }
 
     /// Explicitly releases the RCU read side lock.
+    #[inline]
     pub fn unlock(self) {}
 }
 
 impl Default for Guard {
+    #[inline]
     fn default() -> Self {
         Self::new()
     }
 }
 
 impl Drop for Guard {
+    #[inline]
     fn drop(&mut self) {
         // SAFETY: By the type invariants, the RCU read side is locked, so it is ok to unlock it.
         unsafe { bindings::rcu_read_unlock() };
-- 
2.43.0

