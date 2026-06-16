Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3641140E8FE;
	Tue, 16 Jun 2026 08:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781598572; cv=none; b=Bzle457NWVE5RvRu1YC4wcR3d3HzgbmkPTqhuN9zRysswWzzc/9tRDrHY7RHrzJXE+zrTvIkGuxXyYrJoh6yDW+JsUK1HBRHr6xHcSe8BZGHr/QTXu0IACbpsAGkbsY74rt5803qCfaLpZ3Ad+tJZoaAjre78EN77PDq9LaEuQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781598572; c=relaxed/simple;
	bh=I+B92SpG9EdoK3syoxQM5s8Fyi3qpxNa1vVNpgCTmzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YKLzARoazOZW+4Xic/msrbhoDZlTYlXuC2y1sd4GMLvYRoxV8XGRMA2XLyZj9ux23HC3vb5gABujDi1ByrcXErX8e0EP3N5pQk3r0mC/+k5/EW4WxRTcedK4w6yIzfBH4An21Gmyxh2ZBkaNNxTFOxUa8xtCE5QYkQSdNP3B7do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKV7fz+C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKV7fz+C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C188E1F00A3D;
	Tue, 16 Jun 2026 08:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781598571;
	bh=/uNc7fnJTCY1nYNPyw7cFAMX160/R6LvJErYW/n0Hr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MKV7fz+C3SNbMiwkCYMmxLzidaSeUCDfUznSQ68s5uGzIzLi7bs4hO8bcRx71j0WW
	 NiqE7MfqqtkfTIJKv5La4Gyj9y02cC4i4Qdq3PGNOsSrtb1yZBJsHAzEvUB0Mcs/lU
	 URXgFHt7eOEdZ6ZJrTNMQJ7RDQ5bbnv3a7KK2i4QTQck0Y2F7ofIm+laqdSZeHRJba
	 cCxEnr+H6dvmgMguARKo3S+DJu616EQ09JMDw+IcuswuBlohY/chxK8Vveh8y107MN
	 6MaAvluZMuuVhvnQF7f2n0q+l8gB80VZjjxJtkIlMxHacMLn3tYGYTnKosyQeLX/uI
	 K46MhJUAVrHXg==
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
Subject: [PATCH v2 6/6] MAINTAINERS: Add entry for Rust dma-buf
Date: Tue, 16 Jun 2026 10:28:18 +0200
Message-ID: <20260616082819.2943886-8-phasta@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616082819.2943886-2-phasta@kernel.org>
References: <20260616082819.2943886-2-phasta@kernel.org>
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
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2e8d160babc2..5d4289099771 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7521,6 +7521,7 @@ F:	fs/dlm/
 DMA BUFFER SHARING FRAMEWORK
 M:	Sumit Semwal <sumit.semwal@linaro.org>
 M:	Christian König <christian.koenig@amd.com>
+M:	Philipp Stanner <phasta@kernel.org>
 L:	linux-media@vger.kernel.org
 L:	dri-devel@lists.freedesktop.org
 L:	linaro-mm-sig@lists.linaro.org (moderated for non-subscribers)
@@ -7534,6 +7535,8 @@ F:	include/linux/dma-buf.h
 F:	include/linux/dma-buf/
 F:	include/linux/dma-resv.h
 F:	rust/helpers/dma-resv.c
+F:	rust/helpers/dma_fence.c
+F:	rust/kernel/dma_buf/
 K:	\bdma_(?:buf|fence|resv)\b
 
 DMA GENERIC OFFLOAD ENGINE SUBSYSTEM
-- 
2.54.0

