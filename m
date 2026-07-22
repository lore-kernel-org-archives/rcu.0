Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C4A37207D;
	Wed, 22 Jul 2026 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784731871; cv=none; b=rQTD84vFLIkOqVg875JPlRNYZ5Si+x+xW2JYF5+ckwE8yMcOuyA3TgFO0QQPo5mF0t7SkOHgG/AdqE6/GJKFs4d7t6lmuGY/YpO3KoAu1vcbvd6Wgf9+YmjAhu+qH9YK6dGATj39EqBJ2JOPaRJtj3BXAzSaw2L4dCddA7VZOO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784731871; c=relaxed/simple;
	bh=a2JzSHpl1u9rJ6J+B/5Ln6ZHvZE8FVqmZtBCNW+d51I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O3TFzZTH1rvDMIQxcfAdYGFrxQFjaqxkafk9vZsYmbG+NuTsgQirjB3oC0roOUjzpLJTRy3l/mRdkpwewK9po2H5DrbyGg33ZzOzjoJeDcTtn3gPF+jnR6lSp0Vj43Z/hzDVj4uBCMS0j0VOXYdcYMjE3j4jNSTwSGjq/Tj8HKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFze4hgc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFze4hgc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156EA1F000E9;
	Wed, 22 Jul 2026 14:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784731869;
	bh=4+kdpOSbYNuwg9iO0Aocs3O30U1qLI1bO+WgZ1kcKkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eFze4hgcsvO59JcuBCrNf5eYU1oZfBzqbKWg26kkzcyJ8dgZpWsOkkaXLVRybnGXN
	 3j98h8baBTR530HbWrsyQF3irXTkwA2a81dVCmEDdTCbcdX9eCJSfLJ3Kk9VVCt3lk
	 Ch4EdZB4CbZXbEYynMj0duN90jV7eeNbpnrbJs3ZVi4abwUIajJLHiigFLnTyix9dJ
	 8PiGHjlnfFuCyCOt/RV+bZoz0CjSRF7w3OIpnaV7AvU7dRbfhI6+NdYmP8r/l5Dxz9
	 lAj8FaiTdxjk5BFjVm97DIZ3CDkcA6hDi3hXPkFtRJ4JrVil5OowRArSqll3b1oEyW
	 Pjry3JLOLQziQ==
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
Subject: [PATCH v6 6/6] MAINTAINERS: Add entry for Rust dma-buf
Date: Wed, 22 Jul 2026 16:49:30 +0200
Message-ID: <20260722144931.1070312-8-phasta@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722144931.1070312-2-phasta@kernel.org>
References: <20260722144931.1070312-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Rust does now have abstractions for dma_fence. These abstractions are
quite complicated and require expertise with both the C and the Rust
side. Therefore, using the existing entry also for maintenance of the
Rust code appears reasonable.

Philipp volunteers to help maintain the dma_fence abstractions. Add a
corresponding MAINTAINERS entry.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
Acked-by: Christian König <christian.koenig@amd.com>
Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 15011f5752a9..5e5a23a21cd8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7622,6 +7622,7 @@ F:	fs/dlm/
 DMA BUFFER SHARING FRAMEWORK
 M:	Sumit Semwal <sumit.semwal@linaro.org>
 M:	Christian König <christian.koenig@amd.com>
+M:	Philipp Stanner <phasta@kernel.org>
 L:	linux-media@vger.kernel.org
 L:	dri-devel@lists.freedesktop.org
 L:	linaro-mm-sig@lists.linaro.org (moderated for non-subscribers)
@@ -7635,6 +7636,8 @@ F:	include/linux/dma-buf.h
 F:	include/linux/dma-buf/
 F:	include/linux/dma-resv.h
 F:	rust/helpers/dma-resv.c
+F:	rust/helpers/dma_fence.c
+F:	rust/kernel/dma_buf/
 K:	\bdma_(?:buf|fence|resv)\b
 
 DMA GENERIC OFFLOAD ENGINE SUBSYSTEM
@@ -8621,7 +8624,9 @@ T:	git https://gitlab.freedesktop.org/drm/rust/kernel.git
 F:	drivers/gpu/drm/nova/
 F:	drivers/gpu/drm/tyr/
 F:	drivers/gpu/nova-core/
+F:	rust/helpers/dma_fence.c
 F:	rust/helpers/gpu.c
+F:	rust/kernel/dma_buf/
 F:	rust/kernel/drm/
 F:	rust/kernel/gpu.rs
 F:	rust/kernel/gpu/
-- 
2.55.0

