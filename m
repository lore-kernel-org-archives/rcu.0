Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C928F5A;
	Wed,  2 Jul 2025 00:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751415815; cv=none; b=BrLOWUouGGs7FrTlGK7bGAq+UXY8mkq94kPT46kN9phtTwVeuh9Bic5Q6dOJAribcLgMAR1z+rXLK+KKnIKYuxLUaVwmzkjwXbkRrr5hefyF9d0kJXAc+IXnx/VzStWWyJHvdVobjDyqB4KoTXR1ny+xvc9vFmLrf9luSyARNXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751415815; c=relaxed/simple;
	bh=hiG2dozkfroWs4r9hztHnvCE1r/k/oQA4zHOw7idPa0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RWsuXJBZy9l9HIQ5rlbvWGjCJ8GVgPVrJmiaGFrSU2UOkZkGCOwMD3sp3M0MQhbEKTJYFeG/lF1Zrz09sY3cBfQof9W+hhwQaY6XlZgcKg8hXpWAveSlRLfFqn3rOVRGPri8fh125Ycr8uJFhxvW48DbbE76lXmkxC5mKIIK9zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4C6e9xU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4C6e9xU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E48C4AF0B;
	Wed,  2 Jul 2025 00:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751415815;
	bh=hiG2dozkfroWs4r9hztHnvCE1r/k/oQA4zHOw7idPa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O4C6e9xUXLvZa3IfX//2Nmg3dvDkieZ8X5pJK3p6DIwWCLaGYHNQDFz28iK/TOSpI
	 su+AQOX6+qaaLlYctZJik4wdrOq3j4hYypzOIr4HWS767DfN6W80GeIYaUsULtDw0G
	 sEalCq8dMeI4z+wVVpY6qhs86yK7OVCIzISK7S5W39jQH0eNxFjvaN61TI2fRp1PK/
	 /ze3q1m4doVAGDu0lgVr8OVfG8NFtb549Th671VJDYY9CxDRp+Qwd50Ks54+Wunicv
	 ha+ccBOZg0nKqLNqfwnzWms95lM61os7qRDmmiQl+kpkUblPUq1VwEbUsynFqKAQnI
	 KREffigb0BL9w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 92131CE0EAA; Tue,  1 Jul 2025 17:23:34 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Christoph Hellwig <hch@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 5/5] checkpatch: Remove SRCU-lite deprecation
Date: Tue,  1 Jul 2025 17:23:30 -0700
Message-Id: <20250702002330.1074433-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2994ade2-bd06-4ba7-bcc9-be4d0d15ea0c@paulmck-laptop>
References: <2994ade2-bd06-4ba7-bcc9-be4d0d15ea0c@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that SRCU-lite has been removed from the kernel, let's remove the
now-redundant deprecation from checkpatch.pl.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 scripts/checkpatch.pl | 2 --
 1 file changed, 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 664f7b7a622c2..867c7b6fd839f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -857,8 +857,6 @@ our %deprecated_apis = (
 	"kunmap"				=> "kunmap_local",
 	"kmap_atomic"				=> "kmap_local_page",
 	"kunmap_atomic"				=> "kunmap_local",
-	"srcu_read_lock_lite"			=> "srcu_read_lock_fast",
-	"srcu_read_unlock_lite"			=> "srcu_read_unlock_fast",
 );
 
 #Create a search pattern for all these strings to speed up a loop below
-- 
2.40.1

