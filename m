Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2B13C1985;
	Wed, 27 May 2026 20:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779914207; cv=none; b=eemEUSp18/lxk9rfdSzA0A8L2MZYn6bRSJCUp3DFuu+Ktrqu021wNhPbw6Ax7sLuzWK7p0c1yoiqU+9SVfyG59KGikv3ENdhMTFLhDnTAXi6U5TEkowuiFMvvvbZJ+T0ci3VQY02fi2k/YlMpjlsM/kCVkIanyAyru+3cPKl0Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779914207; c=relaxed/simple;
	bh=OXKg7IoJRXxJABbEWtm/U0WbRH/zsPKFQvYu+ZBgzKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cmFni1A84rOgh/yQk+JGaCR8kudcqQugfRvfe9O1JkmjclgaQEq/oaJcza0vPAk/butW7x7tnJkbdPDzQzcVsoxeK5toxZRdHDmUADmLmNx66D9qtpTrZxemI2KOnIIzIzoIEcqAHuRsWLVO0YFmFNCGrjsMlpcGDCnHC1f/+eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=DQ39TtCF; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="DQ39TtCF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1779914193; x=1780173393;
	bh=/JxKK4le+0Qf2c0FvyVzReRLUsasiZAYNwA0SE2Vp0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=DQ39TtCFIGeakg/Ev8v8CdM2/fvm9mSkgci3srGnlK954lwFdvCy6RC3d+J/Zwzns
	 ijYtfu0zZTYlMCDyN8XgwtcLEYFrJIjUihZ6j0FUZqIYLl88uCSMwB4Kf1nlAklsGF
	 h8HwhORmC7L2ui8Gv79pklwzPQHB8CBel0L+3pMA+KnSbMLufxz9/700atr2NRvn7j
	 bjfiNLahilCIFKT8Z2XMgFLL6lBtOR5W55hRDG7d5p71rmTDDsyK+TBNIBRnpaVDTU
	 J4vXcd3DLmKPPEVLNNVmJBgTErQ9igkdMPNcKku21smiOJxde7TQRxasyAR0/DNtIY
	 29Y/esV2HY85Q==
X-Pm-Submission-Id: 4gQhH22LH3z2Scq5
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
Subject: [PATCH v6 4/4] MAINTAINERS: add Rust SRCU files to SRCU entry
Date: Wed, 27 May 2026 23:35:35 +0300
Message-ID: <20260527203615.163688-5-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260527203615.163688-1-work@onurozkan.dev>
References: <20260527203615.163688-1-work@onurozkan.dev>
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
index e0b307b2108c..7739a435f258 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24624,6 +24624,7 @@ SLEEPABLE READ-COPY UPDATE (SRCU)
 M:	Lai Jiangshan <jiangshanlai@gmail.com>
 M:	"Paul E. McKenney" <paulmck@kernel.org>
 M:	Josh Triplett <josh@joshtriplett.org>
+M:	Onur Özkan <work@onurozkan.dev> (RUST)
 R:	Steven Rostedt <rostedt@goodmis.org>
 R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 L:	rcu@vger.kernel.org
@@ -24632,6 +24633,8 @@ W:	http://www.rdrop.com/users/paulmck/RCU/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git rcu/dev
 F:	include/linux/srcu*.h
 F:	kernel/rcu/srcu*.c
+F:	rust/helpers/srcu.c
+F:	rust/kernel/sync/srcu.rs
 
 SMACK SECURITY MODULE
 M:	Casey Schaufler <casey@schaufler-ca.com>
-- 
2.51.2

