Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F362D385519;
	Mon, 25 May 2026 17:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779731852; cv=none; b=IQ1kuid6BNTfh8d35E7KEdBokDLx3rw8peTGY66s/5uwnKnf2j3W/r7zsyzC8NDYCsgfnubqkur/xflhLETHYDxnEB5+zr+dPRDmRjET2ewNGNDuOi8dwLx4ZFMS+UVJICwaQSEsssvXaQTWjnkPzMwWDKRxpP8X2H25lTT4EWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779731852; c=relaxed/simple;
	bh=OXKg7IoJRXxJABbEWtm/U0WbRH/zsPKFQvYu+ZBgzKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ObMliNtQz9HGXd/xd09MsCgPBhS2e+pBwtclhy26VmoaZ01Ap2fp/YymWft2lUm/fWj2rMLovkyuMiSyYp+JDau1zYYWbtoa1Vds3AW0BlPB6hjvD26EFBUsjib3Nc//ufHer017PTboiLgvTb8tOyuh94HW51tVn1paPNQ0AHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=R1DLfVb4; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="R1DLfVb4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1779731847; x=1779991047;
	bh=/JxKK4le+0Qf2c0FvyVzReRLUsasiZAYNwA0SE2Vp0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=R1DLfVb41ZBIAygaB4/DReRheqtwasz6RmG33/D4KgKR77mM7f4Q0gmpvlOtjgAkK
	 uAFg9i1tAMbFV5DKbzZKbChIgd7OjjmbYHuEXD5G0Lzw9Ay2Nc4KYNDFgggt8I6HiC
	 5zqVkp+j3DJiso16SI7zZZ8aNFVsCXXH0ll1i7EGfpIDqWSoiYLbJgcWf0cdEHE1A1
	 0sIbTjCDChzk8ckRdSYIF7PGD6ccvu3U+Xt35kf3bFlOa4ZdpJsO3rKtW2oWl66U4I
	 gof2DIpMFQv5tGq/r5IRyMVTlHG2HZPBRe+3Twj3Lbn500nTmN18S+iAY36Zqehl6T
	 apJ32bh/tbwuw==
X-Pm-Submission-Id: 4gPNrL243yz1DH2k
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
Subject: [PATCH v4 3/3] MAINTAINERS: add Rust SRCU files to SRCU entry
Date: Mon, 25 May 2026 20:55:51 +0300
Message-ID: <20260525175706.124910-4-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260525175706.124910-1-work@onurozkan.dev>
References: <20260525175706.124910-1-work@onurozkan.dev>
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

