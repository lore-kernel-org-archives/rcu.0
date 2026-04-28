Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839D03EFD31
	for <rcu@vger.kernel.org>; Tue, 28 Apr 2026 10:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777372509; cv=none; b=GjBNw19qDyphoEppimeJzTbVvX98kJThv2lRvapeDExnjjNVVZHKLRCac1xSX6RWiDyrd1TXACkl9R2qDZvx9DppSLE28uzLV1P4Z861QTGzJ8TJZKxT8UIOTGtiN2DzwP/VGcLMWP1xLxnxjBqQOh9DUAkamuJDMS9LjwmGGF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777372509; c=relaxed/simple;
	bh=aLN/nYG9SOkiA4x4g2eZtGH4x/hIBvc7zj9D1ao0FNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hP7cYFwcHDNwaLu7SfUoDNDUTe4g8a6777Zxnk1oKdCueaj45KjLXtmhsRiRFeMPqQuCwW+XrIwwLvfSqQ6y3s4+XWWWwAuvVwQ0ZQJ3pwGxtMQ/lr1ZrV/WYKOS/nVdG5VJObV8wzZi3tHkp2KmSPT6IXbwZSm+9p4L8/3h14c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=p+vYSuFz; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="p+vYSuFz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1777372492; x=1777631692;
	bh=H3sh8/9rJHMx1+JJUzxq6tpBVaFRS1rv7nPe7gXi5Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=p+vYSuFzHl/TYa7yJuu56kGVfY00dHuPjky5xPngap7531Z3kwpOyBsE/d+AfEEO/
	 dtVkvxU9u4wWXHfbzyQNJUbasXGwY5QOyuLGz7gwRhm9Y0NY/Vod1o3pZ1fVcgfURM
	 zAEPB60TW7cUcQ8rWGKOpeeglGPJSI/uNvLONSHl/t1Sbt8hke7758o5RN2fZhFRR6
	 9cIpZYPyrGMCaQJOSQc6MlbYMEf7Q7QNANU/ZRQk1Yl7dxPe2nFwFVghgtG9uY+k3b
	 oHHVMaWxriNmP5Fp1fUleyHn+POGvskQAiMMm1grdkbAgOVtLFnQ7ORs/+b67iHNOO
	 jakJsMUAsXFHw==
X-Pm-Submission-Id: 4g4cJ84XKTz2ScWp
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: rcu@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	peterz@infradead.org,
	fujita.tomonori@gmail.com,
	tamird@kernel.org,
	jiangshanlai@gmail.com,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v1 3/3] MAINTAINERS: add Rust SRCU files to SRCU entry
Date: Tue, 28 Apr 2026 13:34:37 +0300
Message-ID: <20260428103437.156236-4-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260428103437.156236-1-work@onurozkan.dev>
References: <20260428103437.156236-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Include Rust side implementation files to the SRCU maintainer
entry.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9c93fa23654c..8c1588e2f6fe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24405,6 +24405,7 @@ SLEEPABLE READ-COPY UPDATE (SRCU)
 M:	Lai Jiangshan <jiangshanlai@gmail.com>
 M:	"Paul E. McKenney" <paulmck@kernel.org>
 M:	Josh Triplett <josh@joshtriplett.org>
+M:	Onur Özkan <work@onurozkan.dev> (RUST)
 R:	Steven Rostedt <rostedt@goodmis.org>
 R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 L:	rcu@vger.kernel.org
@@ -24413,6 +24414,8 @@ W:	http://www.rdrop.com/users/paulmck/RCU/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git rcu/dev
 F:	include/linux/srcu*.h
 F:	kernel/rcu/srcu*.c
+F:	rust/helpers/srcu.c
+F:	rust/kernel/sync/srcu.rs
 
 SMACK SECURITY MODULE
 M:	Casey Schaufler <casey@schaufler-ca.com>
-- 
2.51.2

