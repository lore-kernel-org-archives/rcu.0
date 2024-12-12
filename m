Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30380189916;
	Thu, 12 Dec 2024 18:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029488; cv=none; b=Y5spPHacE/EwRALS3gEVXLBpZ6YgJWogdSsIh2PVaW998mtyaFFVVSxedhdxW1vQTbhkOe9R645nXsa52irAZiJqdye/fo3UZhPx80VxGTr/Z4NuQw3PfAcQtHbuVZFC3H8MYKNTAeO6EOqmIzTbzWM4sen5F/P6itEmjCJ0HCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029488; c=relaxed/simple;
	bh=C7eNfOunp8AOccxcceOKWVykhMqpmtYNlnqR2il+3Gc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zf6iceB3C2ZsH++1/oU98KyxYpQmbaAIQ8zUMIdFE6BC66WOZqEXMSftdYJlwf5F/77nncElnZDBzodJrNfDHAnfl0zKY4aUIpmZZWIrBvfHqD726MEyM233b+X1mCaFZecL/H0oP51HInuqxBE5/GVAhoAsXi/3JaVx06aMBHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RN4VUq9O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RN4VUq9O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D21EC4CED0;
	Thu, 12 Dec 2024 18:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734029488;
	bh=C7eNfOunp8AOccxcceOKWVykhMqpmtYNlnqR2il+3Gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RN4VUq9Oxsjo5YltAnWWVlFXi278Tsgtnyn/WOGxBNqiNBUV3CrgVZMxN3gm+1xQq
	 zb/2qBcc1I1Rz/zW7i2GmWPRx/p+IUIMIfaj3D55cPfw1exEdJ1OstvZGtNGuI5KQS
	 ucJPg7rUz0QiSV6EeJg3vJdVsbulyX+q6thXHcSyaNcxEvx1vk5TDK6PzR3nGPFCh1
	 NOeEsP6o1/eEKkhReGdTkkg3UiPQ9/R3r8rWt5jKGd0gwNqY7kmPrmxPap6yZJK07U
	 DX4MEPwZ7Lb4+F7HwDgf/5RVlhYnAwP7h1qZbe7R3YCbx/N/o3sncr1om250BhjxRQ
	 NB9OGX0BRv+6A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C3B68CE0F78; Thu, 12 Dec 2024 10:51:27 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH rcu 2/3] srcu: Fix typo s/srcu_check_read_flavor()/__srcu_check_read_flavor()/
Date: Thu, 12 Dec 2024 10:51:25 -0800
Message-Id: <20241212185126.2193701-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c330fdd2-91b6-42f4-b28e-cf35dfd165b7@paulmck-laptop>
References: <c330fdd2-91b6-42f4-b28e-cf35dfd165b7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit fixes a typo in which a comment needed to have been updated
from srcu_check_read_flavor() to __srcu_check_read_flavor().

Reported-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Closes: https://lore.kernel.org/all/b75d1fcd-6fcd-4619-bb5c-507fa599ee28@amd.com/
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 490aeecc6bb47..4e69f88bcab9f 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -258,7 +258,7 @@ static inline void srcu_check_read_flavor_lite(struct srcu_struct *ssp)
 	if (likely(READ_ONCE(sdp->srcu_reader_flavor) & SRCU_READ_FLAVOR_LITE))
 		return;
 
-	// Note that the cmpxchg() in srcu_check_read_flavor() is fully ordered.
+	// Note that the cmpxchg() in __srcu_check_read_flavor() is fully ordered.
 	__srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_LITE);
 }
 
-- 
2.40.1

