Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F868411664;
	Tue, 16 Jun 2026 08:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781598552; cv=none; b=rr1PUCqsf0QcwmpC+PiVR3e7Z7CnSW1mOWZYoARKivbD9kNJ7yWogZ8ofC7pCgFF3jxHUjy0yMkNiYQZs8ISAOUd3r127yehUEBD7I2yQqTMhnXnf54JdW+IKuVpRSx2kHsIhGvhYXNP5PM0KK5cITzSZ2CqLvnXYJTAK4FU48E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781598552; c=relaxed/simple;
	bh=FhAwDT6Njj0GamS5iIl++pF0a3gvu3D47E6F5J/yNZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBhO0kXyzDwSU0GD6gtCf3aqFgcx2+OjARqmPRYy2GaxCgmR+foQbabx3byqauKmFA/jOaSlf4Y4tI8m8h1Y+CT/zWuQRTPWK2o0XsGmT5Ni8vk0BfBUV8AeenrxvZf6jAz6v9y95f+0cMggMq9hBIZ/qdJwEVXyBps/a38repc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRW6KNvp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRW6KNvp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB1F1F00A3A;
	Tue, 16 Jun 2026 08:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781598550;
	bh=i2oPOFwXlYMxWoiNDy0bX/9St4UBqgR1RnbnsmsD43E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CRW6KNvpHrKNPKh2vLmXwltKevUdDPtaUAg7zGNGDXTIZGb19h8hnd8x/DC1UufzZ
	 sC+TbxBbZA0WSLRGfFebkDcCndeVct+jsFBjYNMYKqZhZgrbJ47RcWjOn81gaScazs
	 CBC/qw3TQ3sxAQJD8e3B9v0bSAJA4Lss1NA6sjRwr4Eqt6mTsx/hLgv1xLiaHGX8YL
	 zYVGPQ2IV7SydXEco6rc9yF47/67lQDiLxwHXxqCepVo4xOduwd6YBSVnpgw/lDXoV
	 +d+cTd4mjJXJIIXEWFgPq37hD4XQK/S0E/MrGDYIzzj236GrcIl+GmXrL4Ca9+Q0kg
	 GwsRABQdWk3Ww==
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
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>,
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
	Daniel Almeida <daniel.almeida@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Igor Korotin <igor.korotin@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Krishna Ketan Rai <prafulrai522@gmail.com>,
	Shankari Anand <shankari.ak0208@gmail.com>,
	manos@pitsidianak.is,
	Boris Brezillon <boris.brezillon@collabora.com>
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	rcu@vger.kernel.org
Subject: [PATCH v2 3/6] rust: sync: Add abstraction for synchronize_rcu()
Date: Tue, 16 Jun 2026 10:28:15 +0200
Message-ID: <20260616082819.2943886-5-phasta@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616082819.2943886-2-phasta@kernel.org>
References: <20260616082819.2943886-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

synchronize_rcu() is a frequently used C function which is always safe
to be called.

Add a safe abstraction for synchronize_rcu().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 rust/kernel/sync/rcu.rs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
index eef34bf86259..d86d615467b1 100644
--- a/rust/kernel/sync/rcu.rs
+++ b/rust/kernel/sync/rcu.rs
@@ -56,3 +56,11 @@ pub fn rcu_barrier() {
     // SAFETY: `rcu_barrier()` is always safe to be called. It just might wait for a grace period.
     unsafe { bindings::rcu_barrier() };
 }
+
+/// Wait for one RCU grace period.
+///
+/// You typically do this to wait for everyone holding a [`Guard`].
+pub fn synchronize_rcu() {
+    // SAFETY: `synchronize_rcu()` is always safe to be called. It just waits for a grace period.
+    unsafe { bindings::synchronize_rcu() };
+}
-- 
2.54.0

