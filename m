Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC8A44DB69;
	Thu,  7 May 2026 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778172679; cv=none; b=tmPurXc6lFcp4TfUlllEctINRUIZ693g6SvSAT4MN6rWgDCmrJXYZu3h442MsFytDHkNfCYBYDfrnukUqmpylCmxctBSC0/1Kj2KxO53v237fN+DJb5Fuczk9e/x3gJpr73VlfeNd4yzMUsT3qq3gny9LOmKYy48jAu1UJuly7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778172679; c=relaxed/simple;
	bh=QIsa2Ppg+z+bISJFMsl94LIGmvzARp866G06o2jW2hg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O5pDgyEoQmSer9Hjm7FJUEIX5aTAQtWGiy2ewp+BpdXJB1DcqNZ2eHkcKlBiReSSyz306JWCe/zc7iBhXHVqjm8P4ZbcWvu/drIjmCOHWUoZr0dBZOIjPASft65PTsY8jch9DDcq4WEynwe6ETEQ+ZZlRzWSjK3ziv/MtuLTnk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHr2nqoP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHr2nqoP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1D1C2BCB2;
	Thu,  7 May 2026 16:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778172679;
	bh=QIsa2Ppg+z+bISJFMsl94LIGmvzARp866G06o2jW2hg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HHr2nqoPkZBVyhSyBJOIaN2A+RLKvFoiVwgyfY9fZesMYoWHqEJCwlSZ30Vo4nuoH
	 Q+9MLKxV/6Lb4Iu2MtXhqurkUOjFllk3kPtTF6jo3ramWzvZGSma7nrKw+WSoc+xG5
	 mLJn6Qo7+hiAiPxsmEqpPj3eVvo8LKLo26jar2DX84MVKcElJLcqH4li/pneygzknJ
	 WFMXqDhNAjtGdy75uXAsv5IhYfDwGchAiNRSG4q17fUw/r4XMEqETJWyOb+gRqlj/e
	 5qvpO+PetGG85CdpcMGAcIKV2m/YntDrAoDTP8R1mY62qfBDH1PVIGxANH2bzAyQZ+
	 4+OiTk4SEjBCA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 40C46CE0863; Thu,  7 May 2026 09:51:19 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 4/4] hazptrtorture: Enable system-independent CPU overcommit
Date: Thu,  7 May 2026 09:51:13 -0700
Message-Id: <20260507165113.2039524-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <5bfe6ac9-432e-43b8-8290-59ca249b0f80@paulmck-laptop>
References: <5bfe6ac9-432e-43b8-8290-59ca249b0f80@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit interprets negative values of the nreaders module parameter
as a number of readers per CPU, so that hazptrtorture.nreaders=-5 would
spawn five hazard-pointer reader kthreads per CPU.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/hazptrtorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index 219fd90a7f8840..c266d0b64dfde1 100644
--- a/kernel/rcu/hazptrtorture.c
+++ b/kernel/rcu/hazptrtorture.c
@@ -631,7 +631,7 @@ static int __init hazptr_torture_init(void)
 	if (nreaders >= 0) {
 		nrealreaders = nreaders;
 	} else {
-		nrealreaders = num_online_cpus() - 2 - nreaders;
+		nrealreaders = num_online_cpus() * -nreaders;
 		if (nrealreaders <= 0)
 			nrealreaders = 1;
 	}
-- 
2.40.1

