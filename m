Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37535336EDA;
	Thu, 28 May 2026 06:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779949714; cv=none; b=jLWDt7pTakHginUjSGvSctYPPYEuu+jc/sx2edxFeFjuLKhNyMfJ9dL8nY48krtuW6kq9RbmdRo19wn9uB5rkzEh5By9KEw64J7+8dZGdRrSpogyr7fkvUw4F/dXmPRAgY18JvBaGsAu9ACVi3Pe0pTWGK+JZobFvtZ/N1K91Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779949714; c=relaxed/simple;
	bh=iNIea3X1u5UlLSCKpcd9EjyAvSlc5TEnDXzmsvHUUBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gSsl4NH9bkbAjtGlb+Bf3ZjziYx9/pAQytH67hgkF2jDfSPtaGqRCK2ERI9lG33B/dIcOx96owUbeUqLSGuCJegtQJdDtjL5+5GYxBb/1NjDRyWynJIPhXc3vA3SFaQMbDCboj0Euenxey4L7GBWI++cqr3iKK4cBHQKGd3GJr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=CVRw1pE5; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="CVRw1pE5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1779949708; x=1780208908;
	bh=JkD+A35aA68GLUHdDWX6WjTBKf+CG0Z+zqkNuKRO2O8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=CVRw1pE58Y0iMS5n8iZdWmhn7Hknf/+IjJDVF5nhEmrVu5Q9riWpByX49owN140+O
	 9yGjY3LIXUCA4Jwgx6Ax0Q2FtC0CcGeMKexWGHlVbDSICNEoWp7AyANz2HXhqnV78f
	 E0cwySEjNEVlrWcI+L9iGKUqI5llZMAl7cjOPNQwVVW+PDoVMNWYs6k0Yom4FZ9bgq
	 H18XSTzCH1a4VZYdpiYDEah6RblIYEUX6TJlJea2Yki8sl3dKVfv3pdJxb3oqJXf52
	 FHRxcnNrpVhlZGRV0YsGabYSgz+LlJBZKyaeMwFlYFRnyWPehjYAzzKuuW7cDRjeG1
	 +7HzhDlmCMkkw==
X-Pm-Submission-Id: 4gQxQ04Jp9z2ScpZ
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
Subject: [PATCH v7 4/4] MAINTAINERS: add Rust SRCU files to SRCU entry
Date: Thu, 28 May 2026 09:27:36 +0300
Message-ID: <20260528062810.256212-5-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260528062810.256212-1-work@onurozkan.dev>
References: <20260528062810.256212-1-work@onurozkan.dev>
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

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
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

