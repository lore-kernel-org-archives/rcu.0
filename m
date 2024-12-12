Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F141D199235;
	Thu, 12 Dec 2024 18:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029401; cv=none; b=BkP3z+hMvmYm83oYzGSqCYefV4/tQMPouwDsReCOwDK2dmhVlKspqOxJyLYafNWLtjCzo/32HpL9F51nPsdFJVH/Y+3WUyMjkQSEaVciI80bpi5wcUr+CIWp6zXYxT/dwQmYFMAXf5WLmmuhz56zZM1jDLi36OjMCKukyxScAFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029401; c=relaxed/simple;
	bh=ez8yCvWMVST2UAfIwSmvM8yRLh2m1dbcYOg09od3Kgo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dxm3g86+z2ivPZANuFtQiH/74+qL/fi41XlfYbyi6NRrs7+izL453dgA00e1ACCKcAGQktQ3HEGDa/KmEypuwJ4yrkv3vJWNvf1/ET2imrP15Ey1WlwlbaPLvkzlIolXDpyJiR3ExAoKPzhUJ9NyJpoWb/UOKhf1MGEfYAILhMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUwrqlbP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUwrqlbP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4173C4CEE9;
	Thu, 12 Dec 2024 18:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734029400;
	bh=ez8yCvWMVST2UAfIwSmvM8yRLh2m1dbcYOg09od3Kgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JUwrqlbPRQarGP5dI0LAV8pgKYUkSKf6pGfTwjoFhLjw3+e/z5wPX5e815vTUesPW
	 tjc1qgbBbyDUa26xv3VWlWzbWncMMe5y6AsH/pqVbUR7UM4T2v5GbxMwz+oukbOO+y
	 gTbMMpbORVWSlyoyMRfF6MeRVrPV2H4oNonnFu69ZU9RRC9TSPG4G4Z4I7dN8/OKR3
	 hc89yktl0urAhULJsI8Td5r39CijpjjPXSZWk/xnUd0qcvN8PB8oZQkgMjB5GNnlm5
	 kwC7Zbw3YfnNarXuQHW03Ooz1hs3Umc4sQmMJXLl6LZc3YAfztPoiQ7q1a3zM9G2X/
	 NLllgd5Hc+UZg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D589BCE13BE; Thu, 12 Dec 2024 10:49:59 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 13/18] rcutorture: Add documentation for recent conditional and polled APIs
Date: Thu, 12 Dec 2024 10:49:52 -0800
Message-Id: <20241212184957.2127441-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <62e4d9a4-18ad-49b3-9656-23e17b78033f@paulmck-laptop>
References: <62e4d9a4-18ad-49b3-9656-23e17b78033f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds kernel-parameters.txt documentation for rcutorture's
(relatively) new gp_cond_exp, gp_cond_full, gp_cond_exp, gp_poll,
gp_poll_exp, gp_poll_full, and gp_poll_exp module parameters.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         | 36 ++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 65e5343b46cf9..03d13ca0604fc 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5362,7 +5362,23 @@
 
 	rcutorture.gp_cond= [KNL]
 			Use conditional/asynchronous update-side
-			primitives, if available.
+			normal-grace-period primitives, if available.
+
+	rcutorture.gp_cond_exp= [KNL]
+			Use conditional/asynchronous update-side
+			expedited-grace-period primitives, if available.
+
+	rcutorture.gp_cond_full= [KNL]
+			Use conditional/asynchronous update-side
+			normal-grace-period primitives that also take
+			concurrent expedited grace periods into account,
+			if available.
+
+	rcutorture.gp_cond_exp_full= [KNL]
+			Use conditional/asynchronous update-side
+			expedited-grace-period primitives that also take
+			concurrent normal grace periods into account,
+			if available.
 
 	rcutorture.gp_exp= [KNL]
 			Use expedited update-side primitives, if available.
@@ -5371,6 +5387,24 @@
 			Use normal (non-expedited) asynchronous
 			update-side primitives, if available.
 
+	rcutorture.gp_poll= [KNL]
+			Use polled update-side normal-grace-period
+			primitives, if available.
+
+	rcutorture.gp_poll_exp= [KNL]
+			Use polled update-side expedited-grace-period
+			primitives, if available.
+
+	rcutorture.gp_poll_full= [KNL]
+			Use polled update-side normal-grace-period
+			primitives that also take concurrent expedited
+			grace periods into account, if available.
+
+	rcutorture.gp_poll_exp_full= [KNL]
+			Use polled update-side expedited-grace-period
+			primitives that also take concurrent normal
+			grace periods into account, if available.
+
 	rcutorture.gp_sync= [KNL]
 			Use normal (non-expedited) synchronous
 			update-side primitives, if available.  If all
-- 
2.40.1

