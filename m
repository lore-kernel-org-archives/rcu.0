Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D2F231827;
	Thu, 16 Jul 2026 00:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161096; cv=none; b=JFrwoBw7AALi+jhvFzXIFJaDNZeC505t7pnsi0C14Or7LdgD9T4P55JH/8Wp+V1UjbfyO/JWD7wvSkryDutYoyfZoqloWFV3T/y6+0oxEPZ6poMiYup+hVnD7QwlXKYnKCvc5YCBpYbXPkKiajj79Xwx7nBsb5pa/SCOnnkDhXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161096; c=relaxed/simple;
	bh=nJ1ctnOBPalzNp6ZnLD2UE5OKoMg8XFO+FWhVnoARMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ksE1Nh+NZJsx8g78VxtAnQ9nYqE/VUAL6hMqtnTNLNH4MFX/41OKify2WicR0jBYbMvlX/k3BHjDBlvCIviiSBdmeaV2xdn61EYPCMo61lic6SPrgqtCbFl56+LO3DA2uasxt7qpvdvIAGa2rpoyhRW3BeKHfO9g94PXmrLQzaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFqqpjyA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFqqpjyA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD131F00A3F;
	Thu, 16 Jul 2026 00:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161091;
	bh=vcVacDQqDFrvp1JfQX66udVDl3nvOv16wymKh+hFy3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kFqqpjyABQQknFAjJXX+878VqVnehCq0zqPLDkmozkjbqu+RQtNg4nTHgMm88gNmw
	 MxVHLIYmDS2tHLO91ddeZ9h/UyxQkdXzjv8uSJpn+HTBc8uH/U4ZLdTRPl3UxUf+kY
	 JDpBAki+YOvKB6nFNo3arNd5zJ8wWPTSkdZ1PBrVaDRNi5u64jsSPG/slId1AFQ6m2
	 191FxvoXdwCL9OZR7E/j+rZ4hJcpxEgTxSUcm6E7dSJQYQULmH0w8xTx3AfOp8nDxm
	 Nfd1hvcH/XqxiHmfN6Uysu95gf4ut/LnrPPBkb0jWnl9tG9E8cXsemhYixQBIyw8fP
	 AfDtsCEMY6+1A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 45596CE0F42; Wed, 15 Jul 2026 17:18:11 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC v2 14/24] hazptrtorture: Pass hazptr_pending to hazptr_torture_reader_tail()
Date: Wed, 15 Jul 2026 17:17:59 -0700
Message-Id: <20260716001809.11084-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <23e34c2e-67fd-45da-b130-e70a131a59ea@paulmck-laptop>
References: <23e34c2e-67fd-45da-b130-e70a131a59ea@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit passes a hazptr_pending structure instead of a pair of
pointers to the hazptr_torture_reader_tail() function in order to make it
easier to test the releasing of hazard pointers from interrupt handlers.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/hazptrtorture.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index 266fecb00105f9..625ed90912a2c6 100644
--- a/kernel/rcu/hazptrtorture.c
+++ b/kernel/rcu/hazptrtorture.c
@@ -368,9 +368,11 @@ static void hazptr_torture_acquire(void *hppp_in)
  * be invoked from hazptr_torture_reader, but also for hazard pointers
  * sent off to interrupt handlers and the like.
  */
-static void hazptr_torture_reader_tail(struct hazptr_ctx *hcp, struct hazptr_torture *htp,
-				       struct torture_random_state *trsp)
+static void
+hazptr_torture_reader_tail(struct hazptr_pending *hppp, struct torture_random_state *trsp)
 {
+	struct hazptr_ctx *hcp = &hppp->hpp_hc;
+	struct hazptr_torture *htp = hppp->hpp_htp;
 	int pipe_count;
 
 	cur_ops->read_delay(trsp);
@@ -453,7 +455,7 @@ static int hazptr_torture_reader(void *arg)
 			hazptr_torture_defer(hppp, &rand);
 			hppp = NULL;
 		} else {
-			hazptr_torture_reader_tail(&hppp->hpp_hc, hppp->hpp_htp, &rand);
+			hazptr_torture_reader_tail(hppp, &rand);
 		}
 		while (!torture_must_stop() &&
 		       (torture_num_online_cpus() < mynumonline || !rcu_inkernel_boot_has_ended()))
@@ -479,7 +481,7 @@ static void hazptr_torture_do_one_pending(int cpu, struct torture_random_state *
 	if (!llnp)
 		return;
 	llist_for_each_entry_safe(hppp, hppp1, llnp, hpp_node) {
-		hazptr_torture_reader_tail(&hppp->hpp_hc, hppp->hpp_htp, trsp);
+		hazptr_torture_reader_tail(hppp, trsp);
 		kfree(hppp);
 	}
 }
-- 
2.40.1

