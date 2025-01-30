Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0431F153A;
	Thu, 30 Jan 2025 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263800; cv=none; b=Bb5d1zmNAcXyGPfi/CRtaeDpa6n/Gg8+92q/IrZwgSYvO+/t+Coq7ARMbuR7q+dSybeVwr5yymW8keb/NGi4U4ilD+kZQeVvb0qIvPQfjGIvVmyU/+jnyGrQTO7wibDvHnY3CiKJf3pfclF7UJoSUiAKQM/113QkkSZ7GGQDVPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263800; c=relaxed/simple;
	bh=LnmdL188NqHxw3lfVetaHFxF6Y2A5ACDtvpGDB0Bd6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZdJiAWhLZVlVU3uwfWFzt9DE3OUnIa6FZWSK+2Gp/33dOECpzP74pUfmGEpCgWC5cTP7xNgbsdsYInIs6kdTo7Id4H/4qVtHI2pZV4Hm1j2MeXRXTM8RCbZWp/T15MlEdaVOqmv4BfUI3LA5oYKplnEDNkcaCDy7aq+EpNO+WJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jam1cppR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jam1cppR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF773C2BCB3;
	Thu, 30 Jan 2025 19:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263799;
	bh=LnmdL188NqHxw3lfVetaHFxF6Y2A5ACDtvpGDB0Bd6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jam1cppR+8cWvYRYtsTPVaa7kvN8riz12/ldGxTy4f15WVnsC8iDTNMzmYy0MEgeN
	 a3yceUkJ+hdwlLuKLpeoZURHTpeA1wdSqk6897NigoqV68atfytFO8HLD4mGUfA3Md
	 jSfkG92Eql/e8VEdlelzJTyP0RaCjmM2/DWpcRy4AfEPbp82NvwtBj1UCGjB106mOT
	 3S6U149vVcw43ABy6Eo7pWLFOm60tGfOThg1TNtbAglaZFj1we07GGBRU5cCF3kSLO
	 7yNgZQmR0JCkxV3Ee6socdwRbqGy7D84aKI2yN2WfOMcPMeLpMSY3BQTd4lZ+iFshs
	 QuNX9GqRaqdgA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0A18CCE3807; Thu, 30 Jan 2025 11:03:19 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu v2] 16/20] rcutorture:  Make scenario SRCU-P use srcu_read_lock_fast()
Date: Thu, 30 Jan 2025 11:03:13 -0800
Message-Id: <20250130190317.1652481-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <1034ef54-b6b3-42bb-9bd8-4c37c164950d@paulmck-laptop>
References: <1034ef54-b6b3-42bb-9bd8-4c37c164950d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit causes the rcutorture SRCU-P scenario use the
srcu_read_lock_fast() and srcu_read_unlock_fast() functions.  This will
cause these two functions to be regularly tested by several developers
(myself included), for example, those who use torture.sh as an RCU
acceptance test.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-P.boot | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-P.boot b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-P.boot
index 2db39f298d18..fb61703690cb 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-P.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-P.boot
@@ -2,3 +2,4 @@ rcutorture.torture_type=srcud
 rcupdate.rcu_self_test=1
 rcutorture.fwd_progress=3
 srcutree.big_cpu_lim=5
+rcutorture.reader_flavor=0x8
-- 
2.40.1

