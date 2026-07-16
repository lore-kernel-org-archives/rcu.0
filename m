Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636BF21767D;
	Thu, 16 Jul 2026 00:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161422; cv=none; b=mweeAwIZ1sJN5tXy6NriOmaP0I6o5bjqXDeeVt7jwnoT0g3Nx9xSxf1Aj7aU4VC8bbSyRqXZw0zeycCvL4GfsrEfrHo9GmZLg7UB70EJn021lyPrXuceT9VUhDOiJCJFQtlERWzTBuc7QROJEjmv3rZAXyfJLdkhfAr4kN55JRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161422; c=relaxed/simple;
	bh=EkZRF18fal3/zfiMFfCdfrq65vTfzdrDabPLzL+E9kg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K3baDU5ojQZkZimP+7/ZlucYBeYIHRPsnJCJodN3r+5gM01TFZJv92RBJ+fiNy/kwCfuPCV+vm4lgUJen8wrdGCQuYVCR0FFd4VLrJmzyI3F5yBeixe+LF7UN86EUy8zT5NjxLkKoytbJjupuitSnJZg7pJL/FmguX2M2XjinlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3yphnNP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3yphnNP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332591F00A3F;
	Thu, 16 Jul 2026 00:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161421;
	bh=6v74Vr+JDl4aQFyesJLzqi6KC90vCW4EqJ5C7/ir9F0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O3yphnNPk5vVSejsKG7PnhRH+hm/IEKlZiDuFcYjjUARwXdUjJFjdsPY9Um++vYCA
	 dWMzdGOMTpOHFHotfj6ada33jcsJIBw5ia29TR1qCA18VSjPVqlKI88uhDPOxXBL0P
	 FyfzTm/kayegbognFeC1sSlVEgjyEcZ1I6U61CJ22bPCHJPXvDJgvOqkaORXl9iOfD
	 RZL4upHw92zNJF43LacUc1S9iOqFsi7oGyXT068g6F6saO5DKjJ1dGQLP3n58+ERYg
	 LaT2tRw3NsRRH1Iw8S4ONv6L7RcDcdlLytRkexfxq7j4mtHPnMl6JMElyzevwJXXcH
	 bxPu4TSCM7TcQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EFDBACE0C44; Wed, 15 Jul 2026 17:23:40 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Manuel Ebner <manuelebner@mailbox.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 04/10] doc: RCU: Adopt new coding style of type-aware kmalloc-family - part 2/2
Date: Wed, 15 Jul 2026 17:23:33 -0700
Message-Id: <20260716002339.11717-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bc69cc01-509e-43f8-a46a-d77946e7adc7@paulmck-laptop>
References: <bc69cc01-509e-43f8-a46a-d77946e7adc7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Manuel Ebner <manuelebner@mailbox.org>

Update Documentation/RCU/* to suggest using the new type-aware
kmalloc_obj() per commit 2932ba8d9c99 ("slab: Introduce kmalloc_obj()
and family")

p = kmalloc(...);
 -> p = kmalloc_obj(...);

Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/rcu_dereference.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/rcu_dereference.rst b/Documentation/RCU/rcu_dereference.rst
index 2524dcdadde2b8..5bc3785ebfc2ae 100644
--- a/Documentation/RCU/rcu_dereference.rst
+++ b/Documentation/RCU/rcu_dereference.rst
@@ -236,7 +236,7 @@ precautions.  To see this, consider the following code fragment::
 	{
 		struct foo *p;
 
-		p = kmalloc(...);
+		p = kmalloc_obj(*p);
 		if (p == NULL)
 			deal_with_it();
 		p->a = 42;  /* Each field in its own cache line. */
@@ -293,7 +293,7 @@ Then one approach is to use locking, for example, as follows::
 	{
 		struct foo *p;
 
-		p = kmalloc(...);
+		p = kmalloc_obj(*p);
 		if (p == NULL)
 			deal_with_it();
 		spin_lock(&p->lock);
-- 
2.40.1

