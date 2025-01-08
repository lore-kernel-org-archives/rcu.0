Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F215012B94;
	Wed,  8 Jan 2025 19:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736364321; cv=none; b=frJ880anGBTi1+dKXVZR9L42DM60uvozZ7OdFLaieEjmjNyebwK84tO2AwcS+/JKQImEETIlnLINIzZhlwc3FdaqEGXNSRyGYVbBrMyybonR0XjpEZGlsREvi+ftfaDHu7R1I3sa5Vz90RLCPjneSZjbRqIzqO0sPTfAKbbq5eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736364321; c=relaxed/simple;
	bh=pToxrxuwuVV5i7v7HpyU1AY0oSaMhTW/WsB+SJBRl8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bNYjlrawaAJRXuRD4Jc4LvMK63yUXkVVslYBpmtyL3/JBzjdMIrXBeoWxTLNuzAW8ssPiMamMZ1+7kNbiPUH/jPoH3arhDkl+AtsHzM6JE3Y1zvr1NW7/e/3txPW7Zur7gL2lPPzoN2erar367aNjRU/CQ/K/Nlm/O/EYPujxwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com; spf=pass smtp.mailfrom=davidreaver.com; dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b=OV7JNaro; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=THpOaxgr; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidreaver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b="OV7JNaro";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="THpOaxgr"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 056F2114021E;
	Wed,  8 Jan 2025 14:25:17 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 08 Jan 2025 14:25:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1736364317; x=1736450717; bh=k0TiT8NJQ0
	ou5s6Be67JpUqc2GDSn/4DMCGmVF3GrWY=; b=OV7JNaro8FunOxZV6Rv9cCWSxm
	0UVxARC+GwJenbtNbKpxgjoU9RoenZ1OpKgRfLSflv7uin322kv1tr12LqPlGijR
	UQ99eSwp+fCp52JmM7+5YVigfibbzU3C6tpdUDb5M5QlNTzD8x7rnHU0zxlzjOEn
	CkMP3tm+33EEQh9d09ctGAFdKhqpr48d8x9xVNVE9c6aOYTjs+1WRelEMKgX4zms
	SNslb3wDSsOdFkVt6gDS9nPKkNwKmxqKrMmppCb0WY6HOyTB7Kd8Mj355FlYdqRU
	qxPeb7BQj3QuWwQU+U9Zq0PFLelh3GN7jJkbUHUU4P6wbU+Ds0iQ/s5rRiag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736364317; x=1736450717; bh=k0TiT8NJQ0ou5s6Be67JpUqc2GDSn/4DMCG
	mVF3GrWY=; b=THpOaxgrPR+I53kjD8wf9iu09dIaGoiYH6+53aSObtXzZ7OFQP7
	bNHC+3+W/XkpFhqTDN0TdUzOUFwdbzr02wOiI8k2yKyEyL/X5ul+6zyBEG28Yeyl
	rWsMuJTaLMJcq9ctXqdz2UrYYVMeP59vHbu5oMjkQRsdCgiPyWsoDgPJZuEW9TOB
	x9nxzVRzVQ54+g8oMJtAjC75NTOQjL7UBOKJCnpS4xDI+7Zb3GMv4o3jioEb2S/v
	xoVwkY/woNLRwESNCYyXu4yuqFO4anMCCQNm0S/x4Bh8DpyH0cCvsnPDhlhyEsw8
	ny+DoL9rh8aMQs5OVI84MZbeofAkeqD8qiQ==
X-ME-Sender: <xms:HNF-Z57IOkN3pFlMVzDDJbssAU3kQbN63OuyTszA5tb0btDvqxNY7w>
    <xme:HNF-Z257461OH4dkvN0ToZCKa2OMLk9zFxUVg9a2OBGHJ03GzT62ZsycZucZUx4cB
    Qd_81JQtgA5sLa2i44>
X-ME-Received: <xmr:HNF-Zwe6iI9ZySO1PWoxYx4ill6C6jd-CXfU-2zLRdPD1IZt2E8rIui9idQI7lPztaPFLSkZbjTI-OOaQlIjPoKDGLRJM79cHyWQx8hrnHkd0Uo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecu
    hfhrohhmpeffrghvihguucftvggrvhgvrhcuoehmvgesuggrvhhiughrvggrvhgvrhdrtg
    homheqnecuggftrfgrthhtvghrnhepheetveetgfdvffehfeffieeugeejhfevieejveei
    vdeuiefgvdduueffhfefveehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgesuggrvhhi
    ughrvggrvhgvrhdrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtoheprghpfiestggrnhhonhhitggrlhdrtghomhdprhgtphhtthhopehj
    ohgvsehpvghrtghhvghsrdgtohhmpdhrtghpthhtohepugifrghiphgrhigrnhhrrgihud
    esghhmrghilhdrtghomhdprhgtphhtthhopehluhhkrghsrdgsuhhlfigrhhhnsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepphgruhhlmhgtkheslhhinhhugidrihgsmhdrtghomh
    dprhgtphhtthhopehmvgesuggrvhhiughrvggrvhgvrhdrtghomhdprhgtphhtthhopehr
    tghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrh
    hnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhjlhigsehtvghm
    phhlvghofhhsthhuphhiugdrtghomh
X-ME-Proxy: <xmx:HNF-ZyLrsMl-lYO00_pWFhQueT0N3tDUxNy5ZqHVI8_BMehKt8NRzQ>
    <xmx:HNF-Z9JtME_PeE_quieSSpvCcOZrejMx_rV3yrqTl07GFRMGBpSPxA>
    <xmx:HNF-Z7wKyBQbVCRFk8i4QUJDXS9ZVdToPx4UyLBkAS72z0CH92N-qg>
    <xmx:HNF-Z5ILv_IkcCH_I_joF8JMxEhwYT1H6fA2rzYX2S0zNTYu1XdSqw>
    <xmx:HNF-Z2UYPwCyg1h8KnF9gFdFX8EREHEExppGSWvdq_5HS2HygxtezAsl>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jan 2025 14:25:15 -0500 (EST)
From: David Reaver <me@davidreaver.com>
To: Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	"Paul E . McKenney" <paulmck@linux.ibm.com>
Cc: David Reaver <me@davidreaver.com>,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krister Johansen <kjlx@templeofstupid.com>
Subject: [PATCH] checkpatch: Remove migrated RCU APIs from deprecated_apis
Date: Wed,  8 Jan 2025 11:24:54 -0800
Message-ID: <20250108192456.47871-1-me@davidreaver.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The deprecated_apis map was created in [1] so checkpatch would flag
deprecated RCU APIs. These deprecated APIs have since been removed from the
kernel. This patch removes them from this map so checkpatch doesn't waste
time looking for them, and so readers of checkpatch looking for deprecated
APIs don't waste time searching for them.

Link: https://lore.kernel.org/all/20181111192904.3199-13-paulmck@linux.ibm.com/ [1]

Signed-off-by: David Reaver <me@davidreaver.com>
---
 scripts/checkpatch.pl | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9eed3683ad76..842a39a01af1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -834,1 +834,1 @@ foreach my $entry (@mode_permission_funcs) {
 $mode_perms_search = "(?:${mode_perms_search})";

 our %deprecated_apis = (
-	"synchronize_rcu_bh"			=> "synchronize_rcu",
-	"synchronize_rcu_bh_expedited"		=> "synchronize_rcu_expedited",
-	"call_rcu_bh"				=> "call_rcu",
-	"rcu_barrier_bh"			=> "rcu_barrier",
-	"synchronize_sched"			=> "synchronize_rcu",
-	"synchronize_sched_expedited"		=> "synchronize_rcu_expedited",
-	"call_rcu_sched"			=> "call_rcu",
-	"rcu_barrier_sched"			=> "rcu_barrier",
-	"get_state_synchronize_sched"		=> "get_state_synchronize_rcu",
-	"cond_synchronize_sched"		=> "cond_synchronize_rcu",
 	"kmap"					=> "kmap_local_page",
 	"kunmap"				=> "kunmap_local",
 	"kmap_atomic"				=> "kmap_local_page",
