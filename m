Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562082475CF;
	Wed, 22 Jul 2026 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784731834; cv=none; b=KG7XTbQNTu7D/wX4CoaVP//pYRHZ8vc917wCVBn1NskiEwK3jj9whG1BeH7QQA3whlck2Z0PhmBSzlamu2+kgT11G9qc528xticH1Ao+mgAKB+iuZBA/hQ7K3+/FMpgX2qW1s/Q0nwZRrXrJ28CfowtyF/oJcy2+ux3OCOSgcUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784731834; c=relaxed/simple;
	bh=aSMYU3rAG5+Gh8QRe3AZRYYIPcLUqtmNgzBxP4IU/2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=drV6smI2kZ5cMT0hFU+0VKuoZn6vYh6fifx8bI8kISNvjS2urKWC8tqLZDalvStItQEQri0BMAaDybLHKF6XOvQebHYnuwoQPnmuFywLzBqQtRQ5fOiK2MsifAmCvzrkznU+BjaDmHOdDsXL1zwCZseLW7RzWudHLoREDP28YLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKtKATec; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKtKATec"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF311F000E9;
	Wed, 22 Jul 2026 14:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784731833;
	bh=DZ3kMcQI0qYmxVkBtHIsi69cXvHkfXdSOkp6hTp/YSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QKtKATecshukMber2zGZmeYjySeN8q5+zEMXImK5x2izgsyFTYB6iEQBqUGP8RB9I
	 uzpTB54JbyVugpyz9YiW5UjINIximmFRzrK0Hb9zkTt66ZR0t1f/l2kL/cE9uzuDIj
	 6sQy3ImqEjDdQUhc9BGCCgze+n++dx9U5otkWgDs0UF/le6DgHR180ZW1BM9Y1I6dL
	 IYhAU3fo5i6eW0YT3+7OENWJWL5l5zLCmqgYqtF2CJYlDc+DDONLbe6ImsSRHpA8EK
	 bQU0wFB6Ye8TVBefeR/9814xfOcJvsuNtS/1fV6LDNgbkVGhFmLwp/19PdcAYGGyMq
	 cI8s7pYpMfK7Q==
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
Subject: [PATCH v6 2/6] rust: error: Add ECANCELED error code
Date: Wed, 22 Jul 2026 16:49:26 +0200
Message-ID: <20260722144931.1070312-4-phasta@kernel.org>
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

The Rust dma_fence abstractions need the ECANCELED error code.

Add ECANCELED error code.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/error.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index a56ba6309594..cb666f0d42ee 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -67,6 +67,7 @@ macro_rules! declare_err {
     declare_err!(EOVERFLOW, "Value too large for defined data type.");
     declare_err!(EMSGSIZE, "Message too long.");
     declare_err!(ETIMEDOUT, "Connection timed out.");
+    declare_err!(ECANCELED, "Request has been canceled.");
     declare_err!(ERESTARTSYS, "Restart the system call.");
     declare_err!(ERESTARTNOINTR, "System call was interrupted by a signal and will be restarted.");
     declare_err!(ERESTARTNOHAND, "Restart if no handler.");
-- 
2.55.0

