Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C08B13777A;
	Tue,  4 Jun 2024 22:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539718; cv=none; b=uh06qRZbZBKbat68ZGcJ3NiYrsq39W9oZQDoDLP9PYpV2RZF4SuRPJFd7E8jKtdt32RSCSyfsZE03gtOeXUT1VqBxFRzPpp88ZLkqJz4iBhkztzDVPISV3zVXsaRjfMzvfDi9OxpFyfT2sgiH5q6m8SpvpKJsHRv+Xb4Razfako=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539718; c=relaxed/simple;
	bh=CuXVALkORaJs+PqG5WX2Eg3IMr6JUZzWBMU3JPWUmF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VSm5qYLnYMcNDaGbxjzZf/owcC48oPqliDKHxqmO3xVGAqjbClYLy5W2O1tjPOh688KNjiUgAYm5uilUo7A2j16j0Le8K3pDJ1ceD13AYsxXhsYG19XcxbJu04kjFT6FwKEhN/TZOHIbKGoM+eg021+tuNMmD+O4wc1KdRVPj+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzC72Mkg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzC72Mkg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7B4C3277B;
	Tue,  4 Jun 2024 22:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717539717;
	bh=CuXVALkORaJs+PqG5WX2Eg3IMr6JUZzWBMU3JPWUmF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nzC72MkgI40MmdAy+a5Hc+L0zUpGCRcdQNi0mZ7aE0OQebJYZ7NSOu9DhXMmoZ/e6
	 Xq5o5BgAJtoNJs3yBa86pwWfCkOkgUxs+46WbB9movXVoEioPFceQlNgvTNngmWAL4
	 Kw1EwyW4XWtVRJ0r9emdImWskZtKTe+VhYlheW+KjYCGxzR4A+p7gIbWAJNzo9axAp
	 b8W7uA0+Yrv2rAt5DJ9+uxtTa/bBakiUNeRp7Xu0/xqcGFxpfyElV7hWdQhF5+ADvb
	 76Rq+UOJ0X4p9rlQJQ0vw+P+bmnQKUAhLtX97XdWuvwGBE3EiAwZN34+8UUgSabFfE
	 Ay21pHsqH4xrA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 89832CE3F0F; Tue,  4 Jun 2024 15:21:57 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Rao Shoaib <rao.shoaib@oracle.com>
Subject: [PATCH rcu 2/2] doc: Clarify rcu_assign_pointer() and rcu_dereference() ordering
Date: Tue,  4 Jun 2024 15:21:55 -0700
Message-Id: <20240604222155.2370541-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e5dc5f14-04c1-494b-9044-e837279a7bcd@paulmck-laptop>
References: <e5dc5f14-04c1-494b-9044-e837279a7bcd@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit expands on the ordering properties of rcu_assign_pointer()
and rcu_dereference(), outlining their constraints on CPUs and compilers.

Reported-by: Rao Shoaib <rao.shoaib@oracle.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/whatisRCU.rst | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index 94838c65c7d97..d585a5490aeec 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -250,21 +250,25 @@ rcu_assign_pointer()
 ^^^^^^^^^^^^^^^^^^^^
 	void rcu_assign_pointer(p, typeof(p) v);
 
-	Yes, rcu_assign_pointer() **is** implemented as a macro, though it
-	would be cool to be able to declare a function in this manner.
-	(Compiler experts will no doubt disagree.)
+	Yes, rcu_assign_pointer() **is** implemented as a macro, though
+	it would be cool to be able to declare a function in this manner.
+	(And there has been some discussion of adding overloaded functions
+	to the C language, so who knows?)
 
 	The updater uses this spatial macro to assign a new value to an
 	RCU-protected pointer, in order to safely communicate the change
 	in value from the updater to the reader.  This is a spatial (as
 	opposed to temporal) macro.  It does not evaluate to an rvalue,
-	but it does execute any memory-barrier instructions required
-	for a given CPU architecture.  Its ordering properties are that
-	of a store-release operation.
-
-	Perhaps just as important, it serves to document (1) which
-	pointers are protected by RCU and (2) the point at which a
-	given structure becomes accessible to other CPUs.  That said,
+	but it does provide any compiler directives and memory-barrier
+	instructions required for a given compile or CPU architecture.
+	Its ordering properties are that of a store-release operation,
+	that is, any prior loads and stores required to initialize the
+	structure are ordered before the store that publishes the pointer
+	to that structure.
+
+	Perhaps just as important, rcu_assign_pointer() serves to document
+	(1) which pointers are protected by RCU and (2) the point at which
+	a given structure becomes accessible to other CPUs.  That said,
 	rcu_assign_pointer() is most frequently used indirectly, via
 	the _rcu list-manipulation primitives such as list_add_rcu().
 
@@ -283,7 +287,11 @@ rcu_dereference()
 	executes any needed memory-barrier instructions for a given
 	CPU architecture.  Currently, only Alpha needs memory barriers
 	within rcu_dereference() -- on other CPUs, it compiles to a
-	volatile load.
+	volatile load.	However, no mainstream C compilers respect
+	address dependencies, so rcu_dereference() uses volatile casts,
+	which, in combination with the coding guidelines listed in
+	rcu_dereference.rst, prevent current compilers from breaking
+	these dependencies.
 
 	Common coding practice uses rcu_dereference() to copy an
 	RCU-protected pointer to a local variable, then dereferences
-- 
2.40.1

